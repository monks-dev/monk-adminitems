-- Create a table to store all configuration settings
Config = {}

Config.Framework = 'qbx' -- qb, qbx, esx

Config.Notification = 'ox'
Config.Progress = 'ox'



AddEventHandler("onResourceStart", function()
    Wait(2000)
    if GetResourceState('ox_inventory') == 'started' then
        Config.Inventory = 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then
        Config.Inventory = 'qb'
    end
end)
