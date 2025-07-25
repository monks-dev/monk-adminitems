fx_version 'cerulean'
game 'gta5'

description 'A creative like menu for admins to easily pull items from'
author 'Monks'
version '0.0.1'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/shared/locale.lua',
    'shared/config.lua',
}

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/fallback.png'
}

lua54 'yes'
