local http = require("socket.http")
buffvendor_conv_handler = Object:new {
  cost = 10000
}

function buffvendor_conv_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)
    local creature = LuaCreatureObject(conversingPlayer)
    local convosession = creature:getConversationSession()
    lastConversation = nil
    local conversation = LuaConversationTemplate(conversationTemplate)

    if ( conversation ~= nil ) then
        if ( convosession ~= nil ) then
            local session = LuaConversationSession(convosession)
            if ( session ~= nil ) then
                lastConversationScreen = session:getLastConversationScreen()
            end
        end

        if ( lastConversationScreen == nil ) then
            nextConversationScreen = conversation:getScreen("begin_conv")
        else
            local luaLastConversationScreen = LuaConversationScreen(lastConversationScreen)
            local optionLink = luaLastConversationScreen:getOptionLink(selectedOption)
            nextConversationScreen = conversation:getScreen(optionLink)
        end
    end

    return nextConversationScreen
end

function buffvendor_conv_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
    local conversation = LuaConversationTemplate(conversationTemplate)
    local player = LuaSceneObject(conversingPlayer)
    local screen = LuaConversationScreen(conversationScreen)
    local screenID = screen:getScreenID()
    local pConvScreen = screen:cloneScreen()
    local clonedConversation = LuaConversationScreen(pConvScreen)
    local cPlayer = CreatureObject(conversingPlayer)

    if screenID == "supplies_1" then
      local body, c, h = http.request("http://swgemu.platypusmuerte.com/hotluasettings.php?docbuff=1")

      if body == "1" then
        clonedConversation:setCustomDialogText("Then you have come to the right place!")
        clonedConversation:addOption("Lay it on me daddy","get_buffs_1")
    	else
        clonedConversation:setCustomDialogText("The Force is not a toy!")
        clonedConversation:addOption("Was worth a try, right?","decline_buffs")
    	end
    elseif screenID == "accept_buffs" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (credits < self.cost) then
        return conversation:getScreen("nsf_buffs")
    	else
        cPlayer:subtractCashCredits(self.cost)
        cPlayer:enhanceCharacter()
        cPlayer:sendSystemMessage("You have paid " .. self.cost .. " credits for a touchy feely session with the Force")
    	end
    end

    return pConvScreen
end
