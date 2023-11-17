# nlplay
Media player used on Raspberry Pi（在树莓派上使用的多媒体播放器）

---

[支持硬件](#支持硬件)  
[支持系统](#支持系统)  
[支持内容](#支持内容)  
[目录结构](#目录结构)  
[安装方法](#安装方法)  
[播放控制](#播放控制)  
[常见问题](#常见问题)  
[许可信息](#许可信息)  

---
### 支持硬件

| 硬件 | 系统 | 测试 |
| --- | --- | --- |
| Raspberry Pi Zero | Raspberry Pi OS with desktop | 未测试 |
| Raspberry Pi Zero 2 | Raspberry Pi OS with desktop | 未测试 |
| Raspberry Pi 2 Model B | Raspberry Pi OS with desktop | 未测试 |
| Raspberry Pi 3 Model B+ | Raspberry Pi OS with desktop | 已测试 |
| Raspberry Pi 4 Model B | Raspberry Pi OS with desktop (64-bit) | 已测试 |
| Raspberry Pi 5 | Raspberry Pi OS with desktop (64-bit) | 未测试 |

***理论上支持所有树莓派，但是经过测试的树莓派只有上面几款***

---
### 支持系统

| 系统版本 | 发布日期 | 测试版本 | 测试状态 |
| --- | --- | --- | --- |
| Raspberry Pi OS with desktop          | 2023-10-10 | - | 已测试 |
| Raspberry Pi OS with desktop (64-bit) | 2023-10-10 | - | 已测试 |

---
### 支持内容

| 类型 | 格式 | 
| --- | --- | 
| 视频 | MP4（H264） | 
| 图片 | JPG/PNG | 

---
### 目录结构

```
/usr/bin/nlplayrun                启动脚本(可配置启动参数)
/usr/bin/nlplay                   主程序
/etc/nlplay/simsun.ttc            默认字体文件
/etc/nlplay/nlplay.pid            运行时进程ID
/etc/ld.so.conf.d/00-nlplay.conf  关联库文件指向
/usr/local/lib/...                关联库文件目录
```

---
### 安装方法

 > 注意：请您在(root)用户下进行安装, 安装完成后请重启您的树莓派后再运行 ...  
 
 ```
 git clone https://github.com/nulijiabei/nlplay.git # (最新版本)
 git clone https://gitee.com/nljb/nlplay.git # (最新版本)
 ```

---
### 播放控制

 | 参数 | 默认 | 说明 |
 | --- | --- | --- |
 | -R | 0,0,1920,1080 | 分辨率设置 |
 | -fps | 24 | 帧率设置 |
 | -turbo | 未开启 | 高性能模式（开启时多线程解码） |
 | -mute | 未开启 | 静音设置 |
 | -cpuid | 无 | CPUID |
 | -welcome | 未设置 | 自定义欢迎页 |
 | -version | 无 | 版本号 |
 | -playobj | 未设置 | 素材路径 |
 | -playloop | 未开启 | 循环播放 |

 ```
 nlplay -version # 查看版本
 nlplay -cpuid # 查看 CPUID
 nlplay -playobj /root/hi.png # 播放图片
 nlplay -playobj /root/yiyezi.mp4 # 播放视频
 nlplay -playloop -playobj /root/yiyezi.mp4 # 播放视频（循环）
 nlplay -playobj "/root/a.jpg,/root/b.mp4" # 轮播素材（图片 and 视频）
 nlplay -mute -playloop -playobj /root/yiyezi.mp4 # 播放视频（静音 and 循环）
 nlplay -playloop -playobj "/root/a.jpg,/root/b.mp4" # 轮播素材（图片 and 视频 and 循环）
 nlplay -mute -turbo -playloop -playobj /root/yiyezi.mp4 # 播放视频（静音 and 高性能 and 循环）
 ```

 | 参数 | 键 | 值 | 默认 | 说明 |
 | --- | --- | --- | --- | --- |
 | -playctl | ori | landscape/portrait | landscape | 横向/纵向（orientation） | 
 | ↑ | rot | 0/180（landscape）、90/270（portrait） | 0 | 旋转（rotate） | 
 | ↑ | dur | 秒 | 5 | 持续（duration） | 
 
 ```
 nlplay -playctl "ori=landscape,rot=180" -playobj /root/yiyezi.mp4 # 播放视频（横向 and 旋转180°）
 nlplay -playctl "ori=portrait,rot=270" -playobj /root/yiyezi.mp4 # 播放视频（纵向 and 旋转270°）
 nlplay -playctl "dur=10" -playloop -playobj "/root/a.png,/root/b.mp4" # 轮播素材（图片持续10秒）
 ```

---
### 常见问题

 ***1. 显存设置***

 > 安装脚本默认已经为您设置了显存, 安装完成后请重启您的树莓派
 
 | 文件 | 设置 | 说明 |
 | --- | --- | --- |
 | /boot/config.txt | gpu_mem=256 (显存内存分配不能少于192M) | 重启生效 |
 
 > 说明：经测试在720P视频轮播时显存不低于192M, 1080P视频不低于256M ...
 
 ***2. 音频设置***

 > 配置文件（/etc/asound.conf）指定音频输出模式  
 
 ```
 // 0:3.5MM | 1:HDMI
 defaults.pcm.card 0 
 defaults.pcm.device 0
 defaults.ctl.card 0
 ```
 
---
### 许可信息

> Qt 使用 LGPL 许可 https://www.qt.io/licensing/ 和 https://www.qt.io/features#js-6-3  
> 通过LGPLv3许可证选项，您可以使用基本库和Qt的某些附加库。  
> 只要满足LGPLv3的所有要求，LGPLv3即可保持您的应用程序源代码关闭。  
> 该程序所涉及 Qt Core 满足 LGPL 要求  

> SDL 与 SDL_ttf 使用许可 https://www.zlib.net/zlib_license.html  
> 授予任何人出于任何目的使用此软件的权限，包括商业应用，并对其进行更改和重新分发  

> FFmpeg 使用 GNU较小通用公共许可证(LGPL) 许可 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html  
> FFmpeg License and Legal Considerations http://ffmpeg.org/legal.html  

> FFmpeg 在 Windows 系统许可 https://ffmpeg.zeranoe.com/builds/  
> FFmpeg is the leading multimedia framework to decode, encode, transcode, mux, demux, stream, filter and play. All builds require at least Windows 7 or Mac OS X 10.10. Nightly git builds are licensed as GPL 3.0, and release build are licensed as GPL 3.0 and LGPL 3.0. LGPL 3.0 release builds can be found using the "All Builds" links.  

---
