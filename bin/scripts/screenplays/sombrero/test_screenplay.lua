TestScreenplay = ScreenPlay:new{
  screenplayName = "TestScreenplay",
  numberOfActs = 1
}

registerScreenPlay("TestScreenplay",true)

function TestScreenplay:start()
  self:spawnActor()
end

function TestScreenplay:spawnActor()
  local pMobile = spawnMobile("corellia", "testmobile", 1, -86, 28, -4546, 0, 0)

  if (pMobile == nil) then
    return
	end

  CreatureObject(pMobile):setCustomObjectName("Cold Poptarts")
  AiAgent(pMobile):setConvoTemplate("test_conv")

  print("conv set")
end
