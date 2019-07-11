## install git-for-windows 
```
https://gitforwindows.org/
```
## add git to vscode [setting.json]
```
{

// Git Bash
"terminal.integrated.shell.windows": "C:\\Program Files (x86)\\Git\\usr\\bin\\bash.exe"

}
```

## set-up linux vm

```
#arch_vm-terminal
pacman -S openssh

#git-bash 
ssh-keygen
ssh-copy-id 
```

## config remote machine
```
#C:\User\someone\.ssh\config

# Read more about SSH config files: https://linux.die.net/man/5/ssh_config
Host archVM_local
    HostName 192.168.56.101
    User chh

Host raspbian_arm         ##(arm_architecher Insider Version Only)
    HostName 192.168.31.126
    User pi

```

## debug

```
#C/C++
pacman -S gcc
#python
ptvsd 

```
