# 2026-11-16 上游同步

## SukiSU Nova

上游仓库已改名为 [SukiSU Nova](https://github.com/SukiSU-Nova/SukiSU-Nova)。builtin 从 `6076949f26bf51325bd5e4e790b699c6f2a6acb5` 更新到 `4bec532dd447e2852aa8932afa768255350c103a`，包括 SELinux 规则变量修复、旧内核编译条件调整和 Nova 版本号。4.19 兼容补丁保留已适配的 CPU spoof 字段及 KPM 的配置保护。完整配置仍关闭 KPM。

[Nova v3.0.0](https://github.com/SukiSU-Nova/SukiSU-Nova/releases/tag/v3.0.0) 的源码提交为 `c60f21b9e00e35e898f8d21e0612465b76b9beec`，官方 APK 为 `SukiSU_Nova_v3.0.0_30000-release.apk`。最近一次成功的主线 [Build Manager 43712713571](https://github.com/SukiSU-Nova/SukiSU-Nova/actions/runs/43712713571) 使用 `ffb4837561e5a9d723b77199b130adf864da1b9d`。日志记录 3999 个主线提交，计算值为 `41184`，重签名输出是 `SukiSU_v4.3.0-r2_41184-release.apk`。[Release 比 Action 多两个提交](https://github.com/SukiSU-Nova/SukiSU-Nova/compare/ffb4837561e5a9d723b77199b130adf864da1b9d...v3.0.0)，包含 Nova 改名和 SUSFS 路径 UID 过滤的 Manager 与 ksud 支持。本次驱动 pin 和兼容补丁默认值均取 Release 的 `30000`。

[上一交付的 41176 到 Nova v3.0.0](https://github.com/SukiSU-Nova/SukiSU-Nova/compare/3af6085d0d26e73ffd1a3e7b34362435dcfb5a03...v3.0.0) 共 10 个提交，修复了非 GKI 内核的首页支持与内置模式，并更新了模块信息界面。本次提供普通官方 APK，包名为 `com.sukisu.nova`，下载文件的 SHA-256 与上游一致，为 `1f2b7a62d80a9dd0fca2eb5534611cb053d836b8479647b6f71d8d3ad5cc0049`。

## Clang 和其他构建输入

AOSP Linux Clang 从构建 `16713961` 升到 `16836431`，两者都标为 Clang 23.0.1、`r614150`。新归档取自 [AOSP main-kernel 提交 `dc706f7`](https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/dc706f7fe714bc3cd89f7e42c025a161581ad6be/clang-r614150/)。Clang 和 LLD 的二进制均有变化，所以按构建号安装到独立目录，本地预检和自定义构建入口也核对该构建号。

LineageOS `lineage-24.0` 的上游分支仍指向 `078365e5318de0a30a41f9707070b610bcd20f13`，AnyKernel3 的 HEAD 为 `41f04bdb4ee30a44e429c2c1131d5e8bb32b15f1`。SM8250 参考分支未变。[Android NDK](https://developer.android.com/ndk/downloads/) 最新正式包仍为 r30（`30.0.16248370`）。

SUSFS 的 [`gki-android14-6.1` 分支](https://gitlab.com/simonpunk/susfs4ksu/-/tree/gki-android14-6.1) 从 `69b8e734920b8f9ed885ab8d112969719698e242` 前进五个提交，到 `f76b81f2a6bf98e4029cc0c823c054edbec29803`。新路径 UID 过滤需要配套的内核调用点和 builtin 命令处理。现有 4.19 移植与新版 builtin 缺少这些入口，直接替换 pin 会让用户态工具和内核失配。本次保留已移植的 SUSFS v2.4.0 提交。

## 本地验证

Clang 归档 SHA-256 为 `b488c87a39b42c4d50c79a6d44969599f35a03d17c161a3073ea08b0ab240838`。`clang-23`、`lld`、`llvm-ar` 和 `llvm-nm` 的 Git 对象哈希与固定 AOSP 提交一致。WSL 预检通过，并验证了同为 `r614150` 的旧构建 `16713961` 会被拒绝。

本地构建、配置和发布工具共 28 项测试通过。Manager 包名与签名检查逻辑、扩展 ABI 和挂载文件分类器的宿主测试也通过。

WSL 构建 `local-full-20261116-161412` 使用 builder `ea90d19fce97c5874fa51f9fad11aaee4626b7a3`，完成单一 `extended-full + SELinux hide` Image 的编译、审计、打包和导出校验。导出的配置启用了 SUSFS、priority UID filter 和 4.19 SELinux hide，KPM 关闭。

Image SHA-256 为 `10547b870310e0f8e703a908438ee9294454fb375e85b369dc3a92d1f44ea57d`，安装 ZIP SHA-256 为 `7aaf8dd70b31263078058d095201168c8773cd0fa8b84e6797e8382593e280f2`。维护者确认 15 项真机检查全部通过，本地验收后发布 [v2026.11.16-ksu30000](https://github.com/Chinohana/SukiSU-Nova-for-OnePlus-8T-kebab/releases/tag/v2026.11.16-ksu30000)。
