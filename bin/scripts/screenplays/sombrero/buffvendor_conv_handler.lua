local http = require("socket.http")
buffvendor_conv_handler = Object:new {
  costmed = 6000,
  costdance = 2500,
  costmusic = 2500,
  costcleanse = 1000
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
      local body, c, h = http.request("http://swgemu.platypusmuerte.com/hotluasettings.php?allbuffs=1")
      local buffSettings = {}
      local availBuffTypes = 0

      -- doc dance music
      for substring in body:gmatch("%S+") do
        availBuffTypes = availBuffTypes + substring*1
        table.insert(buffSettings, substring*1)
      end

      local docActive = buffSettings[1]
      local danceActive = buffSettings[2]
      local musicActive = buffSettings[3]
      local cleanseActive = buffSettings[4]

      if availBuffTypes > 0 then
        clonedConversation:setCustomDialogText("Then you have come to the right place!")

        if docActive == 1 then
          clonedConversation:addOption("Medical buffs for " .. self.costmed .. ", Alex","accept_buffs_medical")
        end

        if danceActive == 1 then
          clonedConversation:addOption("I'll take Dancing for dollars, for " .. self.costdance .. "","accept_buffs_dance")
        end

        if musicActive == 1 then
          clonedConversation:addOption("Sing me the song of my people, for " .. self.costmusic .. "","accept_buffs_music")
        end

        if cleanseActive == 1 then
          clonedConversation:addOption("This house, is cleeeen, for " .. self.costcleanse .. "","accept_cleanse")
        end

        clonedConversation:addOption("Woa, thats a bit steep. Maybe not.","decline_buffs")
      else
        clonedConversation:setCustomDialogText("The Force is not a toy!")
        clonedConversation:addOption("Was worth a try, right?","decline_buffs")
      end

    elseif screenID == "accept_buffs_medical" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (credits < self.costmed) then
        return conversation:getScreen("nsf_buffs")
    	else
        cPlayer:subtractCashCredits(self.costmed)
        cPlayer:enhanceCharacterViaBot(1)
        cPlayer:sendSystemMessage("You have paid " .. self.costmed .. " credits for a touchy feely session with the Force")
        return conversation:getScreen("accept_buffs")
    	end
    elseif screenID == "accept_buffs_dance" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (credits < self.costdance) then
        return conversation:getScreen("nsf_buffs")
    	else
        cPlayer:subtractCashCredits(self.costdance)
        cPlayer:enhanceCharacterViaBot(2)
        cPlayer:sendSystemMessage("You have paid " .. self.costdance .. " credits for a touchy feely session with the Force")
        return conversation:getScreen("accept_buffs")
    	end
    elseif screenID == "accept_buffs_music" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (credits < self.costmusic) then
        return conversation:getScreen("nsf_buffs")
    	else
        cPlayer:subtractCashCredits(self.costmusic)
        cPlayer:enhanceCharacterViaBot(3)
        cPlayer:sendSystemMessage("You have paid " .. self.costmusic .. " credits for a touchy feely session with the Force")
        return conversation:getScreen("accept_buffs")
    	end
    elseif screenID == "accept_cleanse" then
      local credits = cPlayer:getCashCredits()
      local pInventory = cPlayer:getSlottedObject("inventory")
      local inventory = LuaSceneObject(pInventory)

    	if (credits < self.costcleanse) then
        return conversation:getScreen("nsf_buffs")
    	else
        cPlayer:subtractCashCredits(self.costmusic)
        
        for i = 0,8 do
          cPlayer:setWounds(i, 0);
        end

        cPlayer:setShockWounds(0);

        cPlayer:sendSystemMessage("You have paid " .. self.costcleanse .. " credits for a touchy feely session with the Force")
        return conversation:getScreen("accept_buffs")
    	end
    end

    return pConvScreen
end
