RegisterNetEvent("lifeinvade:post")
AddEventHandler("lifeinvade:post", function(username, message)
    TriggerClientEvent("lifeinvade:post", -1, username, message)
    if Config.logging.enable then
        LogToDiscord(username, message)
    end
end)

function LogToDiscord(username, args)
    local embed = {
        {
            ["color"] = 16711680,
            ["title"] = "LifeInvader Post",
            ["description"] = "A new LifeInvader post has been made.",
            ["fields"] = {
                {
                    ["name"] = "Username",
                    ["value"] = username,
                    ["inline"] = true
                },
                {
                    ["name"] = "Message",
                    ["value"] = args,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player Name",
                    ["value"] = GetPlayerName(source),
                    ["inline"] = true
                },
            },
            ["footer"] = {
                ["text"] = "Lifeinvade By scentral",
            },
        }
    }

    PerformHttpRequest(Config.logging.webhook, function(errorCode, resultData, resultHeaders)
        print("HTTP Request Callback")
        print("Error Code:", errorCode)
        print("Response:", resultData)
        print("Headers:", resultHeaders)
    end, 'POST', json.encode({username = "LifeInvade", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

print('Lifeinvader by scentral')
