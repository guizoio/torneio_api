
--#consult_email#
	select * from rochabombas.tblemail
--END#consult_email#


--#cadastrar_email#
BEGIN TRY
    BEGIN TRAN 

        INSERT INTO 
            rochabombas.tblemail (nome, tel, email, msg, status, datac)
        values 
        (
            @nome,
            @tel,
            @email,
            @msg,
            3,
            getdate()
        )
                
    COMMIT TRAN
        SELECT '{ "resultado" : "sucesso", "msg" : "Cadastro realizado com sucesso!" , "class" : "success" }' as retorno
END TRY
BEGIN CATCH                    
    ROLLBACK TRAN   
        SELECT '{ "resultado" : "erro", "msg" : "Cadastro não realizado!\n motivo:'+ ERROR_MESSAGE() +'" , "class" : "error" }' as retorno               
END CATCH
--END#cadastrar_email#