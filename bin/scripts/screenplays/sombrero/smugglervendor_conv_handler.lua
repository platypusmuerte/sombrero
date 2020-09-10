local http = require("socket.http")
smugglervendor_conv_handler = Object:new {
  cost = 3000,
  clamp = "object/tangible/slicing/slicing_molecular_clamp.iff",
  flow = "object/tangible/slicing/slicing_flow_analyzer.iff"
}

function smugglervendor_conv_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)
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

function smugglervendor_conv_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
    local conversation = LuaConversationTemplate(conversationTemplate)
    local player = LuaSceneObject(conversingPlayer)
    local screen = LuaConversationScreen(conversationScreen)
    local screenID = screen:getScreenID()
    local pConvScreen = screen:cloneScreen()
    local clonedConversation = LuaConversationScreen(pConvScreen)
    local cPlayer = CreatureObject(conversingPlayer)

    if screenID == "supplies_1" then
      local body, c, h = http.request("http://swgemu.platypusmuerte.com/hotluasettings.php?smuggler=1")

      if body == "1" then
        clonedConversation:setCustomDialogText("If you got the credits, anything is for sale.")
        clonedConversation:addOption("I need some tools for a quick slice","get_tools_1")
    	else
        clonedConversation:setCustomDialogText("You're drawin too much attention, SCRAM")
        clonedConversation:addOption("Was worth a try, right?","decline_tools")
    	end
    elseif screenID == "accept_tools" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
    		return conversation:getScreen("full_inv")
      elseif (credits < self.cost) then
        return conversation:getScreen("nsf_droids")
    	else
        cPlayer:subtractCashCredits(self.cost)
        local clamp1 = giveItem(pInventory, self.clamp, -1)
        local clamp2 = giveItem(pInventory, self.clamp, -1)
        local clamp3 = giveItem(pInventory, self.clamp, -1)
        local clamp4 = giveItem(pInventory, self.clamp, -1)
        local clamp5 = giveItem(pInventory, self.clamp, -1)

        local flow1 = giveItem(pInventory, self.flow, -1)
        local flow2 = giveItem(pInventory, self.flow, -1)
        local flow3 = giveItem(pInventory, self.flow, -1)
        local flow4 = giveItem(pInventory, self.flow, -1)
        local flow5 = giveItem(pInventory, self.flow, -1)

        cPlayer:sendSystemMessage("You have paid " .. self.cost .. " credits for a set of tools")
    	end
    end

    return pConvScreen
end
