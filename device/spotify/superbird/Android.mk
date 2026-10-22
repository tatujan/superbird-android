# Copyright (C) 2026 The PlayThing Authors
# SPDX-License-Identifier: GPL-3.0-or-later
LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),superbird)

# Mali r16p0 userspace driver. Arm's license does not allow it in this repository or in the
# image: the build has a placeholder of the same size (scripts/aosp-prepare.sh), and
# scripts/flash.py writes the real file into the image (scripts/blobs.py).
include $(CLEAR_VARS)
LOCAL_MODULE := libGLES_mali
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := egl
LOCAL_MULTILIB := 32
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_PREBUILT_MODULE_FILE := vendor/plaything/mali/libGLES_mali.so
include $(BUILD_PREBUILT)

# Droid-ify, the app store (docs/apps.md), with its developer's signature. As DiPlay below:
# a placeholder in the image, and scripts/flash.py writes the release APK into it
# (scripts/blobs.py). No dexpreopt (Android verifies it at the first start). Its native
# libraries are stored uncompressed, so Android uses them from the APK.
include $(CLEAR_VARS)
LOCAL_MODULE := Droidify
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MULTILIB := 32
LOCAL_DEX_PREOPT := false
LOCAL_REPLACE_PREBUILT_APK_INSTALLED := vendor/plaything/droidify/Droidify.apk
include $(BUILD_PREBUILT)

# The keyboard, the App manager, and ThingPod. Make does not look below a folder that has its
# own Android.mk, so include them here. Each sets LOCAL_PATH to its own folder, so keep ours.
SUPERBIRD_DEVICE_DIR := $(LOCAL_PATH)
include $(SUPERBIRD_DEVICE_DIR)/apps/CptKeyboard/Android.mk
include $(SUPERBIRD_DEVICE_DIR)/apps/CptManager/Android.mk
include $(SUPERBIRD_DEVICE_DIR)/apps/ThingPod/Android.mk

endif
