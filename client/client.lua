RegisterNetEvent("adminitems:openCreativeMenu", function(itemList)
    local stashId = 'creative_items_' .. tostring(math.random(1000, 9999))

    exports.ox_inventory:RegisterStash(stashId, {
        label = 'Creative Items',
        slots = #itemList,
        maxWeight = 1000000,
        items = itemList
    })

    exports.ox_inventory:openInventory("stash", stashId)
end)




AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
end)
