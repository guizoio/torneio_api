const nodemailer = require('nodemailer');


var transportador = nodemailer.createTransport({
    service: 'hotmail', //para contas gmail use "gmail"
    auth: {
        user: 'zoio-minha-api@outlook.com',
        pass: 'zoio!1@2#3$'
        // user: 'zoio.182@hotmail.com',
        // pass: 'sumotoetesla'
    }
});

const controllers = () => {

    const enviaremail = async (req) => {
        
        var nomeDestino=req.body.nomedestino;
        var destino=req.body.destino;
        var assunto=req.body.assunto;
        var titulomsg=req.body.titulomsg;
        var msg=req.body.msg;

        
        var configuracoes = {
            from: 'Minha-Api Zoio <zoio-minha-api@outlook.com>',
            //from: 'Gui Zoio <zoio.182@hotmail.com>',
            to: nomeDestino + '<'+destino+'>',
            subject: assunto,
            text: titulomsg,
            html: '<h1>'+titulomsg+'</h1><br><br>'+msg
        };
    
        transportador.sendMail(configuracoes, function(error, info){
            if(error){
                return console.log(error);
            }else{
                return console.log('Email enviado ' + info.response);
            }
        });
        
    }

    return Object.create({
        enviaremail
    })

}

module.exports = Object.assign({ controllers })