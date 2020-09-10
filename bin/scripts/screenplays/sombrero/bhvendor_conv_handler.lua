local http = require("socket.http")
bhvendor_conv_handler = Object:new {
  cost = 6000,
  seeker = "object/tangible/mission/mission_bounty_droid_seeker.iff",
  probot = "object/tangible/mission/mission_bounty_droid_probot.iff"
}

function bhvendor_conv_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)
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

function bhvendor_conv_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
    local conversation = LuaConversationTemplate(conversationTemplate)
    local player = LuaSceneObject(conversingPlayer)
    local screen = LuaConversationScreen(conversationScreen)
    local screenID = screen:getScreenID()
    local pConvScreen = screen:cloneScreen()
    local clonedConversation = LuaConversationScreen(pConvScreen)
    local cPlayer = CreatureObject(conversingPlayer)

    if screenID == "supplies_1" then
      local body, c, h = http.request("http://swgemu.platypusmuerte.com/hotluasettings.php?bhvendor=1")

      if body == "1" then
        clonedConversation:setCustomDialogText("I suppose I could. For a price.")
        clonedConversation:addOption("I need some droids for a mission","get_droids_1")
    	else
        clonedConversation:setCustomDialogText("Pfft, why don't I just give you my gun too, huh?")
        clonedConversation:addOption("Was worth a try, right?","decline_droids")
    	end
    elseif screenID == "accept_droids" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
    		return conversation:getScreen("full_inv")
      elseif (credits < self.cost) then
        return conversation:getScreen("nsf_droids")
    	else
        cPlayer:subtractCashCredits(self.cost)
        local seeker = giveItem(pInventory, self.seeker, -1)
        local probot = giveItem(pInventory, self.probot, -1)

        cPlayer:sendSystemMessage("You have paid " .. self.cost .. " credits for a mission kit")
    	end
    end

    return pConvScreen
end
