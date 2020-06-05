INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = acBatteries

acBatteries_FILES = Tweak.x
acBatteries_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
