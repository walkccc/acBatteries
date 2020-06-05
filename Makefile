INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 192.168.0.13

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = acBatteries

acBatteries_FILES = Tweak.xm
acBatteries_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
