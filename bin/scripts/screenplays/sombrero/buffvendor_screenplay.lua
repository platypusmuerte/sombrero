BuffVendorScreenplay = ScreenPlay:new{
  screenplayName = "BuffVendorScreenplay",
  numberOfActs = 1,
  names = {
    npc = "a cloaked individual"
  },
  templates = {
    npc = "sombrero_buffvendor"
  }
}

registerScreenPlay("BuffVendorScreenplay",true)

function BuffVendorScreenplay:start()
  self:spawnActor()
end

function BuffVendorScreenplay:spawnActor()
  -- corellia vendor
  local pMobile = spawnMobile("corellia", self.templates.npc, 1, -314.04,28.00,-4698.30, 30, 0)

  if (pMobile == nil) then
    return
	end

  CreatureObject(pMobile):setCustomObjectName(self.names.npc)
  AiAgent(pMobile):setConvoTemplate("buffvendor_conv")

  -- tat vendor
  local pMobile2 = spawnMobile("tatooine", self.templates.npc, 1, 3429.58, 5.00,-4882.31, 90, 0)

  if (pMobile2 == nil) then
    return
	end

  CreatureObject(pMobile2):setCustomObjectName(self.names.npc)
  AiAgent(pMobile2):setConvoTemplate("buffvendor_conv")
end
