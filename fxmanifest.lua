dependency "Aero_Movements" client_script "@Aero_Movements/client.lua" -----------------------------------------------------------------------------------------------
-- CRIADOR DO SCRIPT: Paulo Ricardo -----------------------------------------------------------
-- DISCORD DO CRIADOR: PR#0001 ----------------------------------------------------------------
-- GITHUB: https://github.com/PauloRicardoctt -------------------------------------------------
-- TODOS CRÉDITOS AO CRIADOR! -----------------------------------------------------------------
-----------------------------------------------------------------------------------------------

fx_version 'cerulean'
games {'gta5'}

author 'PR#0001'
description 'Emprego de Minerador e Processamento.'
version '1.0.0'


ui_page 'MineradorNui/Minerador.html'

client_scripts{ 
    "@vrp/lib/utils.lua",
    "PR_Client/*.lua"
}

server_scripts{ 
    "@vrp/lib/utils.lua",
    "PR_Server/*.lua"
}

files {
	'MineradorNui/Minerador.html',
	'MineradorNui/Minerador.js',
    'MineradorNui/Minerador.css',
}
