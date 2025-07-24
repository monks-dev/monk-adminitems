RegisterNetEvent("adminitems:openCreativeMenu", function(stashId)
    exports.ox_inventory:openInventory("stash", stashId)
end)

RegisterNetEvent('ox_inventory:stashClosed', function(stashId)
    TriggerServerEvent('adminitems:closedCreativeMenu', stashId)
end)


AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
end)
