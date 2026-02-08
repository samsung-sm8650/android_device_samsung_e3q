#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/samsung/e3q/device.mk)

# Inherit from the Lineage configuration.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_e3q
PRODUCT_DEVICE := e3q
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := SM-S928B
PRODUCT_MANUFACTURER := Samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung
