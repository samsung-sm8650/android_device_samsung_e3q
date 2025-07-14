#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/sm8550-common',
    'hardware/qcom-caf/sm8550',
    'vendor/qcom/opensource/commonsys-intf/display',
    'vendor/samsung/sm8550-common',
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libsecril-client',
        'vendor.qti.hardware.fm@1.0',
    ): lib_fixup_vendor_suffix,
}

module = ExtractUtilsModule(
    'dm3q',
    'samsung',
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(module, 'sm8550-common', module.vendor)
    utils.run()
