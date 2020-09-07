const controllerCarga = require('../controllers/carga')
//const UsuarioTokenAcesso = require('../common/protecaoTokenAcesso');
//const Acesso = new UsuarioTokenAcesso();



module.exports = (server) => {

    // server.get('/carga/:usuarii', Acesso.verificaTokenAcesso, async (req, res, next) => {
    //     const result = await controllerCarga.controllers().consultar(req)
    //     res.send(result.recordset);
    //     return next();
    // });

    
    server.post('/inserir/usuario', async (req, res, next) => {
        const result = await controllerCarga.controllers().inserir_usuario(req)
        res.send(result.recordset);
        return next();
    });

    
    server.post('/consulta/usuario', async (req, res, next) => {
        const result = await controllerCarga.controllers().consulta_usuario(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/consulta/usuario', async (req, res, next) => {
        const result = await controllerCarga.controllers().consulta_usuario(req)
        res.send(result.recordset);
        return next();
    });


}