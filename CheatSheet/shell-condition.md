
###
https://www.cnblogs.com/weijiangbao/p/7862278.html
```
#shell判断文件夹是否存在
 
#如果文件夹不存在，创建文件夹
if [ ! -d "/Top" ]; then
 mkdir -p /Topfi
 
#shell判断文件,目录是否存在或者具有权限
 
folder="/Top"
file="/Top/test.txt"
 
# -x 参数判断 $folder 是否存在并且是否具有可执行权限
if [ ! -x "$folder"]; then
 mkdir "$folder"
fi
 
# -d 参数判断 $folder 是否存在
if [ ! -d "$folder"]; then
 mkdir "$folder"
fi
 
# -f 参数判断 $file 是否存在
if [ ! -f "$file" ]; then
 touch "$file"
fi

# -n 判断一个"变量"是否有值
if [ ! -n "$file" ]; then
 echo "$file 变量为空！"
 exit 0
fi
 
# 判断两个变量的字符串内容是否相同
if [ "$file1" = "$file2" ]; then
 echo "$file1 equal $file2"
else
 echo "$file1 not equal $file2"
fi
```


```
#!/bin/sh
# 说明：判断文件是否存在

 
myPath="/Top"
myFile="/Top/access.log"

# 这里的-x 参数判断$myPath是否存在并且是否具有可执行权限
if [ ! -x "$myPath"]; then
 mkdir "$myPath"
fi
# 这里的-d 参数判断$myPath是否存在
if [ ! -d "$myPath"]; then
 mkdir "$myPath"
fi
 
# 这里的-f参数判断$myFile是否存在
if [ ! -f "$myFile" ]; then
 touch "$myFile"
fi


# 其他参数还有-n,-n是判断一个变量是否是否有值
if [ ! -n "$myVar" ]; then
 echo "$myVar 变量为空！"
 exit 0
fi
 
# 判断$file字符串内容是否是“123123”相同
if [ "$file1" = "123123" ]; then
 echo "$file1 equal $file2"
else
 echo "$file1 not equal $file2"
fi
```

