local QBCore = exports['qb-core']:GetCoreObject()

local methCount = 0
local cokeCount = 0
local deathwait = math.random(10000,20000)
local maxdeathbags = math.random(3,6)
local chancetonotifyabt = math.random(1,100)

CreateThread(function()
    while true do
        Wait(10)
        if methCount > 0 then
            Wait(1000 * 60 * 15)
            methCount = methCount - 1
        elseif cokeCount > 0 then
            Wait(1000 * 60 * 15)
            cokeCount = cokeCount - 1
        else
            Wait(2000)
        end
    end
end)

function Armour(EffectTime, Multiplier)
    while EffectTime > 0 do
      Citizen.Wait(1000)
      EffectTime = EffectTime - 1
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(), math.ceil(armor + Multiplier))
    end
    EffectTime = 0
end

RegisterNetEvent("fp-drugs:client:usemethbag", function()
    QBCore.Functions.Progressbar("snort_coke", "Smoking Meth..", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        methCount = methCount + 1
        if methCount > 1 and methCount < 2 then
            TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        elseif methCount >= 2 and methCount < 3 then
            if chancetonotifyabt < 26 then
                QBCore.Functions.Notify("Breathing Heavy..", "primary")
            end
            TriggerEvent("evidence:client:SetStatus", "widepupils", 700)
        elseif methCount > maxdeathbags then
            Wait(deathwait)
            TriggerEvent('hospital:client:KillPlayer')
        end
        -- Effect Here
        if Config.AddMethHealth then
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + math.random(Config.MinOfHealthMeth, Config.MaxOfHealthMeth))
        if Config.AddMethArmor then
            Armour(Config.AmountOfArmorMeth, Config.AmountOfArmorMultiplierMeth)
                if Config.ReliefMethStress then
                    TriggerServerEvent('hud:server:RelieveStress', math.random(Config.MinOfStressReliefMeth, Config.MaxOfStressReliefMeth))
                end
            end
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent("fp-drugs:client:usecokebag", function()
    QBCore.Functions.Progressbar("snort_coke", "Quick sniff..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        cokeCount = cokeCount + 1
        if cokeCount > 1 and cokeCount < 2 then
            TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        elseif cokeCount >= 2 and cokeCount < 3 then
            if chancetonotifyabt < 26 then
                QBCore.Functions.Notify("Breathing Heavy..", "primary")
            end
            TriggerEvent("evidence:client:SetStatus", "widepupils", 700)
        elseif cokeCount > maxdeathbags then
            Wait(deathwait)
            TriggerEvent('hospital:client:KillPlayer')
        end
        -- Effect Here
        if Config.AddCokeHealth then
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + math.random(Config.MinOfHealthCoke, Config.MaxOfHealthCoke))
        if Config.AddCokeArmor then
            Armour(Config.AmountOfArmorCoke, Config.AmountOfArmorMultiplierCoke)
                if Config.ReliefCokeStress then
                    TriggerServerEvent('hud:server:RelieveStress', math.random(Config.MinOfStressReliefCoke, Config.MaxOfStressReliefCoke))
                end
            end
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

function CokeBaggyEffectv2()
    local startStamina = 20
    AlienEffectv2()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffectv2()
            Citizen.Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffectv2()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end