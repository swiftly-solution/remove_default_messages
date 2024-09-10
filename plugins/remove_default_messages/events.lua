local filterMessages = {}

AddEventHandler("OnPluginStart", function()
	local list = config:Fetch("remove_default_messages.MessageList")
	for i=1,#list do
		filterMessages["#"..list[i]] = true
	end
end)

AddEventHandler("OnRoundStart", function()
    if config:Fetch("remove_default_messages.DisableGrenadeRadio") then
        server:Execute("sv_ignoregrenaderadio true")
    end
end)

AddEventHandler("OnUserMessageSend", function(event, um, isreliable)
    local user = GetUserMessage(um)
    local msgid = user:GetMessageID()
    
    if (msgid == 418 or msgid == 411) and config:Fetch("remove_default_messages.RemoveBlood") then
        return EventResult.Stop
    end

    if msgid == 124 then
        local msg = user:GetRepeatedString("param", 0)
        if filterMessages[msg] then
	    return EventResult.Stop
        end
    end
end)

AddEventHandler("OnPlayerTeam", function(event)
    event:SetBool("silent", true)
end)
