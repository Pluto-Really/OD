local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("coke_packaged", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("fp-drugs:client:usecokebag", src)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coke_packaged'], 'remove', 1)

    end
end)
QBCore.Functions.CreateUseableItem("meth_packaged", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("fp-drugs:client:usemethbag", src)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['meth_packaged'], 'remove', 1)
    end
end)

-- QBCore.Functions.CreateUseableItem("fpweedbagg", function(source, item)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
-- 	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
--         TriggerClientEvent("fp-drugs:client:useweedbag", src)
--     end
-- end)