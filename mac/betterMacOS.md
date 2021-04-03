## Hardware
- intel-power-gadget/MacFanControl
- TFCardExtraStorage (Data Recovery)
 ```
 working files real time backup[dedup!!] https://restic.readthedocs.io/en/stable/040_backup.html
 ?? APFS / BTRFS 
 ```
- Sleep & Power & Owly

## MACOS Kernel
- **Updates**
- filesystem & DataRecovery (Data Recovery/Deduplication)
- TimeMachine (NAS/HDDisk/TFcard...etc)
- 
### File System
- **NTFS?** TuxeraNTFS
- HFS+/APFS
```
APPLE-FS-MACOS-TimeMachine
https://www.v2ex.com/t/659647
https://www.macworld.com/article/3600278/macos-big-sur-supports-time-machine-on-apfs-formatted-drives-but-there-are-a-few-catches.html

macOS Big Sur supports Time Machine on APFS-formatted drives, but there are a few catches
While APFS has advantages for SSD-based storage, there really aren’t any for hard disk drives, the most likely kind of drive used for large-capacity backup drives. I would set up any new Time Machine volume formatted with APFS, but not convert an old one from HFS+.

Conlusion:
MacOS(HighSierra,APFS) --> TM(HFS)
MacOS(BigSur,APFS) --> TM(APFS)
TimeMachine 固态移动硬盘更适合APFS； ??? NAS-TimeMachine ?? ZFS ?? Btrfs??

系统卷(快照) 备份工具  ChronoSync/CCC ??? 快照更适合OS级别,软件测试
工作文件夹云盘备份(Cryptomator+WebSync)
工作文件夹本地备份(rsync\syncthing) Launchd(systemd)

如果要删除所有本地快照的话：
for d in $(tmutil listlocalsnapshotdates | grep "-"); do sudo tmutil deletelocalsnapshots $d; done
```

## AppStore
- AppDelete
- system / users library clean
- SFTP/Rsync Client
- iHash
 
## Perference
- DNS (nextdns/DoH/DoT...)
- ProxyToggle
```
XBar https://github.com/matryer/xbar-plugins
# networksetup -setwebproxy "Wi-Fi" 192.168.10.110 7777
```
- input (RIME,MS_doublePinyin) 
- TouchPad (Sys-Accessibility-M&T-TrackPadOption-enableDragging)
- Spotlight (exclude ~/Downloads ...etc)
- Dictionary/Eudict (ExtraDicts/Sound)
- Keyboard Mapping
- Go2Shell

## Menu Utility
- Xbar / MusicBar / Owly
- NetSpeed,CPU etc
- Spectacle/Shifit
- Alfred (emptyTrash->Empty.App,EnterConfirm)
- HammerSpoon http://www.hammerspoon.org/go/

## VMWare/Docker
- Vmware Fusion (NTFS r/o)
- Oracle Virtualbox / DockerTool
- Docker
 
## Brew/MacPort/Fink
- tmux without brew (gist: Install tmux on OSX WITHOUT brew)
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


