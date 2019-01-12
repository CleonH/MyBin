## python  HTTP Server

python2 -m SimpleHTTPServer 1234
python3 -m http.server 1234

## Tmp FTP server

- twistd -n ftp
- python -m pyftpdlib



A Basic libftpserver.py
```
import os

from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

def main():
    # Instantiate a dummy authorizer for managing 'virtual' users
    authorizer = DummyAuthorizer()

    # Define a new user having full r/w permissions and a read-only
    # anonymous user
    authorizer.add_user('user', '12345', '.', perm='elradfmwMT')
    authorizer.add_anonymous(os.getcwd())

    # Instantiate FTP handler class
    handler = FTPHandler
    handler.authorizer = authorizer

    # Define a customized banner (string returned when client connects)
    handler.banner = "pyftpdlib based ftpd ready."

    # Specify a masquerade address and the range of ports to use for
    # passive connections.  Decomment in case you're behind a NAT.
    #handler.masquerade_address = '151.25.42.11'
    #handler.passive_ports = range(60000, 65535)

    # Instantiate FTP server class and listen on 0.0.0.0:2121
    address = ('', 2121)
    server = FTPServer(address, handler)

    # set a limit for connections
    server.max_cons = 256
    server.max_cons_per_ip = 5

    # start ftp server
    server.serve_forever()

if __name__ == '__main__':
    main()
```

Quick ref: https://www.cnblogs.com/huangxm/p/6274645.html

```
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

#实例化虚拟用户，这是FTP验证首要条件
authorizer = DummyAuthorizer()

#添加用户权限和路径，括号内的参数是(用户名， 密码， 用户目录， 权限)
authorizer.add_user('user', '12345', '/home/', perm='elradfmw')

#添加匿名用户 只需要路径
authorizer.add_anonymous('/home/huangxm')

#初始化ftp句柄
handler = FTPHandler
handler.authorizer = authorizer

#监听ip 和 端口,因为linux里非root用户无法使用21端口，所以我使用了2121端口
server = FTPServer(('192.168.0.108', 2121), handler)

#开始服务
server.serve_forever()

```
```



## Go FileBrowser

## bash
zsh - ohmyzsh - autojump git 
fzf
ranger
tmux


## Text content search 
- sublime
- ag(vim, emacs)


## duplicated file 
ddff
AllDup
...



