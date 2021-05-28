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
Minerador = Tunnel.getInterface("PR_Minerador")

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local locX,locY,locZ = 2944.16,2793.24,40.52
Citizen.CreateThread(function()
    while true do
        interval = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz1,cdz1 = GetGroundZFor_3dCoord(locX,locY,locZ)
        local distance1 = Vdist(locX,locY,cdz1,x,y,z)
        local health = GetEntityHealth(ped)

        --- MINERAR ---
        if distance1 <= 20 and not IsPedInAnyVehicle(ped) and health > 101 then
            interval = 1
            SetTextComponentFormat('STRING');
            AddTextComponentString('Pressione ~INPUT_PICKUP~ para iniciar a mineração.');
            DisplayHelpTextFromStringLabel(0, false, true, -1);
            if IsControlJustPressed(0,38) then
                if Minerador.checkWeight() then
                    TriggerEvent("cancelando",true)
                    FreezeEntityPosition(ped, true)
                    vRP._CarregarObjeto("amb@world_human_const_drill@male@drill@base","base","prop_tool_jackham",15,28422)
                    Citizen.Wait(13000)
                    vRP._DeletarObjeto()
                    vRP._stopAnim(false)
                    TriggerEvent("cancelando",false)
                    Minerador.checkPayment()
                    FreezeEntityPosition(ped, false)
                elseif not Minerador.checkWeight() then
                    TriggerEvent("Notify","Negado!","Você não possui espaço na mochila para minerar.",8000)
                end
            end
        end
       Wait(interval)
    end
end)

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --
-- MINERADOR PROCESSAMENTO --
-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local menuactive = false
local onmenu = false
-----
local processamento = false
local noprocesso = false
-----
local processamentobaixo = false
local processamentomedio = false
local processamentoalto = false
-----
local etapa1 = false
local etapa2 = false
local etapa3 = false
-----
local tempo = 0
----
local nomenu = true
-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local ProcessarX,ProcessarY,ProcessarZ = 1075.9528808594,-1978.6940917969,31.471374511719 --1076.04,-1978.76,31.48
Citizen.CreateThread(function()
    while true do
        interval = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz1,cdz1 = GetGroundZFor_3dCoord(ProcessarX,ProcessarY,ProcessarZ)
        local distance1 = Vdist(ProcessarX,ProcessarY,cdz1,x,y,z)
        local health = GetEntityHealth(ped)
        --- ABRIR NUI ---
        if distance1 <= 2 and not IsPedInAnyVehicle(ped) and health > 101 and not menuactive and not processamento then
            interval = 1
            SetTextComponentFormat('STRING');
            AddTextComponentString('Pressione ~INPUT_PICKUP~ para selecionar um processamento.');
            DisplayHelpTextFromStringLabel(0, false, true, -1);
            if IsControlJustPressed(0,38) then
                vRP._playAnim(false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
                ToggleActionMenu()
                onmenu = true
            end
        end
       Wait(interval)
    end
end)



-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

RegisterNUICallback("ButtonClick",function(data,cb)
    if data == "processamento-baixo" then
        processamento = true
        etapa1 = true
        processamentobaixo = true
        -----
        vRP._stopAnim(false)
        ToggleActionMenu()
        onmenu = false
        ------
        DoScreenFadeOut(1000)
        Citizen.Wait(2000)
        Minerador.colocaruniforme()
        DoScreenFadeIn(1000)
        nomenu = false
        -----
        TriggerEvent("Notify","aviso","Você iniciou o baixo processamento, vá para a forja.",15000)
    elseif data == "processamento-medio" then
        processamento = true
        etapa1 = true
        processamentomedio = true
        ------
        vRP._stopAnim(false)
        ToggleActionMenu()
        onmenu = false
        ------
        DoScreenFadeOut(1000)
        Citizen.Wait(2000)
        Minerador.colocaruniforme()
        DoScreenFadeIn(1000)
        nomenu = false
        -----
        TriggerEvent("Notify","aviso","Você iniciou o médio processamento, vá para a forja.",15000)

    elseif data == "processamento-alto" then
        processamento = true
        etapa1 = true
        processamentoalto = true
        -----
        vRP._stopAnim(false)
        ToggleActionMenu()
        onmenu = false
        ------
        DoScreenFadeOut(1000)
        Citizen.Wait(2000)
        Minerador.colocaruniforme()
        DoScreenFadeIn(1000)
        nomenu = false
        -----
        TriggerEvent("Notify","aviso","Você iniciou o alto processamento, vá para a forja.",15000)
    elseif data == "fechar" then
        vRP._stopAnim(false)
		ToggleActionMenu()
		onmenu = false
        nomenu = false
	end
end)

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local ForjaX,ForjaY,ForjaZ = 1114.96,-2009.73,35.63
Citizen.CreateThread(function()
    while true do
        interval = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz1,cdz1 = GetGroundZFor_3dCoord(ForjaX,ForjaY,ForjaZ)
        local distance1 = Vdist(ForjaX,ForjaY,cdz1,x,y,z)
        local health = GetEntityHealth(ped)
        if processamento then
            interval = 1
        end
        if processamento and not nomenu and not noprocesso then 
            drawTxt("PRESSIONE ~r~F7~w~ PARA CANCELAR O PROCESSAMENTO",1,0.750,0.882,0.43,255,255,255,200)
            if etapa1 then
                drawTxt("VÁ ATÉ A ~r~FORJA~w~ PARA INICIAR O PROCESSAMENTO",1,0.745,0.905,0.43,255,255,255,200)
            elseif etapa2 then
                drawTxt("VÁ ATÉ A ~r~BANCADA~w~ PARA INICIAR A SEGUNDA ETAPA",1,0.745,0.905,0.43,255,255,255,200)
            elseif etapa3 then
                drawTxt("VÁ ATÉ A ~r~BANCADA~w~ AO LADO PARA FINALIZAR A ETAPA",1,0.745,0.905,0.43,255,255,255,200)
            end
            if IsControlJustPressed(0,168) then
                processamento = false
                etapa1 = false
                etapa2 = false
                etapa3 = false
                processamentoalto = false
                processamentomedio = false 
                processamentobaixo = false
                DoScreenFadeOut(2000)
                Citizen.Wait(2000)
                Minerador.tiraruniforme()
                DoScreenFadeIn(1000)
            end
        end

        --- INICIAR PRIMEIRA ETAPA ---
        if distance1 <= 2 and not IsPedInAnyVehicle(ped) and health > 101 and processamento and not etapa2 and not etapa3 then
            SetTextComponentFormat('STRING');
            AddTextComponentString('Pressione ~INPUT_PICKUP~ para trabalhar na forja.');
            DisplayHelpTextFromStringLabel(0, false, true, -1);
            if IsControlJustPressed(0,38) then
                local aprovado = false
                local quantidadeouro = 0
                local quantidadediamante = 0
                if (processamentobaixo) then
                    if Minerador.checarminerio() then
                        tempo = 11000
                        aprovado = true
                        quantidadeouro = 2
                    end
                elseif processamentomedio then
                    if Minerador.checarminerio2() then
                        tempo = 20000
                        aprovado = true
                        quantidadeouro = 2
                        quantidadediamante = 2
                    end
                elseif processamentoalto then
                    if Minerador.checarminerio3() then
                        tempo = 40000
                        aprovado = true
                        quantidadeouro = 4
                        quantidadediamante = 4
                    end
                end
                if aprovado then
                    noprocesso = true
                    if processamentoalto or processamentomedio then
                        Minerador.removermineiro2(quantidadeouro,quantidadediamante)
                    else 
                        Minerador.removermineiro(quantidadeouro)
                    end
                    FreezeEntityPosition(ped, true)
                    vRP._CarregarObjeto("mini@repair","fixing_a_ped","prop_gold_bar",15,64016) 
                    Citizen.Wait(tempo)
                    vRP._DeletarObjeto()
                    vRP._stopAnim(false)
                    TriggerEvent("cancelando",false)
                    FreezeEntityPosition(ped, false)
                    TriggerEvent("Notify","aviso","Sucesso, vá até a bancada para iniciar a segunda etapa.",15000)
                    etapa1 = false
                    etapa2 = true
                    noprocesso = false
                end
            end
        end
       Wait(interval)
    end
end)

-- ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ --

local bancada1X,bancada1Y,bancada1Z = 1073.2603759766,-1988.2938232422,30.908554077148
Citizen.CreateThread(function()
    while true do
        interval = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz1,cdz1 = GetGroundZFor_3dCoord(bancada1X,bancada1Y,bancada1Z)
        local distance1 = Vdist(bancada1X,bancada1Y,cdz1,x,y,z)
        local health = GetEntityHealth(ped)
        if not etapa1 and not etapa3 and etapa2 and processamento and not IsPedInAnyVehicle(ped) and health > 101 then
            if distance1 <= 2 then
                interval = 1 
                SetTextComponentFormat('STRING');
                AddTextComponentString('Pressione ~INPUT_PICKUP~ para trabalhar na bancada.');
                DisplayHelpTextFromStringLabel(0, false, true, -1);
                if IsControlJustPressed(0,38) then
                    if etapa2 then
                        noprocesso = true
                        FreezeEntityPosition(ped, true)
                        vRP._CarregarObjeto("mini@repair","fixing_a_ped","hei_prop_heist_gold_bar",15,26611) 
                        Citizen.Wait(tempo)
                        vRP._DeletarObjeto()
                        vRP._stopAnim(false)
                        TriggerEvent("cancelando",false)
                        FreezeEntityPosition(ped, false)
                        TriggerEvent("Notify","aviso","Sucesso, vá até a bancada ao lado para finalizar o processo.",15000)
                        etapa2 = false
                        etapa3 = true
                        noprocesso = false
                    end
                end
            end
        end
       Wait(interval)
    end
end)

local bancada2X,bancada2Y,bancada2Z = 1076.9093017578,-1984.2510986328,31.024499893188
Citizen.CreateThread(function()
    while true do
        interval = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz1,cdz1 = GetGroundZFor_3dCoord(bancada2X,bancada2Y,bancada2Z)
        local distance1 = Vdist(bancada2X,bancada2Y,cdz1,x,y,z)
        local health = GetEntityHealth(ped)
        if not etapa1 and not etapa2 and etapa3 and processamento and not IsPedInAnyVehicle(ped) and health > 101 then
            if distance1 <= 2 then
                interval = 1 
                SetTextComponentFormat('STRING');
                AddTextComponentString('Pressione ~INPUT_PICKUP~ para finalizar o processamento.');
                DisplayHelpTextFromStringLabel(0, false, true, -1);
                if IsControlJustPressed(0,38) then
                    if etapa3 then
                        noprocesso = true
                        FreezeEntityPosition(ped, true)
                        vRP._CarregarObjeto("mini@repair","fixing_a_ped","hei_prop_heist_gold_bar",15,26611) 
                        Citizen.Wait(tempo)
                        vRP._DeletarObjeto()
                        vRP._stopAnim(false)
                        TriggerEvent("cancelando",false)
                        FreezeEntityPosition(ped, false)
                        processamento = false
                        etapa1 = false
                        etapa2 = false
                        etapa3 = false
                        DoScreenFadeOut(2000)
                        Citizen.Wait(2000)
                        Minerador.tiraruniforme()
                        DoScreenFadeIn(1000)

                        if processamentobaixo then
                            Minerador.PagamentoBaixo()
                            TriggerEvent("Notify","aviso","Sucesso, você recebeu </b>1X joia de baixo processamento </b>",35000)
                        elseif processamentomedio then
                            Minerador.PagamentoMedio()
                            TriggerEvent("Notify","aviso","Sucesso, você recebeu </b>1X joia de médio processamento </b>",35000)
                        elseif processamentoalto then
                            Minerador.PagamentoAlto()
                            TriggerEvent("Notify","aviso","Sucesso, você recebeu </b>1X joia de alto processamento </b>",35000)
                        end
                        TriggerEvent("Notify","aviso","Vá vender esta joia para uma joalheria.",15000)
                        processamentoalto = false
                        processamentomedio = false 
                        processamentobaixo = false
                        noprocesso = false
                    end
                end
            end
        end
       Wait(interval)
    end
end)