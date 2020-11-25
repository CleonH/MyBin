# iOS shortcuts SSH command
yeelight_on
```shell
printf "{\"id\":1,\"method\":\"set_power\",\"params\":[\"on\",\"smooth\",500]}\r\n" | nc 192.168.1.199 55443
```

yeelith_off
```shell
printf "{\"id\":1,\"method\":\"set_power\",\"params\":[\"off\",\"smooth\",500]}\r\n" | nc 192.168.1.199 55443
```

setBrightness_min
```shell
printf "{\"id\":1,\"method\":\"set_bright\",\"params\":[1]}\r\n" | nc 192.168.1.199 55443
```

setBrightness_max
``` 
printf "{\"id\":1,\"method\":\"set_bright\",\"params\":[99]}\r\n" | nc 192.168.1.199 55443
```
