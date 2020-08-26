JediManager = require("managers.jedi.jedi_manager")
local Logger = require("utils.logger")
local QuestManager = require("managers.quest.quest_manager")
local http = require("socket.http")

jediManagerName = "CustomJediManager"

NOTINABUILDING = 0
NUMBEROFPROFESSIONSTOMASTER = 6
MAXIMUMNUMBEROFPROFESSIONSTOSHOWWITHHOLOCRON = NUMBEROFPROFESSIONSTOMASTER - 2

CustomJediManager = JediManager:new {
	screenplayName = jediManagerName,
	jediManagerName = jediManagerName,
	jediProgressionType = CUSTOMJEDIPROGRESSION,
	startingEvent = nil,
}

-- Return a list of all professions and their badge number that are available for the hologrind
-- @return a list of professions and their badge numbers.
function CustomJediManager:getGrindableProfessionList()
	local grindableProfessions = {
		{ "crafting_architect_master", 		CRAFTING_ARCHITECT_MASTER  },
		{ "crafting_armorsmith_master", 	CRAFTING_ARMORSMITH_MASTER  },
		{ "crafting_artisan_master", 		CRAFTING_ARTISAN_MASTER  },
		{ "outdoors_bio_engineer_master", 	OUTDOORS_BIOENGINEER_MASTER  },
		{ "combat_bountyhunter_master", 	COMBAT_BOUNTYHUNTER_MASTER  },
		{ "combat_brawler_master", 		COMBAT_BRAWLER_MASTER  },
		{ "combat_carbine_master", 		COMBAT_CARBINE_MASTER  },
		{ "crafting_chef_master", 		CRAFTING_CHEF_MASTER  },
		{ "science_combatmedic_master", 	SCIENCE_COMBATMEDIC_MASTER  },
		{ "combat_commando_master", 		COMBAT_COMMANDO_MASTER  },
		{ "outdoors_creaturehandler_master", 	OUTDOORS_CREATUREHANDLER_MASTER  },
		{ "social_dancer_master", 		SOCIAL_DANCER_MASTER  },
		{ "science_doctor_master", 		SCIENCE_DOCTOR_MASTER  },
		{ "crafting_droidengineer_master", 	CRAFTING_DROIDENGINEER_MASTER  },
		{ "social_entertainer_master", 		SOCIAL_ENTERTAINER_MASTER  },
		{ "combat_1hsword_master", 		COMBAT_1HSWORD_MASTER  },
		{ "social_imagedesigner_master", 	SOCIAL_IMAGEDESIGNER_MASTER  },
		{ "combat_marksman_master", 		COMBAT_MARKSMAN_MASTER  },
		{ "science_medic_master", 		SCIENCE_MEDIC_MASTER  },
		{ "crafting_merchant_master", 		CRAFTING_MERCHANT_MASTER  },
		{ "social_musician_master", 		SOCIAL_MUSICIAN_MASTER  },
		{ "combat_polearm_master", 		COMBAT_POLEARM_MASTER  },
		{ "combat_pistol_master", 		COMBAT_PISTOL_MASTER  },
		{ "outdoors_ranger_master", 		OUTDOORS_RANGER_MASTER  },
		{ "combat_rifleman_master", 		COMBAT_RIFLEMAN_MASTER  },
		{ "outdoors_scout_master", 		OUTDOORS_SCOUT_MASTER  },
		{ "combat_smuggler_master", 		COMBAT_SMUGGLER_MASTER  },
		{ "outdoors_squadleader_master", 	OUTDOORS_SQUADLEADER_MASTER  },
		{ "combat_2hsword_master", 		COMBAT_2HSWORD_MASTER  },
		{ "crafting_tailor_master", 		CRAFTING_TAILOR_MASTER  },
		{ "crafting_weaponsmith_master", 	CRAFTING_WEAPONSMITH_MASTER  },
		{ "combat_unarmed_master", 		COMBAT_UNARMED_MASTER  }
	}
	return grindableProfessions
end

-- Handling of the onPlayerCreated event.
-- Hologrind professions will be generated for the player.
-- @param pCreatureObject pointer to the creature object of the created player.
function CustomJediManager:onPlayerCreated(pCreatureObject)
	local skillList = self:getGrindableProfessionList()

	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return
	end

	-- note might hit same one twice
	for i = 1, NUMBEROFPROFESSIONSTOMASTER, 1 do
		local numberOfSkillsInList = #skillList
		local skillNumber = getRandomNumber(1, numberOfSkillsInList)

		local skill = skillList[skillNumber][2]

		if (skill == nil) then
			skillNumber = getRandomNumber(1, numberOfSkillsInList)
			skill = skillList[skillNumber][2]
		end

		if (skill == nil) then
			skillNumber = getRandomNumber(1, numberOfSkillsInList)
			skill = skillList[skillNumber][2]
		end

		if (skill == nil) then
			skillNumber = getRandomNumber(1, numberOfSkillsInList)
			skill = skillList[skillNumber][2]
		end

		if (skill == nil) then
			skillNumber = getRandomNumber(1, numberOfSkillsInList)
			skill = skillList[skillNumber][2]
		end

		PlayerObject(pGhost):addHologrindProfession(skill)
		table.remove(skillList, skillNumber)
	end
end

-- Check and count the number of mastered hologrind professions.
-- @param pCreatureObject pointer to the creature object of the player which should get its number of mastered professions counted.
-- @return the number of mastered hologrind professions.
function CustomJediManager:getNumberOfMasteredProfessions(pCreatureObject)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return 0
	end

	local professions = PlayerObject(pGhost):getHologrindProfessions()
	local masteredNumberOfProfessions = 0
	for i = 1, #professions, 1 do
		if PlayerObject(pGhost):hasBadge(professions[i]) then
			masteredNumberOfProfessions = masteredNumberOfProfessions + 1
		end
	end
	return masteredNumberOfProfessions
end

-- Check if the player is jedi.
-- @param pCreatureObject pointer to the creature object of the player to check if he is jedi.
-- @return returns if the player is jedi or not.
function CustomJediManager:isJedi(pCreatureObject)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	return PlayerObject(pGhost):isJedi()
end

-- Sui window ok pressed callback function.
function CustomJediManager:notifyOkPressed()
-- Do nothing.
end

-- Send a sui window to the player about unlocking jedi and award jedi status and force sensitive skill.
-- @param pCreatureObject pointer to the creature object of the player who unlocked jedi.
function CustomJediManager:sendSuiWindow(pCreatureObject)

end

-- Award skill and jedi status to the player.
-- @param pCreatureObject pointer to the creature object of the player who unlocked jedi.
function CustomJediManager:awardJediStatusAndSkill(pCreatureObject)

end

-- Check if the player has mastered all hologrind professions and send sui window and award skills.
-- @param pCreatureObject pointer to the creature object of the player to check the jedi progression on.
function CustomJediManager:checkIfProgressedToJedi(pCreatureObject)
	--local pPlayer = CreatureObject(pCreatureObject):getPlayerObject()
	local hasRankOne = CreatureObject(pCreatureObject):hasSkill("force_title_jedi_rank_01")
	local hasRankTwo = CreatureObject(pCreatureObject):hasSkill("force_title_jedi_rank_02")
	local hasNovice = CreatureObject(pCreatureObject):hasSkill("force_title_jedi_novice")

	if hasNovice and not hasRankOne then
		-- you bailed on us anikin
	elseif hasNovice and hasRankOne then
		-- noop
	elseif hasRankTwo then
		-- completed template builder
	else
		--  and not self:isJedi(pCreatureObject)
		if self:getNumberOfMasteredProfessions(pCreatureObject) >= NUMBEROFPROFESSIONSTOMASTER then
	    self:isPopCapped(pCreatureObject)
		end
	end
end

-- Is jedi pop capped?
function CustomJediManager:isPopCapped(pCreatureObject)
	local body, c, h = http.request("http://swgemu.platypusmuerte.com/jediok.php")

	if body == "yes" then
		self:jediPopCapped(pCreatureObject)
	else
		self:jediPathDecision(pCreatureObject)
	end
end

-- send message about pop cap
function CustomJediManager:jediPopCapped(pCreatureObject)
	local suiManager = LuaSuiManager()
	local pPlayer = CreatureObject(pCreatureObject):getPlayerObject()

	local msg = [[
	Today on NewsNet
	Todays news is brou(#!daspo989i799k tr456h 6789hisftgh...
	>This is Mast(#&*kd3g97h8klhumd3g..> of the Jed{*&#OJY78kjuy...
	>The council will not allow any more Jedi}#kji78k...
	>to be trained at this time(*&#k78hgf6dgvf5g6h...
	>I will contact you soon again{*&#OJY78kjuy.
	>(#&*kd3g97h8klhumd3g..>nk you for using NewsNet
	]]

	suiManager:sendMessageBox(pPlayer, pCreatureObject, "Encrypted Transmission Detected", msg, "@ok", "CustomJediManager", "popCapResponseOK")
end

function CustomJediManager:popCapResponseOK()

end

-- Ask player if they want to pursue the force or not
-- @param pCreatureObject pointer to the creature object of the player
function CustomJediManager:jediPathDecision(pCreatureObject)
	local suiManager = LuaSuiManager()
	local pPlayer = CreatureObject(pCreatureObject):getPlayerObject()

	local msg = [[
	Today on NewsNet
	Tuskens were reported to be gath(#!daspo989i799k tr456h 6789hisftgh...
	>This is Mast(#&*kd3g97h8klhumd3g..> of the Jed{*&#OJY78kjuy...
	>I can only hope you get this message}#kji78k...
	>
	>I sense your time has come. You must have felt it too(*&#k78hgf6dgvf5g6h...
	>
	>If you choose this path, you will be hunted by those who feel we should not exist.
	>
	>If you accept to embark on this journey, you will forever be marked as a Jedi regardless of your progression with the Force.
	>
	>(You will not be able to unlearn the base Jedi template, if you proceed)
	>
	>(If you accept, it might take a few minutes for skill tree to update. If no change after 5 minutes, relog)
	>
	>If you accept, we will request your presence once your training is near completed, and feel you are ready for your trials{*&#OJY78kjuy...
	>(#!daspo989i799k tr456h 6789hisftgh...
	>(#&*kd3g97h8klhumd3g..> weather on Talus.
	End NewsNet Broadcast
	]]

	suiManager:sendMessageBox(pPlayer, pCreatureObject, "Encrypted Transmission Detected", msg, "@ok", "CustomJediManager", "jediPathDecisionResponse")
end

-- Set flags to prevent asking again, or trigger making them jedi
function CustomJediManager:jediPathDecisionResponse(pPlayer, pSui, eventIndex, args)
	if (pPlayer == nil) then
		return
	end

	local cancelPressed = (eventIndex == 1)

	if cancelPressed then
		self:declinedJedi(pPlayer)
	else
		self:acceptedJedi(pPlayer)
	end
end

-- Set flags so player isnt prompted about jedi again
function CustomJediManager:declinedJedi(pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	awardSkill(pPlayer, "force_title_jedi_novice")
	PlayerObject(pGhost):setJediState(1)
end

-- Attempt set player as jedi
function CustomJediManager:acceptedJedi(pPlayer)
	self:applyJediTemplate(pPlayer)
end

-- aply jedi template
function CustomJediManager:applyJediTemplate(pPlayer)
	if (pPlayer == nil) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	self:learnNovice(pPlayer)
	self:learnForceSensitives(pPlayer)

	if self:hasMetRequirement(pPlayer) then
		awardSkill(pPlayer, "force_title_jedi_rank_01")
		awardSkill(pPlayer, "force_title_jedi_rank_02")
		PlayerObject(pGhost):setJediState(2)

		self:addJediInventory(pPlayer)
		self:sendJediEmail(pPlayer)
		self:facyJediStuff(pPlayer)

		local httpCall = http.request("http://swgemu.platypusmuerte.com/jq.php?newjedi=1")
	else
		self:failedApplyResponse(pPlayer)
	end
end

-- did not apply template
function CustomJediManager:failedApplyingTemplate(pPlayer)
	local suiManager = LuaSuiManager()

	suiManager:sendMessageBox(pPlayer, pPlayer, "Failed Applying Template", "You need at least 24 free skill points. Unlearn some skills, and relog to proceed.", "@ok", "CustomJediManager", "failedApplyResponse")
end

function CustomJediManager:failedApplyResponse(pPlayer)
	CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:revoke_force_title")
	CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:revoke_force_sensitive")
end

-- add jedi inventory items
function CustomJediManager:addJediInventory(pPlayer)

	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

	if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
	else
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		local pItem = giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_padawan.iff", -1)
	end
end

-- send out the email
function CustomJediManager:sendJediEmail(pPlayer)
	sendMail("system", "@jedi_spam:welcome_subject", "@jedi_spam:welcome_body", CreatureObject(pPlayer):getFirstName())
end

-- do the fancy fancy stuff
function CustomJediManager:facyJediStuff(pPlayer)
	CreatureObject(pPlayer):playEffect("clienteffect/trap_electric_01.cef", "")
	CreatureObject(pPlayer):playMusicMessage("sound/music_become_jedi.snd")
end

function CustomJediManager:hasMetRequirement(pPlayer)
	if (CreatureObject(pPlayer):getForceSensitiveSkillCount(false) < 24) then
		return false
	else
		return true
	end
end

-- Event handler for the BADGEAWARDED event.
-- @param pCreatureObject pointer to the creature object of the player who was awarded with a badge.
-- @param pCreatureObject2 pointer to the creature object of the player who was awarded with a badge.
-- @param badgeNumber the badge number that was awarded.
-- @return 0 to keep the observer active.
function CustomJediManager:badgeAwardedEventHandler(pCreatureObject, pCreatureObject2, badgeNumber)
	if (pCreatureObject == nil) then
		return 0
	end

	self:checkIfProgressedToJedi(pCreatureObject)

	return 0
end

-- Register observer on the player for observing badge awards.
-- @param pCreatureObject pointer to the creature object of the player to register observers on.
function CustomJediManager:registerObservers(pCreatureObject)
	createObserver(BADGEAWARDED, "CustomJediManager", "badgeAwardedEventHandler", pCreatureObject)
end

-- Handling of the onPlayerLoggedIn event. The progression of the player will be checked and observers will be registered.
-- @param pCreatureObject pointer to the creature object of the player who logged in.
function CustomJediManager:onPlayerLoggedIn(pCreatureObject)
	if (pCreatureObject == nil) then
		return
	end

	self:checkIfProgressedToJedi(pCreatureObject)
	self:registerObservers(pCreatureObject)
end

-- Get the profession name from the badge number.
-- @param badgeNumber the badge number to find the profession name for.
-- @return the profession name associated with the badge number, Unknown profession returned if the badge number isn't found.
function CustomJediManager:getProfessionStringIdFromBadgeNumber(badgeNumber)
	local skillList = self:getGrindableProfessionList()
	for i = 1, #skillList, 1 do
		if skillList[i][2] == badgeNumber then
			return skillList[i][1]
		end
	end
	return "Unknown profession"
end

-- Find out and send the response from the holocron to the player
-- @param pCreatureObject pointer to the creature object of the player who used the holocron.
function CustomJediManager:sendHolocronMessage(pCreatureObject)
	if self:getNumberOfMasteredProfessions(pCreatureObject) >= MAXIMUMNUMBEROFPROFESSIONSTOSHOWWITHHOLOCRON then
		-- The Holocron is quiet. The ancients' knowledge of the Force will no longer assist you on your journey. You must continue seeking on your own.
		CreatureObject(pCreatureObject):sendSystemMessage("@jedi_spam:holocron_quiet")
		return true
	else
		local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

		if (pGhost == nil) then
			return false
		end

		local professions = PlayerObject(pGhost):getHologrindProfessions()
		for i = 1, #professions, 1 do
			if not PlayerObject(pGhost):hasBadge(professions[i]) then
				local professionText = self:getProfessionStringIdFromBadgeNumber(professions[i])
				CreatureObject(pCreatureObject):sendSystemMessageWithTO("@jedi_spam:holocron_light_information", "@skl_n:" .. professionText)
				break
			end
		end

		return false
	end
end

-- Handling of the useItem event.
-- @param pSceneObject pointer to the item object.
-- @param itemType the type of item that is used.
-- @param pCreatureObject pointer to the creature object that used the item.
function CustomJediManager:useItem(pSceneObject, itemType, pCreatureObject)
	if (pCreatureObject == nil or pSceneObject == nil) then
		return
	end

	if itemType == ITEMHOLOCRON then
		local isSilent = self:sendHolocronMessage(pCreatureObject)
		if isSilent then
			return
		else
			SceneObject(pSceneObject):destroyObjectFromWorld()
			SceneObject(pSceneObject):destroyObjectFromDatabase()
		end
	end
end

function CustomJediManager:canLearnSkill(pPlayer, skillName)
	return true
end

--Check to ensure force skill prerequisites are maintained
function CustomJediManager:canSurrenderSkill(pPlayer, skillName)
	CreatureObject(pPlayer):sendSystemMessage(skillName)

	--[[if string.find(skillName, "force_sensitive_") then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:revoke_force_sensitive")
		return false
	end]]

	if skillName == "force_title_jedi_rank_02" then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:revoke_force_sensitive")
		return false
	end

	--[[if skillName == "force_title_jedi_rank_01" then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:revoke_force_sensitive")
		return false
	end]]

	return true
end

-- can you learns it?
function CustomJediManager:canLearnFsSkill(pPlayer, skillName)
	local skillManager = LuaSkillManager()

	return (skillManager:canLearnSkill(pPlayer, skillName, true))
end

function CustomJediManager:learnNovice(pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	awardSkill(pPlayer, "force_title_jedi_novice")
	PlayerObject(pGhost):setJediState(1)
end

function CustomJediManager:learnForceSensitives(pPlayer)
	awardSkill(pPlayer, "force_sensitive_combat_prowess_melee_accuracy_04")
	awardSkill(pPlayer, "force_sensitive_combat_prowess_melee_speed_04")
	awardSkill(pPlayer, "force_sensitive_enhanced_reflexes_ranged_defense_04")
	awardSkill(pPlayer, "force_sensitive_enhanced_reflexes_melee_defense_04")
	awardSkill(pPlayer, "force_sensitive_heightened_senses_healing_04")
	awardSkill(pPlayer, "force_sensitive_heightened_senses_luck_04")
end

registerScreenPlay("CustomJediManager", true)

return CustomJediManager
