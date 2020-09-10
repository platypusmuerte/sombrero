SmugglerVendorScreenplay = ScreenPlay:new{
  screenplayName = "SmugglerVendorScreenplay",
  numberOfActs = 1,
  names = {
    npc = "a smuggler"
  },
  templates = {
    npc = "sombrero_smugglervendor"
  }
}

registerScreenPlay("SmugglerVendorScreenplay",true)

function SmugglerVendorScreenplay:start()
  self:spawnActor()
end

function SmugglerVendorScreenplay:spawnActor()
  -- corellia vendor
  local pMobile = spawnMobile("corellia", self.templates.npc, 1, -490.27,29.00,-4666.47, 90, 0)

  if (pMobile == nil) then
    return
	end

  CreatureObject(pMobile):setCustomObjectName(self.names.npc)
  CreatureObject(pMobile):setMoodString("npc_use_terminal_high")
  AiAgent(pMobile):setConvoTemplate("smugglervendor_conv")

  -- tat vendor
  local pMobile2 = spawnMobile("tatooine", self.templates.npc, 1, 3706.47, 5.00,-4862.17, 90, 0)

  if (pMobile2 == nil) then
    return
	end

  CreatureObject(pMobile2):setCustomObjectName(self.names.npc)
  CreatureObject(pMobile2):setMoodString("npc_use_terminal_high")
  AiAgent(pMobile2):setConvoTemplate("smugglervendor_conv")
end
