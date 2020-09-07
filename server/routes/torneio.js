const controllerTorneio = require('../controllers/torneio')
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
}