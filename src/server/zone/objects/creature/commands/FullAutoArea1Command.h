/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FULLAUTOAREA1COMMAND_H_
#define FULLAUTOAREA1COMMAND_H_

#include "CombatQueueCommand.h"

class FullAutoArea1Command : public CombatQueueCommand {
public:

	FullAutoArea1Command(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		return doCombatAction(creature, target);
	}

};

#endif //FULLAUTOAREA1COMMAND_H_
