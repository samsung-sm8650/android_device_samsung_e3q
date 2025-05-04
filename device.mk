#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 3120
TARGET_SCREEN_WIDTH := 1440

# Init
PRODUCT_PACKAGES += \
    init.e3q.rc

# Overlays
PRODUCT_PACKAGES += \
    SystemUIResTarget

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Product characteristics
PRODUCT_CHARACTERISTICS := phone

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/samsung/sm8650-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/samsung/e3q/e3q-vendor.mk)
