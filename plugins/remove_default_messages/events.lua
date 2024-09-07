AddEventHandler("OnRoundStart", function()
    if config:Fetch("remove_default_messages.DisableGrenadeRadio") then
        server:Execute("sv_ignoregrenaderadio true")
    end

end)


AddEventHandler("OnUserMessageSend", function(event, playerid, um, isreliable)
    local user = GetUserMessage(um)

    if config:Fetch("remove_default_messages.RemoveBlood") then
        if GetUserMessage(um):GetMessageName():find("CMsgTEBloodStream") then return EventResult.Stop end
        if GetUserMessage(um):GetMessageName():find("CMsgTEWorldDecal") then return EventResult.Stop end
    end

    if user:GetMessageName():find("TextMsg") then
        local messages = config:Fetch("remove_default_messages.MessageList")
        for i = 1, #messages do
            if user:GetRepeatedString("param", 0):find(messages[i], 1, true) then
                return EventResult.Stop
            end
        end
    end
end)

AddEventHandler("OnPlayerTeam", function(event)
    event:SetBool("silent", true)
end)
