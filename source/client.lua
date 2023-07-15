username = nil
cooldown = false
muted = false

RegisterNetEvent('lifeinvade:post')
AddEventHandler('lifeinvade:post', function(username, message)
    if not muted then
        SendNUIMessage({
            type = "post",
            display = true,
            username = username,
            message = message
        })
    end
end)


RegisterCommand('lifeinvade', function(source, args, rawCommand)
    if username == nil then 
        TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0You must set your LifeInvader name first. Use /lifename <name> to set your name.')
        return 
    end
    if cooldown then
        TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0You must wait 60 seconds between posts.')
        return
    end

    args = table.concat(args, ' ')
    TriggerServerEvent('lifeinvade:post', username, args)
    cooldown = true
    Citizen.Wait(60000)
    cooldown = false
end)


-- Setting username
RegisterCommand('lifename', function(source, args, rawCommand)
    if not args[1] then
        TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0Your current LifeInvader name is ' .. username .. '')
    else
        if string.len(args[1]) > 12 then
            TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0Your LifeInvader name cannot be longer than 12 characters.')
            return
        end

        username = args[1]
        TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0Your LifeInvader name is now ' .. username .. '')
    end
end)

RegisterCommand('lifeinvademute', function(source, args, rawCommand)
    if muted then
        muted = false
        TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0LifeInvader is now unmuted.')
    else
        muted = true
        TriggerEvent('chatMessage', '^1[LifeInvader]', {255, 0, 0}, '^0LifeInvader is now muted.')
    end
end)