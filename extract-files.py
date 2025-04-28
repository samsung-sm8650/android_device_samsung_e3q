#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    BlobFixupCtx,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/e3q',
    'hardware/qcom-caf/sm8650',
    'hardware/qcom-caf/wlan',
    'hardware/samsung',
    'vendor/qcom/opensource/commonsys-intf/display',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/dataservices',
    'vendor/qcom/opensource/display',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'vendor.qti.diaghal@1.0',
        'libsecril-client'
    ): lib_fixup_vendor_suffix,
    (
        'libagmclient',
        'libpalclient',
        'libwpa_client'
    ): lib_fixup_remove,
}


blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/libskeymint_cli.so': blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    #'vendor/etc/seccomp_policy/atfwd@2.0.policy': blob_fixup()
    #    .add_line_if_missing('gettid: 1'),
    'vendor/lib64/libsec-ril.so': blob_fixup()
        .binary_regex_replace(b'ril.dds.call.ongoing', b'vendor.calls.slot_id')
        # mov x3, x21 -> mov x3, #0
        .sig_replace('bf c2 00 f8 76 0e 40 f9 80 0e 40 f9 e1 03 16 aa 82 0c 80 52 e3 03 15 aa 24 00 80 52 08 00 40 f9', 'bf c2 00 f8 76 0e 40 f9 80 0e 40 f9 e1 03 16 aa 82 0c 80 52 03 00 80 d2 24 00 80 52 08 00 40 f9'),
    'vendor/lib64/libqcodec2_core.so': blob_fixup()
        .add_needed('libcodec2_shim.so'),
    ('vendor/lib64/unihal_android.so', 'vendor/lib64/libc2filterplugin.so'): blob_fixup()
        .add_needed('libui_shim.so'),
    'vendor/etc/vintf/manifest/sec_c2_manifest_default0_1_2.xml': blob_fixup()
        .regex_replace('default0', 'software'),
    ('vendor/etc/media_codecs.xml', 'vendor/etc/media_codecs_pineapple.xml', 'vendor/etc/media_codecs_pineapple_vendor.xml'): blob_fixup()
        .regex_replace('.*media_codecs_(google_audio|google_c2|google_telephony|google_video|vendor_audio).*\n', ''),
    ('vendor/lib64/libspukeymint.so', 'vendor/bin/hw/android.hardware.security.keymint-service-spu-qti'): blob_fixup()
        .replace_needed('android.hardware.security.sharedsecret-V2-ndk.so', 'android.hardware.security.sharedsecret-V1-ndk.so'),
    ('vendor/lib64/libsensorndkbridge.so', 'vendor/bin/hw/android.hardware.sensors-service.multihal'): blob_fixup()
        .replace_needed('android.hardware.sensors-V2-ndk.so', 'android.hardware.sensors-V3-ndk.so'),
    'vendor/etc/init/android.hardware.security.keymint-service-qti.rc': blob_fixup()
        .regex_replace('android.hardware.security.keymint-service', 'android.hardware.security.keymint-service-qti'),
}  # fmt: skip

module = ExtractUtilsModule(
    'e3q',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    check_elf=True
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
