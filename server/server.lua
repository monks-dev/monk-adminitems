local function getOxItems()
    local allItems = exports.ox_inventory:Items()
    local formatted = {}

    for name, data in pairs(allItems) do
        table.insert(formatted, {
            name = name,
            label = data.label or name
        })
    end

    return formatted
end


RegisterCommand('itemsMenu', function(source)
    local src = source
    if not IsPlayerAceAllowed(src, 'command.itemsMenu') then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You are not an admin.' })
        return
    end

    local itemsList = getOxItems()
    TriggerClientEvent('creativeItemMenu:open', src, itemsList)
end, false)

-- Receive request from client to add item
RegisterNetEvent('creativeItemMenu:addItem', function(itemName, amount)
    local src = source
    local Player = exports['qbx_core']:GetPlayer(src)
    if not Player then return end

    amount = tonumber(amount) or 1
    if amount < 1 then amount = 1 end

    -- Add item to player's inventory
    local success = Player.Functions.AddItem(itemName, amount)
    if success then
        TriggerClientEvent('ox_lib:notify', src,
            { type = 'success', description = ('Added %d x %s'):format(amount, itemName) })
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Failed to add item.' })
    end
end)
