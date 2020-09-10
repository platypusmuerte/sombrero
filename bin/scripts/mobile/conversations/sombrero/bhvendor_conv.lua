bhvendor_conv = ConvoTemplate:new {
  initialScreen = "begin_conv",
  templateType = "Lua",
  luaClassHandler = "bhvendor_conv_handler",
  screens = {}
}

begin_conv = ConvoScreen:new {
  id = "begin_conv",
  customDialogText = "What do you want?",
  stopConversation = "false",
  options = {
      {"Would you be willing to part with some supplies?", "supplies_1"}
  }
}
bhvendor_conv:addScreen(begin_conv)

supplies_1 = ConvoScreen:new {
  id = "supplies_1",
  customDialogText = "",
  stopConversation = "false",
  options = {

  }
}
bhvendor_conv:addScreen(supplies_1)

get_droids_1 = ConvoScreen:new {
  id = "get_droids_1",
  customDialogText = "I have some. It will cost you 6000 credits for a mission pack.",
  stopConversation = "false",
  options = {
    {"Sounds good, I'll take it","accept_droids"},
    {"Woa, thats a bit steep. Maybe not.","decline_droids"}
  }
}
bhvendor_conv:addScreen(get_droids_1)

nsf_droids = ConvoScreen:new {
  id = "nsf_droids",
  customDialogText = "Tryin' pull a fast one on me? Come back with some credits next time!",
  stopConversation = "true",
  options = {}
}
bhvendor_conv:addScreen(nsf_droids)

full_inv = ConvoScreen:new {
  id = "full_inv",
  customDialogText = "You're carrying around too much junk, stop wastin my time!",
  stopConversation = "true",
  options = {}
}
bhvendor_conv:addScreen(full_inv)

accept_droids = ConvoScreen:new {
  id = "accept_droids",
  customDialogText = "Alright then. Here you go.",
  stopConversation = "true",
  options = {}
}
bhvendor_conv:addScreen(accept_droids)

decline_droids = ConvoScreen:new {
  id = "decline_droids",
  customDialogText = "Hmm, ok then.",
  stopConversation = "true",
  options = {}
}
bhvendor_conv:addScreen(decline_droids)

addConversationTemplate("bhvendor_conv", bhvendor_conv);
