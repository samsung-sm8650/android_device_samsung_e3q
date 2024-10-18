#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=e3q
VENDOR=samsung

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=false

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function vendor_imports() {
    cat <<EOF >>"$1"
		"device/samsung/e3q",
		"hardware/qcom-caf/sm8650",
		"hardware/qcom-caf/wlan",
		"hardware/samsung",
		"vendor/qcom/opensource/commonsys/display",
		"vendor/qcom/opensource/commonsys-intf/display",
		"vendor/qcom/opensource/dataservices",
EOF
}

function lib_to_package_fixup_vendor_variants() {
    if [ "$2" != "vendor" ]; then
        return 1
    fi

    case "$1" in
        com.qualcomm.qti.dpm.api@1.0 | \
            libQnnCpu | \
            libQnnHtp | \
            libQnnHtpPrepare | \
            libQnnHtpV73Stub | \
            libhwconfigurationutil | \
            vendor.oplus.hardware.cammidasservice-V1-ndk | \
            vendor.oplus.hardware.communicationcenter-V1-ndk | \
            vendor.oplus.hardware.performance-V1-ndk | \
            vendor.oplus.hardware.sendextcamcmd-V1-ndk | \
            vendor.oplus.hardware.stability.oplus_project-V1-ndk | \
            vendor.pixelworks.hardware.display@1.0 | \
            vendor.pixelworks.hardware.display@1.1 | \
            vendor.pixelworks.hardware.display@1.2 | \
            vendor.pixelworks.hardware.feature@1.0 | \
            vendor.pixelworks.hardware.feature@1.1 | \
            vendor.qti.diaghal@1.0 | \
            vendor.qti.hardware.dpmservice@1.0 | \
            vendor.qti.hardware.dpmservice@1.1 | \
            vendor.qti.hardware.qccsyshal@1.0 | \
            vendor.qti.hardware.qccsyshal@1.1 | \
            vendor.qti.hardware.qccsyshal@1.2 | \
            vendor.qti.hardware.qccvndhal@1.0 | \
            vendor.qti.hardware.wifidisplaysession@1.0 | \
            vendor.qti.imsrtpservice@3.0 | \
            vendor.qti.imsrtpservice@3.1)
            echo "$1_vendor"
            ;;
        libagmclient | \
            libpalclient | \
            libwpa_client | \
	    libar-pal | \
	    libhfp_pal) ;;
        *)
            return 1
            ;;
    esac
}

function lib_to_package_fixup() {
    lib_to_package_fixup_clang_rt_ubsan_standalone "$1" ||
        lib_to_package_fixup_proto_3_9_1 "$1" ||
        lib_to_package_fixup_odm_variants "$@" ||
        lib_to_package_fixup_vendor_variants "$@"
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt"

# Finish
write_footers
