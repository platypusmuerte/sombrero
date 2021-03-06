/*
 				Copyright <SWGEmu>
		See file COPYING for copying conditions. */

#ifndef UPDATEVENDORTASK_H_
#define UPDATEVENDORTASK_H_

#include "engine/engine.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/tangible/components/vendor/VendorDataComponent.h"

namespace server {
namespace zone {
namespace objects {
namespace auction {
namespace events {

class UpdateVendorTask: public Task {
protected:
	ManagedWeakReference<SceneObject*> vendor;

public:
	UpdateVendorTask(SceneObject* vndr) {
		vendor = vndr;

		setCustomTaskQueue("slowQueue");
	}

	void run() {

		ManagedReference<SceneObject*> strongRef = vendor.get();

		if (strongRef == nullptr || strongRef->isBazaarTerminal())
			return;

		Locker locker(strongRef);

		DataObjectComponentReference* data = strongRef->getDataObjectComponent();
		if(data == nullptr || data->get() == nullptr || !data->get()->isVendorData()) {
			return;
		}

		VendorDataComponent* vendorData = cast<VendorDataComponent*>(data->get());
		if(vendorData == nullptr) {
			return;
		}

		setTaskName((strongRef->getLoggingName() + " ran UpdateVendorTask of owner 0x" + String::hexvalueOf(vendorData->getOwnerId())).toCharArray());

		vendorData->runVendorUpdate();
	}

};

}
}
}
}
}

using namespace server::zone::objects::auction::events;

#endif /* UPDATEVENDORTASK_H_ */
