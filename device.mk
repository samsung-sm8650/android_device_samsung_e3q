#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# API levels
PRODUCT_SHIPPING_API_LEVEL := 34

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl:64 \
    android.hardware.audio.effect@7.0-impl:64 \
    android.hardware.audio.service \
    android.hardware.soundtrigger@2.3-impl:64 \
    vendor.qti.hardware.AGMIPC@1.0-service

PRODUCT_PACKAGES += \
    audio.bluetooth.default:64 \
    audio.r_submix.default:64 \
    audio.usb.default:64 \

PRODUCT_PACKAGES += \
    audioadsprpcd

PRODUCT_PACKAGES += \
    libagm_compress_plugin:64 \
    libagm_mixer_plugin:64 \
    libagm_pcm_plugin:64 \
    libagmclient:64 \
    libagmmixer:64 \
    libbatterylistener:64 \
    libfmpal:64 \
    libpalclient:64 \
    libqcompostprocbundle:64 \
    libqcomvisualizer:64 \
    libqcomvoiceprocessing:64 \
    libsndcardparser:64 \
    libvolumelistener:64

# Authsecret
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0.vendor

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0.vendor \
    android.hardware.bluetooth@1.1.vendor \

# ConfigStore
PRODUCT_PACKAGES += \
    vendor.qti.hardware.capabilityconfigstore@1.0.vendor

# Codec2
PRODUCT_PACKAGES += \
    android.hardware.media.bufferpool@2.0.vendor \
    android.hardware.media.c2@1.0.vendor \
    android.hardware.media.c2@1.2.vendor \
    libavservices_minijail.vendor \
    libavservices_minijail\
    libpalclient \
    libcodec2_hidl@1.0.vendor \
    libcodec2_vndk.vendor \
    libstagefright_bufferpool@2.0.1.vendor \
    android.hardware.media.bufferpool2-V1-ndk \
    libcodec2_hidl@1.2.vendor \
    libstagefright_softomx_plugin.vendor \
    libsfplugin_ccodec_utils.vendor \
    libcodec2_soft_common.vendor


# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Camera
PRODUCT_PACKAGES += \
    android.frameworks.cameraservice.common@2.0.vendor \
    android.frameworks.cameraservice.device@2.0.vendor \
    android.frameworks.cameraservice.service@2.2.vendor \
    android.hardware.camera.provider@2.4-impl \
    android.frameworks.cameraservice.service-V1-ndk.vendor \
    libsensorndkbridge

# Display
PRODUCT_PACKAGES += \
    init.qti.display_boot.rc \
    init.qti.display_boot.sh \
    libqdMetaData \
    libqdMetaData.system \
    libui_shim.vendor \
    libui.vendor \
    vendor.qti.hardware.display.config-V1-ndk.vendor \
    vendor.qti.hardware.display.config-V2-ndk.vendor \
    vendor.qti.hardware.display.config-V3-ndk.vendor \
    vendor.qti.hardware.display.config-V4-ndk.vendor \
    vendor.qti.hardware.display.config-V5-ndk \
    vendor.qti.hardware.display.config-V5-ndk.vendor \
    vendor.qti.hardware.display.config-V6-ndk.vendor \
    vendor.qti.hardware.display.config-V7-ndk.vendor \
    vendor.qti.hardware.display.config-V8-ndk.vendor \
    vendor.qti.hardware.display.config-V9-ndk.vendor \
    vendor.qti.hardware.display.config-V10-ndk.vendor \
    vendor.qti.hardware.display.demura-service \
    vendor.qti.hardware.display.demura-V1-ndk \
    vendor.qti.hardware.display.composer-service.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Graphics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_3.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2023-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2023-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper-V1-ndk.vendor \
    android.hardware.gatekeeper@1.0.vendor \
    libgatekeeper.vendor \

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@1.0.vendor \
    android.hardware.health@2.0.vendor \
    android.hardware.health@2.1.vendor \
    android.hardware.health-service.samsung \
    android.hardware.health-service.samsung-recovery

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor \
    android.hidl.allocator@1.0.vendor \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    android.hidl.memory@1.0.vendor \
    android.hidl.memory.block@1.0.vendor

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1.vendor

# # Keymint
# PRODUCT_PACKAGES += \
#     android.hardware.security.keymint-V1-ndk.vendor \
#     android.hardware.security.keymint-V2-ndk.vendor \
#     android.hardware.security.keymint-V3-ndk.vendor \
#     android.hardware.security.rkp-V3-ndk.vendor \
#     android.hardware.security.secureclock-V1-ndk.vendor \
#     android.hardware.security.sharedsecret-V1-ndk.vendor \
#     android.hardware.security.sharedsecret-V2-ndk.vendor \

# Net
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1.vendor

# Weaver
PRODUCT_PACKAGES += \
    android.hardware.weaver@1.0.vendor \
    android.hardware.weaver@1.0 \
    android.hardware.weaver-V2-ndk.vendor

# Thermal
PRODUCT_PACKAGES += \
    android.frameworks.cameraservice.service@2.2.vendor \
    android.hardware.thermal@2.0 \
    android.hardware.thermal@2.0.vendor \
    android.hardware.thermal-V1-ndk \
    android.hardware.thermal-V1-ndk.vendor

# QMI
PRODUCT_PACKAGES += \
    libcurl.vendor \
    libjson \
    libjsoncpp.vendor \
    libqti_vndfwk_detect.vendor \
    libqti_vndfwk_detect_vendor \
    libsqlite.vendor \
    libvndfwk_detect_jni.qti.vendor \
    libvndfwk_detect_jni.qti_vendor

# RIL
PRODUCT_PACKAGES += \
    android.hardware.radio@1.6.vendor \
    android.hardware.radio.config-V2-ndk.vendor \
    android.hardware.radio-V2-ndk.vendor \
    android.hardware.radio.config-V2-ndk.vendor \
    android.hardware.radio.data-V2-ndk.vendor \
    android.hardware.radio.messaging-V2-ndk.vendor \
    android.hardware.radio.modem-V2-ndk.vendor \
    android.hardware.radio.network-V2-ndk.vendor \
    android.hardware.radio.sap-V1-ndk.vendor \
    android.hardware.radio.sim-V2-ndk.vendor \
    android.hardware.radio.voice-V2-ndk.vendor \
    librmnetctl \
    libprotobuf-cpp-full \
    libprotobuf-cpp-lite-3.9.1-vendorcompat \
    secril_config_svc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    hardware/interfaces/security/keymint/aidl/default/android.hardware.hardware_keystore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hardware_keystore.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.strongbox_keystore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.strongbox_keystore.xml

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# OMX
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0.vendor \
    libOmxCore \
    libmm-omxcore \
    libstagefrighthw

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := phone

# Rootdir
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.class_main.sh \
    init.e3q.rc \
    init.mdm.sh \
    init.qcom.rc \
    init.qcom.sh \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    init.qti.kernel.rc \
    init.recovery.qcom.rc \
    init.samsung.bsp.rc \
    init.samsung.display.rc \
    init.samsung.dp.rc \
    init.samsung.power.rc \
    init.samsung.rc \
    init.target.rc \
    ueventd-odm.rc \
    ueventd.qcom.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# Memtrack
PRODUCT_PACKAGES += \
    vendor.qti.hardware.memtrack-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-3.9.1-vendorcompat \
    libprotobuf-cpp-full \
    libprotobuf-cpp-lite \
    libprotobuf-cpp-lite-3.9.1-vendorcompat \

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/samsung \
    kernel/samsung/sm8650 \
    kernel/samsung/sm8650-modules

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Trusted User Interface
PRODUCT_PACKAGES += \
    android.hidl.memory.block@1.0.vendor \
    vendor.qti.hardware.systemhelper@1.0.vendor

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb-V1-ndk.vendor

PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/usb/etc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# VNDK
PRODUCT_PACKAGES += \
    libcrypto-v33

PRODUCT_PACKAGES += \
    libnetutils.vendor \
    libstagefright_xmlparser.vendor \
    libnl.vendor \
    android.hardware.gnss-V3-ndk.vendor \
    android.hardware.biometrics.fingerprint-V3-ndk.vendor \
    android.hardware.secure_element@1.2 \
    android.hardware.secure_element@1.2.vendor \
    libsqlite.vendor \
    FrameworksResTarget

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    android.hardware.wifi.supplicant-V1-ndk.vendor \
    android.hardware.wifi.supplicant-V2-ndk.vendor \
    android.hardware.wifi-V1-ndk.vendor \
    android.hardware.wifi.hostapd-V1-ndk.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# WiFi Display
PRODUCT_PACKAGES += \
    android.media.audio.common.types-V2-cpp \
    libnl \
    libpng.vendor \
    libwfdaac_vendor

# Inherit the proprietary files
$(call inherit-product, vendor/samsung/e3q/e3q-vendor.mk)
