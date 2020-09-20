--#cadastrar_equipe#
    BEGIN TRY
        BEGIN TRAN 

            INSERT INTO 
                torneio..equipe 
                (
                    toplane, 
                    jungle, 
                    midlane, 
                    carry, 
                    suporte, 
                    nomeTime, 
                    numero, 
                    datacad, 
                    pago, 
                    status, 
                    apagado, 
                    senha,
                    qtd
                )
                values 
                (
                    @top,
                    @jg,
                    @mid,
                    @adc,
                    @sup,
                    @time,
                    @numero,
                    getdate(),
                    0,
                    0,
                    0,
                    @senha,
                    0
                )

            insert into torneio..usuario values (@top, 'Top Lane', 0, 0, 0, @time)
            insert into torneio..usuario values (@jg, 'Jungle', 0, 0, 0, @time)
            insert into torneio..usuario values (@mid, 'Mid Lane', 0, 0, 0, @time)
            insert into torneio..usuario values (@adc, 'Adc', 0, 0, 0, @time)
            insert into torneio..usuario values (@sup, 'Suporte', 0, 0, 0, @time)
                    
        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH
--END#cadastrar_equipe#

--#consulta_equipe#
    select 
        *
    from 
        torneio..equipe 
    where 
        apagado=0 and id not in (1)
--END#consulta_equipe#

--#consulta_abate#
    select top 5 * from (
        select
                nick, 
                abate, 
                nometime,
                cast(ROW_NUMBER()OVER(
                    ORDER BY cast(abate as int) desc, nick asc
                ) as int) as [number]
            from 
                usuario
            where id not in (1) and
                cast(abate as int)>=0)tbl where tbl.number in (1,2,3,4,5)
    order by 
        cast(abate as int) desc
--END#consulta_abate#

--#consulta_assist#
    select top 5 * from (
        select
                nick, 
                asist, 
                nometime,
                cast(ROW_NUMBER()OVER(
                    ORDER BY cast(asist as int) desc, nick asc
                ) as int) as [number]
            from 
                usuario
            where id not in (1) and
                cast(asist as int)>=0)tbl where tbl.number in (1,2,3,4,5)
    order by 
        cast(asist as int) desc
--END#consulta_assist#

--#login#
    select 
        * 
    from 
        equipe 
    where 
        apagado = 0 and 
        nomeTime = cast(@equipe as varchar(max))
--END#login#

--#qtdpag#
    update 
        equipe 
    set 
        qtd=(qtd+1) 
    where 
        id = @id
--END#qtdpag#

--#data_jogos#
    select 
        j.rodada
        ,j.jogo
        ,e1.nomeTime [time1]
        ,e2.nomeTime [time2]
        ,j.data_jogo_texto
        ,'vs' as [vs]
    from 
        jogos j
        left join equipe e1 on e1.id=j.t1
            and e1.apagado=0
        left join equipe e2 on e2.id=j.t2
            and e2.apagado=0
--END#data_jogos#

--#espera_cadastrar#
    BEGIN TRY
        BEGIN TRAN 

            INSERT INTO 
                torneio..equipe_espera
                (
                    toplane, 
                    jungle, 
                    midlane, 
                    carry, 
                    suporte, 
                    nomeTime, 
                    senha, 
                    apagado, 
                    status, 
                    equipe, 
                    datacad
                )
                values 
                (
                    @top,
                    @jg,
                    @mid,
                    @adc,
                    @sup,
                    @time,
                    @senha,
                    0,
                    0,
                    0,
                    getdate()
                )

        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH
--END#espera_cadastrar#

--#espera_consulta#
    select 
        *
    from 
        torneio..equipe_espera
    where 
        apagado=0
--END#espera_consulta#

--#espera_consulta_id#
    select 
        *
    from 
        torneio..equipe_espera
    where 
        apagado=0 and id=@id
--END#espera_consulta_id#

--#espera_cadastrar_pedido#
    BEGIN TRY
        BEGIN TRAN 

            INSERT INTO 
                torneio..pedido_espera
                (
                    id_equipe_espera,
                    lane,
                    nick,
                    mensagem,
                    aprovado,
                    apagado,
                    datacad,
                    dataalt
                )
                values 
                (
                    @id_equipe,
                    @lane,
                    @nick,
                    @mensagem,
                    0,
                    0,
                    getdate(),
                    null
                )

        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH
--END#espera_cadastrar_pedido#

--#espera_login#
    select 
        * 
    from 
        equipe_espera 
    where 
        apagado = 0 and 
        nomeTime = cast(@equipe as varchar(max))
--END#espera_login#

--#espera_mensagem#
    select 
        p.id,
        p.lane,
        p.nick,
        p.aprovado,
        p.mensagem
    from 
        equipe_espera e
        inner join pedido_espera p on p.id_equipe_espera=e.id
            and e.id=@id
            and e.apagado=0
            and p.apagado=0
    order BY p.aprovado
--END#espera_mensagem#

--#espera_mensagem_deletar#
BEGIN TRY
        BEGIN TRAN 

            update 
                pedido_espera 
            set 
                apagado=1 
            where 
                id = @id
                    
        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Mensagem apagado com sucesso" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Não deletado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH 
--END#espera_mensagem_deletar#



