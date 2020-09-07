const controllerCarga = require('../controllers/email')
module.exports = (server) => {
    
    server.post('/minha-api/enviaremail', async (req, res, next) => {
        const result = await controllerCarga.controllers().enviaremail(req)
        res.send(result);
        return next();
    });
}