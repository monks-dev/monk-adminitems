local isMenuOpen = false

RegisterCommand('itemsMenu', function()
    TriggerServerEvent('creativeItemMenu:requestOpen')
end, false)

RegisterNetEvent('creativeItemMenu:open', function(itemsList)
    SendNUIMessage({
        action = 'openMenu',
        items = itemsList
    })
    SetNuiFocus(true, true)
    isMenuOpen = true
end)

RegisterNUICallback('closeMenu', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeMenu' }) -- Optional: tell the UI to hide itself
    cb('ok')
end)

RegisterNUICallback('addItem', function(data, cb)
    local itemName = data.itemName
    local amount = tonumber(data.amount) or 1

    if itemName then
        TriggerServerEvent('creativeItemMenu:addItem', itemName, amount)
    end

    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 322) then -- ESC key
            SetNuiFocus(false, false)
            SendNUIMessage({ action = 'closeMenu' })
        end
    end
end)
