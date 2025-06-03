fx_version 'cerulean'
game 'gta5'
name 'sp_dutyzone'
description 'Basic duty zone script for Qbox Framework'
author 'Snowpeak Studio'
version '0.0.1'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

ox_lib 'locale'

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
}

server_scripts {
    'server.lua',
}

files {
    'data/config.lua',
    'locales/*.json'
}
