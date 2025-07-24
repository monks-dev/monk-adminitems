RegisterCommand('items', function(src)
    local Player = exports['qbx_core']:GetPlayer(src)
    if not Player then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Could not find player data.' })
        return
    end
    if not IsPlayerAceAllowed(src, 'command.items') then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You are not an admin.' })
        return
    end

    local items = exports.ox_inventory:Items()
    if not items then return end
    local stashId = 'creative_items_' .. tostring(src)

    exports.ox_inventory:RegisterStash(stashId, "Creative Items", 100, 1000000, tostring(src))

    for name, data in pairs(items) do
        exports.ox_inventory:AddItem(stashId, name, 1, {}, nil)
    end

    TriggerClientEvent("adminitems:openCreativeMenu", src, stashId)
end, false)

RegisterNetEvent('adminitems:closedCreativeMenu', function(stashId)
    local src = source

    -- Optional: Check if stashId belongs to the player (for security)
    if stashId == 'creative_items_' .. tostring(src) then
        -- Clear stash items
        exports.ox_inventory:ClearStashItems(stashId)
        -- Unregister stash so it no longer exists
        exports.ox_inventory:UnregisterStash(stashId)
    end
end)
