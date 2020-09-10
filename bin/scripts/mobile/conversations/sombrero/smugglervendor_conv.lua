smugglervendor_conv = ConvoTemplate:new {
  initialScreen = "begin_conv",
  templateType = "Lua",
  luaClassHandler = "smugglervendor_conv_handler",
  screens = {}
}

begin_conv = ConvoScreen:new {
  id = "begin_conv",
  customDialogText = "Careful dammit, or you'll get us both killed!",
  stopConversation = "false",
  options = {
      {"Sorry, I just thought you might sell some of your supplies?", "supplies_1"}
  }
}
smugglervendor_conv:addScreen(begin_conv)

supplies_1 = ConvoScreen:new {
  id = "supplies_1",
  customDialogText = "",
  stopConversation = "false",
  options = {

  }
}
smugglervendor_conv:addScreen(supplies_1)

get_tools_1 = ConvoScreen:new {
  id = "get_tools_1",
  customDialogText = "ya, fine whatever. 3000 credits, or beat it! And make sure you got room for 10 tools, too.",
  stopConversation = "false",
  options = {
    {"Great, its a deal","accept_tools"},
    {"Woa, thats a bit steep. Maybe not.","decline_tools"}
  }
}
smugglervendor_conv:addScreen(get_tools_1)

nsf_tools = ConvoScreen:new {
  id = "nsf_tools",
  customDialogText = "This ain't no charity kid! You pay or else!",
  stopConversation = "true",
  options = {}
}
smugglervendor_conv:addScreen(nsf_tools)

full_inv = ConvoScreen:new {
  id = "full_inv",
  customDialogText = "You're carrying around too much junk, stop wastin my time!",
  stopConversation = "true",
  options = {}
}
smugglervendor_conv:addScreen(full_inv)

accept_tools = ConvoScreen:new {
  id = "accept_tools",
  customDialogText = "Alright then. Here you go.",
  stopConversation = "true",
  options = {}
}
smugglervendor_conv:addScreen(accept_tools)

decline_tools = ConvoScreen:new {
  id = "decline_tools",
  customDialogText = "Thats what I thought, get outta here!",
  stopConversation = "true",
  options = {}
}
smugglervendor_conv:addScreen(decline_tools)


addConversationTemplate("smugglervendor_conv", smugglervendor_conv);
