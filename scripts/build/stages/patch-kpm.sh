#!/usr/bin/env bash
set -euo pipefail

source_dir="$BUILD_TEMP/kernelpatch"
git init -q "$source_dir"
git -C "$source_dir" fetch --no-tags --depth=1 "$KERNELPATCH_REPOSITORY" "$KERNELPATCH_COMMIT"
git -C "$source_dir" checkout --detach FETCH_HEAD
test "$(git -C "$source_dir" rev-parse HEAD)" = "$KERNELPATCH_COMMIT"

sukisu_header=kernel_experiment/drivers/kernelsu/extension/kpm/bridge.h
kernelpatch_header="$source_dir/kernel/patch/sukisu/supercall.h"
for definition in SUKISU_KPM_ABI_VERSION SUKISU_KPM_SUPERCALL_MAGIC SUKISU_KPM_SUPERCALL_MAGIC2 SUKISU_KPM_SUPERCALL_MAGIC3; do
  grep -Fqx "$(grep -E "^#define $definition " "$sukisu_header")" "$kernelpatch_header"
done

export SOURCE_DATE_EPOCH="$(git -C "$source_dir" show -s --format=%ct HEAD)"
make -C "$source_dir/kernel" -j"$BUILD_JOBS" "TARGET_COMPILE=$KERNELPATCH_CROSS_PREFIX" kpimg
make -C "$source_dir/tools" -j"$BUILD_JOBS" CC=gcc kptools

image="kernel_experiment/$SELECTED_OUT/arch/arm64/boot/Image"
tools="$source_dir/tools/kptools"
payload="$source_dir/kernel/kpimg"
patched="$image.kpm"
grep -Eq '[[:space:]]__arm64_sys_truncate(\.cfi(_jt)?)?$' "kernel_experiment/$SELECTED_OUT/System.map"
sha256sum "$image" | awk '{print $1 "  unpatched-Image"}' > audit/kernelpatch.sha256
"$tools" --patch --image "$image" --kpimg "$payload" --out "$patched" | tee audit/kernelpatch.log
test -s "$patched"
if cmp -s "$image" "$patched"; then
  echo 'KernelPatch did not change Image' >&2
  exit 1
fi
"$tools" --list --image "$patched" >> audit/kernelpatch.log
sha256sum "$payload" "$tools" "$patched" | awk '{sub(".*/", "", $2); print $1 "  " $2}' >> audit/kernelpatch.sha256
mv "$patched" "$image"
