test_conv = ConvoTemplate:new {
  initialScreen = "screen_one",
  templateType = "Lua",
  luaClassHandler = "test_conv_handler",
  screens = {}
}

screen_one = ConvoScreen:new {
  id = "screen_one",
  customDialogText = "hi there",
  stopConversation = "false",
  options = {
      {"Opt 1", "s1_opt1"}
  }
}
test_conv:addScreen(screen_one)

s1_opt1 = ConvoScreen:new {
  id = "s1_opt1",
  customDialogText = "This is screen 2?",
  stopConversation = "true",
  options = {}
}
test_conv:addScreen(s1_opt1)

addConversationTemplate("test_conv", test_conv);
print("-----------------------test_conv loaded2")
