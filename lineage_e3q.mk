#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from e3q device
$(call inherit-product, device/samsung/e3q/device.mk)

PRODUCT_DEVICE := e3q
PRODUCT_NAME := lineage_e3q
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-S928B
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="e3qxxx-user 15 AP3A.240905.015.A2 S928BXXU4BYD9 release-keys" \
    BuildFingerprint="samsung/e3qxxx/e3q:14/UP1A.231005.007/S928BXXU4BYD9:user/release-keys"
