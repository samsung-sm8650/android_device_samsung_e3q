#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true

DEVICE_PATH := device/samsung/e3q

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := pineapple
TARGET_NO_BOOTLOADER := true

# Boot
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_RAMDISK_USE_LZ4 := true

# Display
TARGET_SCREEN_DENSITY := 450
TARGET_USES_VULKAN := true

# DTB / DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_USES_QCOM_MERGE_DTBS_SCRIPT := true
TARGET_NEEDS_DTBOIMAGE := true

# Init Boot
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# Kernel
BOARD_BOOTCONFIG := \
    androidboot.selinux=permissive \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE := \
    video=vfb:640x400,bpp=32,memsize=3072000  \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image \
    loop.max_part=7
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
TARGET_KERNEL_SOURCE := kernel/samsung/sm8650
TARGET_KERNEL_CONFIG := \
    gki_defconfig \
    vendor/pineapple_GKI.config \
    vendor/e3q.config

# Kernel modules
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.system_dlkm))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery $(DEVICE_PATH)/modules.include.vendor_ramdisk))
SYSTEM_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.include.system_dlkm))

TARGET_KERNEL_EXT_MODULE_ROOT := kernel/samsung/sm8650-modules

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 110034944
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 14105444352
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    odm \
    product \
    system \
    system_dlkm \
    system_ext \
    vendor \
    vendor_dlkm
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 14101250048 # (BOARD_SUPER_PARTITION_SIZE - 4MiB)

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Platform
TARGET_BOARD_PLATFORM := pineapple

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2024-06-01

# Sepolicy
include device/qcom/sepolicy_vndr/SEPolicy.mk
include device/lineage/sepolicy/libperfmgr/sepolicy.mk

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/configs/vintf/compatibility_matrix.device.xml \
    $(DEVICE_PATH)/configs/vintf/compatibility_matrix.samsung.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/framework_manifest.xml
DEVICE_MATRIX_FILE := \
    $(DEVICE_PATH)/configs/vintf/compatibility_matrix.xml \
    hardware/qcom-caf/common/compatibility_matrix.xml
DEVICE_MANIFEST_SKUS := pineapple
DEVICE_MANIFEST_PINEAPPLE_FILES := \
    $(DEVICE_PATH)/configs/vintf/manifest_pineapple.xml \
    $(DEVICE_PATH)/configs/vintf/manifest_samsung.xml

# Inherit the proprietary files
include vendor/samsung/e3q/BoardConfigVendor.mk
