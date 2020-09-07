var config = {
    dev_hml: {
        url: 'http://localhost',
        port: 4403,
        ambiente: 'HML',
        session: {
            secret: 'teste',
            resave: false,
            saveUninitialized: false,
            cookie: { secure: false }
        },
        database: {
            user: 'sa',
            password: 'Ovodepascoades2',
            server: '127.0.0.1',//ip do container
            //server: 'localhost',//local
            port: 1433,
            database: 'torneio',
            requestTimeout: 180000,
            connectionTimeout: 180000,
            options: { encrypt: false },
            pool: {
                idleTimeoutMillis: 180000,
                max: 100
            }
        }
    },

    dev_prod: {
        url: 'http://localhost',
        port: 3404,
        ambiente: 'DEV',
        session: {
            secret: 'teste',
            resave: false,
            saveUninitialized: false,
            cookie: { secure: false }
        },
        database: {
            user: 'sa',
            password: 'Ovodepascoades2',
            server: '172.17.0.3',
            port: 1433,
            database: 'Projeto',
            requestTimeout: 180000,
            connectionTimeout: 180000,
            options: { encrypt: false },
            pool: {
                idleTimeoutMillis: 180000,
                max: 100
            }
        }
    }
}

exports.get = function get(env) {
    return config.dev_hml;
}