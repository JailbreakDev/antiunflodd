ARCHS = armv7 arm64

include theos/makefiles/common.mk

TOOL_NAME = antiunflodd
antiunflodd_FILES = main.mm
antiunflodd_INSTALL_PATH = /usr/libexec

include $(THEOS_MAKE_PATH)/tool.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/LaunchDaemons/$(ECHO_END)
	$(ECHO_NOTHING)cp com.sharedroutine.antiunflodd.plist $(THEOS_STAGING_DIR)/Library/LaunchDaemons/com.sharedroutine.antiunflodd.plist$(ECHO_END)

after-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/DEBIAN/$(ECHO_END)
	$(ECHO_NOTHING)cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postinst$(ECHO_END)
	$(ECHO_NOTHING)cp preinst $(THEOS_STAGING_DIR)/DEBIAN/preinst$(ECHO_END)
SUBPROJECTS += antiunflod
include $(THEOS_MAKE_PATH)/aggregate.mk
