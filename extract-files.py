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
    # FIXME
    'device/samsung/e3q',
    'hardware/samsung',
    'kernel/samsung/sm8650',
    'kernel/samsung/sm8650-modules',
    'hardware/qcom-caf/sm8650',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/commonsys-intf/display',
    'hardware/qcom-caf/sm8650/data-ipa-cfg-mgr',
    'vendor/qcom/opensource/dataservices',
    'hardware/qcom-caf/wlan',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libsecril-client'
    ): lib_fixup_vendor_suffix,
    (
        'libagmclient',
        'libpalclient',
        'libwpa_client',
    ): lib_fixup_remove,
}


blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/libskeymint_cli.so': blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    'vendor/etc/seccomp_policy/atfwd@2.0.policy': blob_fixup()
        .add_line_if_missing('gettid: 1'),
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
