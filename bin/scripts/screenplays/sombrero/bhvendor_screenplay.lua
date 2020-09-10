BHVendorScreenplay = ScreenPlay:new{
  screenplayName = "BHVendorScreenplay",
  numberOfActs = 1,
  names = {
    npc = "a bounty hunter",
    ship = "an unmarked ship"
  },
  templates = {
    npc = "sombrero_bhvendor",
    ship = "object/ship/player/player_blacksun_light_s02.iff"
  }
}

registerScreenPlay("BHVendorScreenplay",true)

function BHVendorScreenplay:start()
  self:spawnActor()
end

function BHVendorScreenplay:spawnActor()
  -- corellia vendor
  local pMobile = spawnMobile("corellia", self.templates.npc, 1, 125.87, 28, -4619.34, 330, 0)
  local pMobileShip = spawnSceneObject("corellia",self.templates.ship, 138.42, 31, -4618.03, 0, 330)

  if (pMobile == nil or pMobileShip == nil) then
    return
	end

  CreatureObject(pMobile):setCustomObjectName(self.names.npc)
  SceneObject(pMobileShip):setCustomObjectName(self.names.ship)
  AiAgent(pMobile):setConvoTemplate("bhvendor_conv")

  -- tat vendor
  local pMobile2 = spawnMobile("tatooine", self.templates.npc, 1, 3242.77, 5, -4948.56, 330, 0)
  local pMobileShip2 = spawnSceneObject("tatooine",self.templates.ship, 3230.89, 8, -4934.79, 0, 330)

  if (pMobile2 == nil or pMobileShip2 == nil) then
    return
	end

  CreatureObject(pMobile2):setCustomObjectName(self.names.npc)
  SceneObject(pMobileShip2):setCustomObjectName(self.names.ship)
  AiAgent(pMobile2):setConvoTemplate("bhvendor_conv")
end
