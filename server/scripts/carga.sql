
--#consulta_usuario#
	select * from Sistema.tblusuario where apgado = 0
--END#consulta_usuario#


--#inserir_usuario#
BEGIN TRY
    BEGIN TRAN 

        INSERT INTO 
            Sistema.tblusuario (nome, usuario, senha, email, apgado, datac)
        values 
        (
            @nome,
            @usuario,
            @senha,
            @email,
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
--END#inserir_usuario#