## Hardware & Extention
- intel-power-gadget
- MacFanControl
- HDMI/USBC Display (ARM m1 chip support ONLY ONE extra display)
- Keyboard https://karabiner-elements.pqrs.org/
```
(CapsLock Again!) https://github.com/Vonng/Capslock/
```
## Data! Data! Data! (duplication & recovery)

 - Alias rm & trash-cli
 ```
 alias rm='echo "This is not the command you are looking for."; false'
 mac-trash-cli https://github.com/gxvv/trash-cli (linux: https://github.com/andreafrancia/trash-cli)
 ```
  - Carbon Copy Cloner  (/TimeMachine)
 ```
 bootable; full disk; OS full backup
 ```
 - APFS SnapShot / ExtraStorage  (/TimeMachine)
 ```
 ??? apfs_mount ?? $tmutil listlocalsnapshotdates ??
 ```
 ```
 rsync 
 restic [dedup!!] https://restic.readthedocs.io/en/stable/040_backup.html
 ```
 - NAS (/TimeMachine)
 ```
 syncthing
 seafile..etc
 ```
- FreeWebStorage
```
iCloud/Dropbox/OneDrive...etc
```

## MACOS Kernel
- **Update, Lastest Security Upgrade**
### File System
- **NTFS?** TuxeraNTFS
- HFS+/APFS
```
https://www.v2ex.com/t/659647
https://www.macworld.com/article/3600278/macos-big-sur-supports-time-machine-on-apfs-formatted-drives-but-there-are-a-few-catches.html

macOS Big Sur supports Time Machine on APFS-formatted drives, but there are a few catches
While APFS has advantages for SSD-based storage, there really aren’t any for hard disk drives, the most likely kind of drive used for large-capacity backup drives. I would set up any new Time Machine volume formatted with APFS, but not convert an old one from HFS+.

MacOS(HighSierra,APFS) --> TimeMachine(HFS)
MacOS(BigSur,APFS) --> TimeMachine(APFS)
```

## clean
- AppDelete https://support.apple.com/zh-cn/HT202235
- system/users library clean

 
## Perference
- DNS (nextdns/DoH/DoT...)
- ProxyToggle
```
XBar https://github.com/matryer/xbar-plugins
# networksetup -setwebproxy "Wi-Fi" 192.168.1.110 7777
```
- PinyinInput (RIME,MS_doublePinyin) 
- TouchPad Dragging (Sys-Accessibility-M&T-TrackPadOption-enableDragging)
- Spotlight (exclude ~/Downloads ...etc)
- Dictionary/Eudict (ExtraDicts/Sound)
- Keyboard Mapping
- Go2Shell

## Menu Utility
- MusicBar / Owly
- NetSpeed,CPU etc
- Spectacle/Shifit
- Alfred (emptyTrash->Empty.App,EnterConfirm) / HammerSpoon
- Xbar 

## VMWare/Docker
- Vmware Fusion (NTFS r/o)
- Oracle Virtualbox / DockerTool
- Docker
 
## Brew/MacPort/Fink
- [screen] (tmux - gist: Install tmux on OSX WITHOUT brew)
- ncdu
- curl
- git/miniconda/python3



## DevTool
- SSH Tunnel Port Forward
```
SSH-PROXY.APP  
ssh -D 1025 -C -N -q -f user@server
```
- Marko(github style preview)
- VSCODE
- JRE/JDK (Low Memory)
- Hex Editor
- VSCODE
- subl (include in $PATH)

## Text/Document
- Markdown(?autosave) typora (Text Editor App Auto-Save Feature is enable by default in MacOS)
- Tex
- zetora
- libreOffice
 
## MATH
- Spyder/Anaconda
- Rstudio
- Julia
- Matlab Alt
 
## others
```
Cryptomator(DropBox/OneDrive/NutStore...差异化同步算法)
GrandPerspective
VLC
ffmpeg: HandBrak/Freac
ImageConvertor/ImageOptim
GIMP
Firefox/Chrome/Edge
ariaGui/you-get/music-dl
Trash_EMPTY.APP
```


