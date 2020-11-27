 # parametar 
 # ./yeelight_bn.sh $BRIGHTNESSS
 printf "{\"id\":1,\"method\":\"set_bright\",\"params\":[$1]}\r\n" | nc 192.168.1.199 55443
