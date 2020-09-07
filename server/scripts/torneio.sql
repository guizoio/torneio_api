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