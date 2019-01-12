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
Quick
```
Quick start

>>> from pyftpdlib.authorizers import DummyAuthorizer
>>> from pyftpdlib.handlers import FTPHandler
>>> from pyftpdlib.servers import FTPServer
>>>
>>> authorizer = DummyAuthorizer()
>>> authorizer.add_user("user", "12345", "/home/giampaolo", perm="elradfmwMT")
>>> authorizer.add_anonymous("/home/nobody")
>>>
>>> handler = FTPHandler
>>> handler.authorizer = authorizer
>>>
>>> server = FTPServer(("127.0.0.1", 21), handler)
>>> server.serve_forever()
[I 13-02-19 10:55:42] >>> starting FTP server on 127.0.0.1:21 <<<
[I 13-02-19 10:55:42] poller: <class 'pyftpdlib.ioloop.Epoll'>
[I 13-02-19 10:55:42] masquerade (NAT) address: None
[I 13-02-19 10:55:42] passive ports: None
[I 13-02-19 10:55:42] use sendfile(2): True
[I 13-02-19 10:55:45] 127.0.0.1:34178-[] FTP session opened (connect)
[I 13-02-19 10:55:48] 127.0.0.1:34178-[user] USER 'user' logged in.
[I 13-02-19 10:56:27] 127.0.0.1:34179-[user] RETR /home/giampaolo/.vimrc completed=1 bytes=1700 seconds=0.001
[I 13-02-19 10:56:39] 127.0.0.1:34179-[user] FTP session closed (disconnect).
```



## Go FileBrowser
## GO fzf
