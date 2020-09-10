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

get_buffs_1 = ConvoScreen:new {
  id = "get_buffs_1",
  customDialogText = "I can channel the powers of the Force to temporarily enhance you, but to do this, comes at a cost. 10000 credits to be precise.",
  stopConversation = "false",
  options = {
    {"I'll pay whatever you're asking!","accept_buffs"},
    {"Woa, thats a bit steep. Maybe not.","decline_buffs"}
  }
}
buffvendor_conv:addScreen(get_buffs_1)

nsf_buffs= ConvoScreen:new {
  id = "nsf_buffs",
  customDialogText = "Do not toy with my powers. Pay, or else.",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(nsf_buffs)

accept_buffs = ConvoScreen:new {
  id = "accept_buffs",
  customDialogText = "Rat tailed Jimmy is a second hand hood. He's the one they call Dr. Feelgood. He's the one that makes ya feel alright",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(accept_buffs)

decline_buffs = ConvoScreen:new {
  id = "decline_buffs",
  customDialogText = "Fine, go talk to that Whilins guy then, see if I care.",
  stopConversation = "true",
  options = {}
}
buffvendor_conv:addScreen(decline_buffs)


addConversationTemplate("buffvendor_conv", buffvendor_conv);
