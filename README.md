# SukiSU Nova for OnePlus 8T

为 OnePlus 8T（kebab）的 LineageOS 24.0 构建 Linux 4.19 内核，集成 SukiSU Nova、SUSFS 和 SELinux hide。

[下载正式版本](https://github.com/Chinohana/SukiSU-Nova-for-OnePlus-8T-kebab/releases/latest) · [本地构建](docs/LOCAL-BUILD.md) · [自定义构建](docs/CUSTOM-BUILD.md) · [文档目录](docs/README.md)

## 设备与版本

| 项目 | 版本 |
| --- | --- |
| 设备 | OnePlus 8T，代号 kebab；已测试 KB2000 |
| 系统 | LineageOS 24.0，Android 17 |
| 内核 | LineageOS 4.19 |
| 源码固定版本 | SukiSU Nova builtin，驱动版本 35095，SUSFS v2.4.0 |
| 编译器 | Android Clang r614150，构建 16836431 |
| 当前正式版 | [v2026.11.25-ksu35095-kpm](https://github.com/Chinohana/SukiSU-Nova-for-OnePlus-8T-kebab/releases/tag/v2026.11.25-ksu35095-kpm) |

2026 年 11 月 16 日的 Nova 30000 发行版通过本地构建和 15 项真机检查。构建输入和产物哈希见[上游同步记录](docs/UPSTREAMS-20261116.md)。该发行版关闭 KPM。

35095 完整版通过本地构建和 16 项真机检查，包括 KPM 模块加载和卸载。源码与 Manager 版本见[2026-11-25 上游同步记录](docs/UPSTREAMS-20261125.md)。

## KPM

项目正式支持 KPM。维护者的本地完整构建默认启用 KPM，使用固定版本的 SukiSU KernelPatch 和 Arm GNU 15.3.Rel2 构建加载器。安装包名称带有 `KPM`。

SukiSU 41176 KPM 内核已在 KB2000 上验证。hello 模块连续 25 次加载、查询和卸载，AWDL 探针连续 25 次挂接和撤除 WLAN 回调。基于 KPM 的 AirDrop 模块也完成了与 iPhone 的双向文件传输。Nova 30000 KPM 版本已通过维护者确认的 16 项真机检查，包括 KPM 加载和卸载。

## 下载与安装

在 [Release 页面](https://github.com/Chinohana/SukiSU-Nova-for-OnePlus-8T-kebab/releases/latest)获取内核 ZIP、校验值和配套 Manager。用 PowerShell 计算 ZIP 的 SHA-256，与对应发布说明核对。

```powershell
Get-FileHash -Algorithm SHA256 -LiteralPath '.\下载的内核包.zip'
```

操作前解锁 Bootloader，备份 `boot_a` 和 `boot_b`，保存哈希，记录活动槽位及 Fastboot 恢复方法。

1. 确认设备、ROM 和安装包哈希，在支持 AnyKernel3 的 Recovery 中安装 ZIP。
2. 开机后检查 root、SELinux、SUSFS、网络、相机、指纹、音频和文件读写。
3. 出现启动故障时，通过 Fastboot 恢复原 boot 备份，并保留日志。

AnyKernel3 替换 boot 内的内核并保留 ramdisk。临时启动需要从当前 ROM 的原始 boot 制作包含目标 Image 的完整 `boot.img`。

## 功能配置

完整配置包括 SUS Path、SUS Mount、SUS Kstat、SUS Maps、Spoof Uname、Spoof Cmdline、Open Redirect、符号隐藏、SUSFS Logging、priority UID filter 和 SELinux hide。隐藏规则、UID 名单与 SELinux hide 运行时开关由使用者配置。

维护者在本地构建单个 `extended-full + SELinux hide` Image，按实际产物和真机记录验收。自定义配置可通过自己的 Fork 或克隆仓库使用手动工作流，具体入口见[本地构建说明](docs/LOCAL-BUILD.md)和[自定义构建说明](docs/CUSTOM-BUILD.md)。

## 已知问题

TA Enhanced v5.53.1 会停止 LineageOS 充电 HAL，导致软重启卡在启动阶段。移除模块中的停服务代码后，两次软重启通过。详见 [TA Enhanced #46](https://github.com/Enginex0/tricky-addon-enhanced/issues/46)。

## 上游项目

- [SukiSU Nova](https://github.com/SukiSU-Nova/SukiSU-Nova)
- [SukiSU KernelPatch](https://github.com/SukiSU-Ultra/SukiSU_KernelPatch_patch)
- [SUSFS4KSU](https://gitlab.com/simonpunk/susfs4ksu)
- [AnyKernel3](https://github.com/osm0sis/AnyKernel3)
- [LineageOS OnePlus SM8250 kernel](https://github.com/LineageOS/android_kernel_oneplus_sm8250)
