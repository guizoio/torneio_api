const controllerTorneio = require('../controllers/torneio');

const consultaa = require('../controllers/apilol');

const UsuarioTokenAcesso = require('../common/protecaoTokenAcesso');
const Acesso = new UsuarioTokenAcesso();
module.exports = (server) => {
    
    server.post('/torneio/cadastrar', async (req, res, next) => {
        const result = await controllerTorneio.controllers().cadastrar(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/torneio/espera/cadastrar', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_cadastrar(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/torneio/espera/cadastrar_pedido', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_cadastrar_pedido(req)
        res.send(result.recordset);
        return next();
    }); 

    server.get('/torneio/espera/consulta', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_consulta(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/espera/entrarTorneio/:id', async (req, res, next) => {
        const result = await controllerTorneio.controllers().entrarTorneio_id(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/espera/consulta/:id', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_consulta_id(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/espera/mensagem/:id', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_mensagem(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/espera/mensagem/deletar/:id', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_mensagem_deletar(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/espera/mensagem/lida/:id', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_mensagem_lida(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/espera/mensagem/rejeitar/:id', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_mensagem_rejeitar(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/torneio/espera/mensagem/aprovar', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_mensagem_aprovar(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/consulta', async (req, res, next) => {
        const result = await controllerTorneio.controllers().consulta(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/consulta/abate', async (req, res, next) => {
        const result = await controllerTorneio.controllers().consulta_abate(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/consulta/assist', async (req, res, next) => {
        const result = await controllerTorneio.controllers().consulta_assist(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/torneio/login', async (req, res, next) => {
        const result = await controllerTorneio.controllers().login(req)
        res.send(result);
        return next();
    });

    server.post('/torneio/espera/login', async (req, res, next) => {
        const result = await controllerTorneio.controllers().espera_login(req)
        res.send(result);
        return next();
    });

    server.post('/torneio/validar', Acesso.verificaTokenAcesso, async (req, res, next) => {
        //const result = await controllerTorneio.controllers().login(req)
        res.send(Acesso);
        return next();
    });

    server.post('/torneio/qtdpag', Acesso.verificaTokenAcesso, async (req, res, next) => {
        const result = await controllerTorneio.controllers().qtdpag(req)
        res.send(result);
        return next();
    });

    server.get('/torneio/data/jogos', async (req, res, next) => {
        const result = await controllerTorneio.controllers().data_jogos(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/torneio/apilol/gettoken', async (req, res, next) => {
        const result = await controllerTorneio.controllers().gettoken(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/torneio/apilol', async (req, res, next) => {
        const result = await consultaa.controllers().consulta(req)
        res.send(result);
        return next();
    });






    server.get('/bolao/carrega/jogos', async (req, res, next) => {
        const result = await controllerTorneio.controllers().bolao_jogos(req)
        res.send(result.recordset);
        return next();
    });

    server.get('/bolao/consulta/usuario', async (req, res, next) => {
        const result = await controllerTorneio.controllers().bolao_consulta_usuario(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/bolao/cadastrar/usuario', async (req, res, next) => {
        const result = await controllerTorneio.controllers().bolao_cadastrar_usuario(req)
        res.send(result.recordset);
        return next();
    });

    server.post('/bolao/login', async (req, res, next) => {
        const result = await controllerTorneio.controllers().bolao_login(req)
        res.send(result);
        return next();
    });






    server.get('/cad/consulta/:nick', async (req, res, next) => {
        const result = await controllerTorneio.controllers().cad_consulta(req)
        res.send(result.recordset);
        return next();
    });
    server.post('/cad/cadastrar', async (req, res, next) => {
        const result = await controllerTorneio.controllers().cad_cadastrar(req)
        res.send(result.recordset);
        return next();
    });



}