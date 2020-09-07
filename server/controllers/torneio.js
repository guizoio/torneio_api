const AcessoDados = require('../db/acessodados.js');
const db = new AcessoDados();
const crypto = require('crypto');
const ReadCommandSql = require('../common/readCommandSql');
const readCommandSql = new ReadCommandSql();


const controllers = () => {

    const cadastrar = async (req) => {
        //req.body.senha = crypto.createHmac('sha256', req.body.senha).digest('hex');
        var ComandoSQL = await readCommandSql.retornaStringSql('cadastrar_equipe', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        console.log(result);
        return result
    }

    const consulta = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('consulta_equipe', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    const consulta_abate = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('consulta_abate', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    return Object.create({
        cadastrar,
        consulta,
        consulta_abate
    })

}

module.exports = Object.assign({ controllers })