---
title: Arch Linux 显卡驱动相关
category: linux
tags: linux arch intel
---

## Intel核芯显卡 

```bash
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel
```

> 不建议安装 xf86-video-intel，而应使用 Xorg 的 modesetting 驱动（也就是什么都不用装的意思）
> 注意，只有 Intel HD 4000 及以上的核显才支持 vulkan。
