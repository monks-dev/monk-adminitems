local QBCore = exports['qb-core']:GetCoreObjects()

local function isAdmin(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    local group = Player.PlayerData.group
    return group == 'admin' or group == 'god'
end

RegisterCommand('items', function(source)
    if not isAdmin(source) then
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'You are not an admin.' })
        return
    end

    local items = exports.ox_inventory:Items()
    if not items then return end

    local itemList = {}
    local slot = 1
    for name, data in pairs(items) do
        table.insert(itemList, {
            name = name,
            count = 1,
            slot = slot
        })
        slot += 1
    end

    TriggerClientEvent("adminitems:openCreativeMenu", source, itemList)
end, false)
