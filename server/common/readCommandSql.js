var fs = require("fs");

module.exports = class ReadCommandSql {

    async retornaStringSql(chave, controller) {

        var commandoRegex = '';

        try
        {
            await new Promise(async (resolve) => {

                //await fs.readFile(`./server/scripts/${controller}.sql`, function (err, buf) {
                    await fs.readFile(`./scripts/${controller}.sql`, function (err, buf) {
                    if (err) { console.log(err); resolve(); }
                    
                    var str = buf.toString();
                    var regex = new RegExp(`^--#${chave}#(.*?)^--END#${chave}#`, "sm");

                    commandoRegex = str.match(regex);
                    commandoRegex = commandoRegex[0].toString().replace(`--#${chave}#`, '').replace(`--END#${chave}#`, '');
                    
                    resolve();                
                });
    
            })
        }
        catch (ex) {
            console.log('Erro retornaStringSql: ', ex);
        }

        return commandoRegex;

    }

}