fx_version 'bodacious'
game 'gta5'

aurthor 'Twitter : @aziiz_user | discord.gg/TNHufkD '

ui_page {
	'html/index.html',
}

files {
	'html/font/*.otf',
	'html/font/*.ttf',
	'html/css/*.css',
	'html/js/*.js',
	'html/index.html',
	"html/img/*.png",
}

shared_scripts {
    '@qb-core/shared/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'locales/en.lua', 
}

client_scripts {
	'client.lua',
}

server_script 'server.lua'

--Change to the language you want
-- 'locales/en.lua', 
-- 'locales/ar.lua', 

