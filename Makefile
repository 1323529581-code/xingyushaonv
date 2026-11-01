TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StarLustsAuth
StarLustsAuth_FILES = AuthPlugin.m
StarLustsAuth_CFLAGS = -fobjc-arc
StarLustsAuth_FRAMEWORKS = UIKit Foundation AuthenticationServices SafariServices

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 StarLusts || killall -9 SpringBoard"
