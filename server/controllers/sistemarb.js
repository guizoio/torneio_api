const AcessoDados = require('../db/acessodados.js');
const db = new AcessoDados();
const crypto = require('crypto');
const ReadCommandSql = require('../common/readCommandSql');
const readCommandSql = new ReadCommandSql();


const controllers = () => {

    const cadastrar_email = async (req) => {
        //req.body.senha = crypto.createHmac('sha256', req.body.senha).digest('hex');
        var ComandoSQL = await readCommandSql.retornaStringSql('cadastrar_email', 'sistemarb');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        console.log(result);
        return result
    }

    const consult_email = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('consult_email', 'sistemarb');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    return Object.create({
        cadastrar_email,
        consult_email
    })

}

module.exports = Object.assign({ controllers })