--#cadastrar_equipe#
BEGIN TRY
    BEGIN TRAN 

        INSERT INTO 
            torneio..equipe (toplane, jungle, midlane, carry, suporte, nomeTime, numero, datacad, pago, status, apagado)
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
    select * from torneio..equipe
--END#consulta_equipe#

--#consulta_abate#
    select 
        nick, 
        abate, 
        nometime,
        ROW_NUMBER()OVER(
            ORDER BY cast(abate as int) desc
        ) as [number]
    from 
        usuario 
    order by 
        cast(abate as int) desc, 
        nick asc
--END#consulta_abate#