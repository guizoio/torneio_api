const AcessoDados = require('../db/acessodados.js');
const db = new AcessoDados();

const UsuarioTokenAcesso = require('../common/protecaoTokenAcesso');
const Acesso = new UsuarioTokenAcesso();

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

    const espera_cadastrar = async (req) => {
        //req.body.senha = crypto.createHmac('sha256', req.body.senha).digest('hex');
        var ComandoSQL = await readCommandSql.retornaStringSql('espera_cadastrar', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        console.log(result);
        return result
    }

    const espera_cadastrar_pedido = async (req) => {
        //req.body.senha = crypto.createHmac('sha256', req.body.senha).digest('hex');
        var ComandoSQL = await readCommandSql.retornaStringSql('espera_cadastrar_pedido', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        console.log(result);
        return result
    }
    
    const qtdpag = async (req) => {
        //req.body.senha = crypto.createHmac('sha256', req.body.senha).digest('hex');
        var ComandoSQL = await readCommandSql.retornaStringSql('qtdpag', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        console.log(result);
        return result
    }

    const espera_consulta = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('espera_consulta', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    const espera_consulta_id = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('espera_consulta_id', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.params);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    const espera_mensagem = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('espera_mensagem', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.params);
        //var result = await db.ExecuteQuery(ComandoSQL);
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

    const consulta_assist = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('consulta_assist', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }


    const espera_login = async (req) => {

        var senha = req.body.senha;

        var ComandoSQL = await readCommandSql.retornaStringSql('espera_login', 'torneio');
        var usuarioBanco = await db.ExecuteQuery(ComandoSQL, req.body);

        if (usuarioBanco.recordset != undefined && usuarioBanco.recordset.length > 0) {

            // valida se as senhas são diferentes
            //console.log(usuarioBanco.recordset[0].equipe);
            console.log(usuarioBanco);
            if (senha != usuarioBanco.recordset[0].senha) {
                return { "Status": false, "mensagem": "nome da equipe ou senha incorreta" };
            }

            // se estiver tudo ok, gera o token e retorna o json
            var tokenAcesso = Acesso.gerarTokenAcesso(req.body.equipe);
            return { 
                "TokenAcesso": tokenAcesso, 
                "toplane": usuarioBanco.recordset[0].toplane, 
                "jungle": usuarioBanco.recordset[0].jungle, 
                "midlane": usuarioBanco.recordset[0].midlane, 
                "carry": usuarioBanco.recordset[0].carry, 
                "suporte": usuarioBanco.recordset[0].suporte, 
                "nomeTime": usuarioBanco.recordset[0].nomeTime, 
                "senha": usuarioBanco.recordset[0].senha, 
                "status_banco": usuarioBanco.recordset[0].status, 
                "equipe": usuarioBanco.recordset[0].equipe, 
                "id": usuarioBanco.recordset[0].id, 
                "Status": true};

        }
        else {
            return { "Status": false, "mensagem": "Usuário não cadastrado no sistema" };
        }
    }


    const login = async (req) => {

        var senha = req.body.senha;

        var ComandoSQL = await readCommandSql.retornaStringSql('login', 'torneio');
        var usuarioBanco = await db.ExecuteQuery(ComandoSQL, req.body);

        if (usuarioBanco.recordset != undefined && usuarioBanco.recordset.length > 0) {

            // valida se as senhas são diferentes
            //console.log(usuarioBanco.recordset[0].equipe);
            console.log(usuarioBanco);
            if (senha != usuarioBanco.recordset[0].senha) {
                return { "Status": false, "mensagem": "nome da equipe ou senha incorreta" };
            }

            // se estiver tudo ok, gera o token e retorna o json
            var tokenAcesso = Acesso.gerarTokenAcesso(req.body.equipe);
            return { 
                "TokenAcesso": tokenAcesso, 
                "toplane": usuarioBanco.recordset[0].toplane, 
                "jungle": usuarioBanco.recordset[0].jungle, 
                "midlane": usuarioBanco.recordset[0].midlane, 
                "carry": usuarioBanco.recordset[0].carry, 
                "suporte": usuarioBanco.recordset[0].suporte, 
                "nomeTime": usuarioBanco.recordset[0].nomeTime, 
                "senha": usuarioBanco.recordset[0].senha, 
                "pago": usuarioBanco.recordset[0].pago, 
                "status_banco": usuarioBanco.recordset[0].status, 
                "id": usuarioBanco.recordset[0].id, 
                "Status": true};

        }
        else {
            return { "Status": false, "mensagem": "Usuário não cadastrado no sistema" };
        }
    }

    const data_jogos = async (req) => {
        var ComandoSQL = await readCommandSql.retornaStringSql('data_jogos', 'torneio');
        var result = await db.ExecuteQuery(ComandoSQL, req.body);
        //var result = await db.ExecuteQuery(ComandoSQL);
        console.log(result);
        return result
    }

    

    
    
    return Object.create({
        cadastrar,
        consulta,
        consulta_abate,
        consulta_assist,
        login,
        qtdpag,
        data_jogos,
        espera_cadastrar,
        espera_consulta,
        espera_consulta_id,
        espera_cadastrar_pedido,
        espera_login,
        espera_mensagem
    })

}

module.exports = Object.assign({ controllers })