安裝MinGW，添加系統路徑

- 添加 bin目錄
- 添加 c-include-path
- 添加 library-path

**使用菜单[工具]-[编译系统] 內置C++编译（Ctrl+B）选项可编译C/CPP，但不支持交互输入**

**编译单个文件，并在CMD执行才能交互输入**


新建C编译系统
C-build-run-inCMD.sublime-build
```
{

"working_dir": "$file_path",

"cmd": "gcc -Wall \"$file_name\" -o \"$file_base_name\"",

"file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",

"selector": "source.c",

"variants":

[

{

"name": "Run",

         "shell_cmd": "gcc -Wall \"$file\" -o \"$file_base_name\" && start cmd /c \"${file_path}/${file_base_name} & pause\""

}

]

}
```

新建C++编译系统
CPP-build-run-inCMD.sublime-build
```
{

"encoding": "utf-8",

"working_dir": "$file_path",

"shell_cmd": "g++ -Wall -std=c++11 \"$file_name\" -o \"$file_base_name\"",

"file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",

"selector": "source.c++",

"variants":

[

{

"name": "Run",

         "shell_cmd": "g++ -Wall -std=c++11 \"$file\" -o \"$file_base_name\" && start cmd /c \"${file_path}/${file_base_name} & pause\""

}

]

}
```
