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
                    datacad,
                    dataEnvioWhats,
                    qtdEnvioWhats
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
                    getdate(),
                    null,
                    0
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

--#entrarTorneio_id#

    EXEC [torneio].[dbo].[SP_equipe_espera_entrar_torneio] @id


    -- BEGIN TRY
    --     BEGIN TRAN 
    --         INSERT into equipe
    --             select 
    --                 toplane
    --                 ,jungle
    --                 ,midlane
    --                 ,carry
    --                 ,suporte
    --                 ,nomeTime
    --                 ,''
    --                 ,getdate()
    --                 ,0
    --                 ,[status]
    --                 ,apagado
    --                 ,senha
    --                 ,0
    --             from 
    --                 equipe_espera 
    --             where 
    --                 toplane <> '' and 
    --                 jungle  <> '' and 
    --                 midlane <> '' and 
    --                 carry   <> '' and 
    --                 suporte <> '' and 
    --                 id=@id

    --             update equipe_espera set apagado=2 where id=@id
    --             insert into torneio..usuario values ((select toplane from equipe_espera where id = @id), 'Top Lane', 0, 0, 0, (select nomeTime from equipe_espera where id = @id))
    --             insert into torneio..usuario values ((select jungle from equipe_espera where id = @id), 'Jungle', 0, 0, 0, (select nomeTime from equipe_espera where id = @id))
    --             insert into torneio..usuario values ((select midlane from equipe_espera where id = @id), 'Mid Lane', 0, 0, 0, (select nomeTime from equipe_espera where id = @id))
    --             insert into torneio..usuario values ((select carry from equipe_espera where id = @id), 'Adc', 0, 0, 0, (select nomeTime from equipe_espera where id = @id))
    --             insert into torneio..usuario values ((select suporte from equipe_espera where id = @id), 'Suporte', 0, 0, 0, (select nomeTime from equipe_espera where id = @id))
            
    --         COMMIT TRAN
    --         SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    -- END TRY
    -- BEGIN CATCH                    
    --     ROLLBACK TRAN   
    --         SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    -- END CATCH

--END#entrarTorneio_id#

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
                apagado=1,
                dataalt=getdate()
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

--#espera_mensagem_lida#
    BEGIN TRY
        BEGIN TRAN 

            update 
                pedido_espera 
            set 
                aprovado=1,
                dataalt=getdate()
            where 
                id = @id
                    
        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Mensagem apagado com sucesso" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Não deletado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH 
--END#espera_mensagem_lida#

--#espera_mensagem_rejeitar#
    BEGIN TRY
        BEGIN TRAN 

            update 
                pedido_espera 
            set 
                aprovado=3,
                dataalt=getdate()
            where 
                id = @id
                    
        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Mensagem apagado com sucesso" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Não deletado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH 
--END#espera_mensagem_rejeitar#

--#espera_mensagem_aprovar#
    DECLARE @laneSQL varchar(max)
    DECLARE @statusSQL varchar(max)
    DECLARE @nickSQL varchar(max)
    DECLARE @idSQL int

    set @laneSQL=@lane
    set @idSQL=@id
    set @nickSQL=@nick

    if @laneSQL='top'
    BEGIN
        select 
            @statusSQL = case toplane
                when '' then 'toplane'
                else 'erro'
            end
        from 
            equipe_espera 
        where 
            id=@idSQL
            and apagado=0
    END
    if @laneSQL='jg'
    BEGIN
        select 
            @statusSQL = case jungle
                when '' then 'jungle'
                else 'erro'
            end
        from 
            equipe_espera 
        where 
            id=@idSQL
            and apagado=0
    END
    if @laneSQL='mid'
    BEGIN
        select 
            @statusSQL = case midlane
                when '' then 'midlane'
                else 'erro'
            end
        from 
            equipe_espera 
        where 
            id=@idSQL
            and apagado=0
    END
    if @laneSQL='adc'
    BEGIN
        select 
            @statusSQL = case carry
                when '' then 'carry'
                else 'erro'
            end
        from 
            equipe_espera 
        where 
            id=@idSQL
            and apagado=0
    END
    if @laneSQL='sup'
    BEGIN
        select 
            @statusSQL = case suporte
                when '' then 'suporte'
                else 'erro'
            end
        from 
            equipe_espera 
        where 
            id=@idSQL
            and apagado=0
    END
    if @statusSQL!='erro'
    BEGIN
        if @statusSQL = 'toplane'
        BEGIN
            update equipe_espera set toplane=@nickSQL where id=@idSQL
        END

        if @statusSQL = 'jungle'
        BEGIN
            update equipe_espera set jungle=@nickSQL where id=@idSQL
        END

        if @statusSQL = 'midlane'
        BEGIN
            update equipe_espera set midlane=@nickSQL where id=@idSQL
        END

        if @statusSQL = 'carry'
        BEGIN
            update equipe_espera set carry=@nickSQL where id=@idSQL
        END

        if @statusSQL = 'suporte'
        BEGIN
            update equipe_espera set suporte=@nickSQL where id=@idSQL
        END

        update pedido_espera set aprovado=2, dataalt=getdate() where id = @idpedido

    END

    select @statusSQL as resultado 
--END#espera_mensagem_aprovar#

--#gettoken#
    select *,DATEDIFF(HOUR,datacad,getdate())as dif from tbiApilol
--END#gettoken#

--#bolao_jogos#
   select 
        j.*,
        e1.nome_equipe [equipe_1],
        e2.nome_equipe [equipe_2],
        e1.foto_equipe [foto_1],
        e2.foto_equipe [foto_2]
    from 
        bolao.jogos j
        inner join bolao.equipes e1 on e1.id=j.id_time1
            and j.pagination=1
        inner join bolao.equipes e2 on e2.id=j.id_time2 
--END#bolao_jogos#

--#bolao_jogos_page#
   select 
        j.*,
        e1.nome_equipe [equipe_1],
        e2.nome_equipe [equipe_2],
        e1.foto_equipe [foto_1],
        e2.foto_equipe [foto_2]
    from 
        bolao.jogos j
        inner join bolao.equipes e1 on e1.id=j.id_time1
            and j.pagination=@page
        inner join bolao.equipes e2 on e2.id=j.id_time2 
--END#bolao_jogos_page#

--#bolao_consulta_usuario#
   select nick,login from bolao.usuario where apagado=0
--END#bolao_consulta_usuario#

--#bolao_cadastrar_usuario#
    BEGIN TRY
        BEGIN TRAN 

            insert bolao.usuario values (@nick, @nome, @login, @senha, getdate(), 0,0) 
                    
        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH
--END#bolao_cadastrar_usuario#

--#bolaocadastrarpalpite#
    BEGIN TRY
        BEGIN TRAN 

            insert bolao.palpite values (@id_usuario, @jogo, @palpite, @page, 0, getdate(), null) 
                    
        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH
--END#bolaocadastrarpalpite#

--#bolao_login#
    select 
        * 
    from 
        bolao.usuario 
    where 
        apagado = 0 and 
        login = cast(@login as varchar(max))
--END#bolao_login#

--#cad_consulta#
    select * from nick where apagado=0 and nick=@nick
--END#cad_consulta#

--#cad_cadastrar#
    BEGIN TRY
        BEGIN TRAN 

            insert into nick
                values(
                    @nick,
                    null,
                    null,
                    @lane1,
                    @lane2,
                    0,
                    0,
                    getdate(),
                    null,
                    0,
                    0
                )

        COMMIT TRAN
            SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
    END TRY
    BEGIN CATCH                    
        ROLLBACK TRAN   
            SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
    END CATCH
--END#cad_cadastrar#

--#cad_consulta_jogadores#
    select nick, lane1, lane2 from nick where apagado=0
--END#cad_consulta_jogadores#