ARCHS = arm64
TARGET = iphone:clang:11.2:10.0

DEBUG = 0
FINALPACKAGE = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UniversalBlurModifier
UniversalBlurModifier_FILES = Tweak.xm
UniversalBlurModifier_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += universalblurmodifierprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
