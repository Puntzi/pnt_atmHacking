fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Puntzi'
description 'Simple hacking ATM'
version '1.1.0'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

files {
    'locales/*.json'
}