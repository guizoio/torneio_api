--#cadastrar_equipe#
BEGIN TRY
    BEGIN TRAN 

        INSERT INTO 
            torneio..equipe (toplane, jungle, midlane, carry, suporte, nomeTime, numero, datacad, pago, status, apagado, senha)
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
            @senha
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
    select * from torneio..equipe where apagado=0
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
            where 
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
            where 
                cast(asist as int)>=0)tbl where tbl.number in (1,2,3,4,5)
    order by 
        cast(asist as int) desc
--END#consulta_assist#

--#login#

select * from equipe where apagado = 0 and nomeTime = @equipe

--END#login#
