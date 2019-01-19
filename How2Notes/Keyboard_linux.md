-  driver

keyboard type config; touchpad dirver ; etc


- $ xfwm4-setting  (openbox-setting)
```
minimize
close
...
```

- $ xfce4-keyboard-settings 
```
xfce4-terminal                         |  (Super+T)
xfce4-terminal --drop-down             |  (Super+R)
(open folder) thunar /home/user/folder |  (....)
...
```

- Autokey-gtk  - keyboard.send_key("<key>") 

```
- install autokey  (autokey-setting ~/.config/autokey)
- echo "setxkbmap -option caps:hyper" >> ~/.xinitrc
- config - remap <CapsLock>  :  "keyb oard.send_key("<capslock>")"    
- config - sample
 https://github.com/Chester-zZz/linux-capslock
 https://github.com/Vonng/Capslock

```

- Libinput - TouchPad Gestures

[https://github.com/madslundt/keybindings]

Disable Touchpad
```
#!/bin/bash
if xinput list-props 12 | grep "Device Enabled (146):.*1" >/dev/null
then
  xinput disable 12
  notify-send -u low -i mouse "Trackpad disabled"
else
  xinput enable 12
  notify-send -u low -i mouse "Trackpad enabled"
```


- others
```
- keyboard remap ~/.Xmodmap   
- *switch caps and ctrl*
- xfce-superkey  - https://github.com/JixunMoe/xfce-superkey
- *https://github.com/alols/xcape*
- https://github.com/hexvalid/Linux-CapsLock-Delay-Fixer
- double caps -- add sudo 
```

### **Application specified shortcuts**
- Chrome/Firefox Vimuim
- MSVS-Code/Sublime VimMode
- Emacs/SpaceEmacs ChaosMode