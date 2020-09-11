buffvendor_conv = ConvoTemplate:new {
  initialScreen = "begin_conv",
  templateType = "Lua",
  luaClassHandler = "buffvendor_conv_handler",
  screens = {}
}

begin_conv = ConvoScreen:new {
  id = "begin_conv",
  customDialogText = "Is it power you seek?",
  stopConversation = "false",
  options = {
      {"Yes, I seek power to face my enemies!", "supplies_1"}
  }
}
buffvendor_conv:addScreen(begin_conv)

supplies_1 = ConvoScreen:new {
  id = "supplies_1",
  customDialogText = "",
  stopConversation = "false",
  options = {

  }
}
buffvendor_conv:addScreen(supplies_1)

nsf_buffs= ConvoScreen:new {
  id = "nsf_buffs",
  customDialogText = "Do not toy with my powers. Pay, or else.",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(nsf_buffs)

accept_buffs_music = ConvoScreen:new {
  id = "accept_buffs_music",
  customDialogText = "Rat tailed Jimmy is a second hand hood. He's the one they call Dr. Feelgood. He's the one that makes ya feel alright",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(accept_buffs_music)

accept_buffs_dance = ConvoScreen:new {
  id = "accept_buffs_dance",
  customDialogText = "You spin me right round baby, right round, like a disco droid baby, right round.",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(accept_buffs_dance)

accept_buffs_medical = ConvoScreen:new {
  id = "accept_buffs_medical",
  customDialogText = "...not to be indelicate but in my profession; if you've seen one, you've see them all",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(accept_buffs_medical)

accept_cleanse = ConvoScreen:new {
  id = "accept_cleanse",
  customDialogText = "Handcrafted soap is the best. No lye.",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(accept_cleanse)

decline_buffs = ConvoScreen:new {
  id = "decline_buffs",
  customDialogText = "Fine, go talk to that Whilins guy or those hippies in the cantina then, see if I care.",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(decline_buffs)


addConversationTemplate("buffvendor_conv", buffvendor_conv);
