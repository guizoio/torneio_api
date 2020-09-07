const controllerCarga = require('../controllers/sistemarb')
//const UsuarioTokenAcesso = require('../common/protecaoTokenAcesso');
//const Acesso = new UsuarioTokenAcesso();



module.exports = (server) => {
    
    server.post('/sistemarb/cadastrar/email', async (req, res, next) => {
        const result = await controllerCarga.controllers().cadastrar_email(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/sistemarb/consulta/email', async (req, res, next) => {
        const result = await controllerCarga.controllers().consult_email(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/sistemarb/consulta/email', async (req, res, next) => {
        const result = await controllerCarga.controllers().consult_email(req)
        res.send(result.recordset);
        return next();
    });


}