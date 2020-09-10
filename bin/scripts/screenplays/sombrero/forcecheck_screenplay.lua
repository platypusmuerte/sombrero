ForceCheckScreenplay = ScreenPlay:new{
  screenplayName = "ForceCheckScreenplay",
  numberOfActs = 1
}

registerScreenPlay("ForceCheckScreenplay",true)

function ForceCheckScreenplay:start()
  self:spawnActor()
end

function ForceCheckScreenplay:spawnActor()
  --[[local pMobile = spawnMobile("corellia", "sombrero_forcecheck", 1, -339.42, 0, -4505.34, -10, 0)

  if (pMobile == nil) then
    return
	end

  CreatureObject(pMobile):setCustomObjectName("Cold Poptarts")
  AiAgent(pMobile):setConvoTemplate("forcecheck_conv")]]
end
