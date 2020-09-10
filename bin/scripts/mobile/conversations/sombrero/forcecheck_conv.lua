forcecheck_conv = ConvoTemplate:new {
  initialScreen = "begin_conv",
  templateType = "Lua",
  luaClassHandler = "forcecheck_conv_handler",
  screens = {}
}

begin_conv = ConvoScreen:new {
  id = "begin_conv",
  customDialogText = "How can I help you traveler?",
  stopConversation = "false",
  options = {
      {"I have questions about the Force", "force_question_1"}
  }
}
forcecheck_conv:addScreen(begin_conv)

force_question_1 = ConvoScreen:new {
  id = "force_question_1",
  customDialogText = "I'd be happy to assist you. What would you like to know?",
  stopConversation = "false",
  options = {
    {"Do Jedi still exist?","jedi_exist"},
    {"Do you know where the Jedi council is at?","wheres_council"}
  }
}
forcecheck_conv:addScreen(force_question_1)

jedi_exist = ConvoScreen:new {
  id = "jedi_exist",
  customDialogText = "I've heard that they might still exist, and just be in hiding. But I haven't seen one in ages.",
  stopConversation = "true",
  options = {}
}
forcecheck_conv:addScreen(jedi_exist)

wheres_council = ConvoScreen:new {
  id = "wheres_council",
  customDialogText = "If I knew, do you really think I would tell you? Or that they would tell me? Ha... you on the spice or something kid?",
  stopConversation = "true",
  options = {}
}
forcecheck_conv:addScreen(wheres_council)

force_aware_1 = ConvoScreen:new {
  id = "force_aware_1",
  customDialogText = "Careful! Don't say that too loud. There are those who think Jedi should not exist. Look, if you head down this path, you will be hunted. That is if they even decide you can be trained.....",
  stopConversation = "false",
  options = {
    {"Yes, I understand. Where are they?","force_aware_2"},
    {"On second thought, I'll think this over a bit","force_aware_3"}
  }
}
forcecheck_conv:addScreen(force_aware_1)

force_aware_2 = ConvoScreen:new {
  id = "force_aware_2",
  customDialogText = "Ok, don't say I didn't warn you.... I've updated your datapad with a waypoint.",
  stopConversation = "true",
  options = {}
}
forcecheck_conv:addScreen(force_aware_2)

force_aware_3 = ConvoScreen:new {
  id = "force_aware_3",
  customDialogText = "Well, ask me again any time. Not like I've got anywhere to be....",
  stopConversation = "true",
  options = {}
}
forcecheck_conv:addScreen(force_aware_3)

addConversationTemplate("forcecheck_conv", forcecheck_conv);
