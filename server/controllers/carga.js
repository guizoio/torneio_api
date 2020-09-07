const AcessoDados = require('../db/acessodados.js');
const db = new AcessoDados();
const crypto = require('crypto');
const ReadCommandSql = require('../common/readCommandSql');
const readCommandSql = new ReadCommandSql();


const controllers = () => {

    const inserir_usuario = async (req) => {
        //req.body.senha = crypto.createHmac('sha256', req.body.senha).digest('hex');
        var ComandoSQL = await readCommandSql.retornaStringSql('inserir_usuario', 'carga');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        console.log(result);
        return result
    }

    const consulta_usuario = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('consulta_usuario', 'carga');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    return Object.create({
        inserir_usuario,
        consulta_usuario
    })

}

module.exports = Object.assign({ controllers })