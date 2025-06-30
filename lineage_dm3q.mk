#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/samsung/dm3q/device.mk)

# Inherit from the Lineage configuration.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_dm3q
PRODUCT_DEVICE := dm3q
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := SM-S918B
PRODUCT_MANUFACTURER := Samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="dm3qxxx-user 15 AP3A.240905.015.A2 S918BXXS8DYF2 release-keys" \
    BuildFingerprint=samsung/dm3qxxx/dm3q:15/AP3A.240905.015.A2/S918BXXS8DYF2:user/release-keys \
    DeviceProduct=dm3qxxx \
    SystemName=dm3qxxx
