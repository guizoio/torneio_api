var request = require('request');


const controllers = () => {


    const consulta = async (req) => {

        console.log("body: ", req.body.url);


        var options = {
            'method': 'GET',
            'url': req.body.url,
            'headers': {
              'Content-Type': 'application/json'
            },
            form: {
          
            }
          };

        return new Promise((resolve, reject) =>{

            request(options, function (error, response) {

                if(response){
                    console.log('api lol : ', response.body);
                    resolve(response.body);
                }else{
                    reject(error);
                }  
                
            });
        });








        // await request(options, function (error, response) {

        //     if(response){
        //         console.log('api lol : ', response.body);
        //         return response.body;
        //     }
        //     if (error) throw new Error(error);    
            
        // });
    }
    
    return Object.create({
        consulta
    })

}

module.exports = Object.assign({ controllers })