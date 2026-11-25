# 2026-11-25 上游同步

## LineageOS

`lineage-24.0` 从 `078365e5318de0a30a41f9707070b610bcd20f13` 更新到 `ffa797a9c07ca73d07f11849f0522747f3185b4d`，共 22 个提交。更新修复了 HID、KGSL、F2FS 和 USB 等问题，接入了 SN-NCI 驱动，也改动了 CFI 配置和 Clang 构建参数。[上游差异](https://github.com/LineageOS/android_kernel_oneplus_sm8250/compare/078365e5318de0a30a41f9707070b610bcd20f13...ffa797a9c07ca73d07f11849f0522747f3185b4d)

## Nova builtin 和 Manager

Nova 的上游源改用 Forgejo。固定的 `builtin` 从 `4bec532dd447e2852aa8932afa768255350c103a` 更新到 `adf6e86d55229ad78a5f7758bdc43d92fd1c3729`。内核目录的变化集中在 Makefile 的版本逻辑和 `kernel/setup.sh` 的执行位。4.19 兼容补丁在编译时读取固定版本号。[Forgejo builtin](https://git.zako.shirkneko.top:20004/shirkneko/SukiSU/src/commit/adf6e86d55229ad78a5f7758bdc43d92fd1c3729)

最新正式版 `v3.0.0-r1` 来自 `39feda0cf136951f8908cbc39e42b0128b4468db`。构建 368 记录 4,062 个主线提交，版本号为 35058，产出 `SukiSU_Nova_v3.0.0-r1_35058-arm64-v8a-release.apk`。最新成功的主线构建 473 来自 `54d6da4e7e792a7d0e70c4f5ec70f1ac1c32fa2b`，记录 4,099 个主线提交，产出 `SukiSU_Nova_v3.0.0-r1_35095-arm64-v8a-release.apk`。[正式版构建](https://git.zako.shirkneko.top:20004/shirkneko/SukiSU/actions/runs/368) · [主线构建](https://git.zako.shirkneko.top:20004/shirkneko/SukiSU/actions/runs/473) · [主线附件](https://cnb.cool/shirkneko/sukisu-release/-/releases/tag/manager-ci)

35058 到 35095 的 37 个提交包含 Manager 修复。root shell 调用移出界面线程，刷写界面增加重复进入保护，主题商店返回时保留滚动位置。因此驱动使用 35095。相比上次交付的 30000，Manager 还新增了动态壁纸和顶部栏样式，本次提供官方 arm64 APK。下载文件 SHA-256 为 `d30ff3269b794a5e23e979649db443fd4f3995cb738b2f6c10758c25d35586f6`。[Manager 源码差异](https://git.zako.shirkneko.top:20004/shirkneko/SukiSU/compare/39feda0cf136951f8908cbc39e42b0128b4468db...54d6da4e7e792a7d0e70c4f5ec70f1ac1c32fa2b) · [正式版说明](https://git.zako.shirkneko.top:20004/shirkneko/SukiSU/releases/tag/v3.0.0-r1)

## 其他依赖

SUSFS 上游 `gki-android14-6.1` 仍在 `f76b81f2a6bf98e4029cc0c823c054edbec29803`。现有 4.19 移植继续使用 `69b8e734920b8f9ed885ab8d112969719698e242`。6.1 分支的路径 UID 过滤涉及内核与用户态 ABI，两端需要配套移植。AnyKernel3、KernelPatch 源码和 SM8250 参考分支均与现有 pins 一致。

AOSP Linux x86-64 的 `main-kernel` 与 `main-kernel-2027` 分支的 Clang 目录树均为 `9258d4689a902416d188527e1f3592033f5bc8d5`，与已锁定的 `r614150` 构建 `16836431` 相同。Android NDK 正式版仍为 r30（`30.0.16248370`）。[AOSP Clang](https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/74fa19d51840dca566fdf0bc1291e75599718082/clang-r614150/) · [Android NDK 下载](https://developer.android.com/ndk/downloads/)
