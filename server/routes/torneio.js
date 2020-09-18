const controllerTorneio = require('../controllers/torneio')
const UsuarioTokenAcesso = require('../common/protecaoTokenAcesso');
const Acesso = new UsuarioTokenAcesso();
module.exports = (server) => {
    
    server.post('/torneio/cadastrar', async (req, res, next) => {
        const result = await controllerTorneio.controllers().cadastrar(req)
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

}