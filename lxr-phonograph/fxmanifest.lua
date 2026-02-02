fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'LXR Phonograph - Multi-Framework Music System for RedM'
author 'iBoss21 / The Lux Empire (Adapted from riversafe)'
version '2.0.0'

-- ═══════════════════════════════════════════════════════════════════════════════
-- SERVER INFORMATION
-- ═══════════════════════════════════════════════════════════════════════════════
-- Server:      The Land of Wolves 🐺
-- Website:     https://www.wolves.land
-- Discord:     https://discord.gg/CrKcWdfd3A
-- GitHub:      https://github.com/iBoss21
-- Store:       https://theluxempire.tebex.io
-- ═══════════════════════════════════════════════════════════════════════════════

ui_page {
	'html/index.html'
}

files {
	'html/index.html',
    'html/play.png',
    'html/stop.png',
    'html/loop.png',
}

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

-- Dependencies
dependencies {
    '/server:4890',  -- RedM server version
    '/onesync',
    'oxmysql'
}

-- Optional framework dependencies (auto-detected)
-- lxr-core, rsg-core, qbr-core, qr-core, vorp_core, redem_roleplay