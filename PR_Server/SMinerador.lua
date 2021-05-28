-----------------------------------------------------------------------------------------------
-- CRIADOR DO SCRIPT: Paulo Ricardo -----------------------------------------------------------
-- DISCORD DO CRIADOR: PR#0001 ----------------------------------------------------------------
-- GITHUB: https://github.com/PauloRicardoctt -------------------------------------------------
-- TODOS CRÉDITOS AO CRIADOR! -----------------------------------------------------------------
-----------------------------------------------------------------------------------------------


-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Minerador = {}
Tunnel.bindInterface("PR_Minerador",Minerador)

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local quantidade = {}
local porcentagem = 0
local itemname = ""

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,2)
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.checkWeight()
	Minerador.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		porcentagem = math.random(100)
		if porcentagem <= 15 then
			itemname = "ouro"
		elseif porcentagem >= 16 and porcentagem <= 30 then
			itemname = "ouro"
		elseif porcentagem >= 31 and porcentagem <= 40 then
			itemname = "ouro"
		elseif porcentagem >= 41 and porcentagem <= 50 then
			itemname = "ouro"
		elseif porcentagem >= 51 and porcentagem <= 60 then
			itemname = "ouro"
		elseif porcentagem >= 61 and porcentagem <= 70 then
			itemname = "ouro"
		elseif porcentagem >= 71 and porcentagem <= 80 then
			itemname = "ouro"
		elseif porcentagem >= 81 and porcentagem <= 90 then
			itemname = "ouro"
		elseif porcentagem >= 91 then
			itemname = "diamante"
		end
		return vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemname)*quantidade[source] <= vRP.getInventoryMaxWeight(user_id)
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"MineradorReceber",1)
		vRP.giveInventoryItem(user_id,itemname,quantidade[source])
		TriggerClientEvent("Notify",source,"sucesso","Você minerou <b>"..quantidade[source].."x "..vRP.itemNameList(itemname).."</b>.",8000)
		quantidade[source] = nil
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --
-- SEGUNDA ETAPA MINERADOR --
-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.checarminerio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"ouro") >= 2 then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa ter 2 ouros em sua mochila para isso.")
			return false
		end
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.checarminerio2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"ouro") >= 2 and vRP.getInventoryItemAmount(user_id,"diamante") >= 2 then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa ter 2 ouros e 2 diamantes em sua mochila para isso.")
			return false
		end
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.checarminerio3()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"ouro") >= 4 and vRP.getInventoryItemAmount(user_id,"diamante") >= 4  then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa ter 4 ouros e 4 diamantes em sua mochila para isso.")
			return false
		end
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local presets = {
	["1"] = {
		[1885233650] = { -- Homem
			["1"] = { -1,0,2 },
			["2"] = { 4,0,0 },
			["3"] = { 33,0,2 },
			["4"] = { 33,0,2 },
			["5"] = { 44,0,2 },
			["6"] = { 25,0,2 },
			["7"] = { -1,0,2 },
			["8"] = { 125,0,2 },
			["9"] = { -1,0,2 },
			["10"] = { -1,0,2 },
			["11"] = { 89,0,2 }
		},
		[-1667301416] = { -- Mulher
			["1"] = { 0,0,2 },
			["2"] = { 4,0,0 },
			["3"] = { 40,0,2 },
			["4"] = { 32,0,2 },
			["5"] = { 45,0,2 },
			["6"] = { 9,0,2 },
			["7"] = { -1,0,2 },
			["8"] = { 33,0,2 },
			["9"] = { -1,0,2 },
			["10"] = { -1,0,2 },
			["11"] = { 262,0,2 }
		}
	}
}

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.colocaruniforme() 
	local custom = presets["1"]
	if custom then
		local old_custom = vRPclient.getCustomization(source)
		local idle_copy = {}

		idle_copy = vRP.save_idle_custom(source,old_custom)
		idle_copy.modelhash = nil
		for l,w in pairs(custom[old_custom.modelhash]) do
			idle_copy[l] = w
		end
		vRPclient._setCustomization(source,idle_copy)
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.tiraruniforme() 
	vRP.removeCloak(source)
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.removermineiro(quantidade)
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.tryGetInventoryItem(user_id,"ouro",quantidade) 
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.removermineiro2(quantidade,quantidade2)
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.tryGetInventoryItem(user_id,"ouro",quantidade) 
		vRP.tryGetInventoryItem(user_id,"diamante",quantidade2) 
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function Minerador.PagamentoBaixo()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.giveInventoryItem(user_id,"joiabaixa",1) 
	end
end

function Minerador.PagamentoMedio()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.giveInventoryItem(user_id,"joiamedia",1) 
	end
end
function Minerador.PagamentoAlto()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.giveInventoryItem(user_id,"joiaalta",1) 
	end
end


