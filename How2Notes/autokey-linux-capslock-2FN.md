# Autokey
```
$ cat ~/.xprofile
setxkbmap -option caps:hyper       # autokey
```
modifyer keys in autokey : https://en.wikipedia.org/wiki/Super_key_(keyboard_button)#Linux_and_BSD
- [Meta] /[Super]  ?? same    # check confictions needed
- {Hyper}                                   ##?? HYPER will trigger super??                     ## like shift (vim/emacs/win like edit FN key)
- Shift                                      # modify key similar with FN for A-Z           
- Alt        - 菜单GUI快捷选项  #  MENU - check confictions needed              ## alter
- Crontrol   - 常见GUI热键  #  SYS  - check confictions needed


## left hand
```
Hyper+Escape -->  <Capslock>
Hyper+A/E  -->  <Home>/<End>
Hyper+Q/Z  -->  <PgUp>/<PgDn>
```
- CONFILIC KEYS
```
*Super+E     -->  *<escape>
ctrl+s
ctrl+w
super+e
super+f
super+t
```
## right hand
```
- Small Jump -->  <alt>+<left> ; 
- Big Jump -->  <ctrl>+<left>;

*{SELECT} --> <shift>+{JUMP}
```

 - {-I-} key special defind:
 ```
<capslock> + <i> = {copy}
<capslock> + <\> = {paste}
<hyper>+<shift>+<i> = {cut}
<hyper>+<ctl>+<i> = {cut-TillEndOfLine}
#<shift>+<i>= <charI>
#<alt>+<i>  = menu-I
*super+i
```


{YU<i>OP|[ ] \}
--------------------------------
```
[CapsLock+X] : jump/remap  
<Home>   <up>  {-I-}  <down><End> | {LeftBrace}{RightBrace}  <escape>

[Hyper+Shift+X] : select
<Home>   <up>  {-I-}  <down><End> |  #(null <{><}><\>)

[Alt+X] : remap 
 menu-YUIOP | {PgUp}{PgDn}
 ```

 {HJKL | : " <Enter>}
-----------------------------
```
[CapsLock+X]  : jump by char/word (NOT vim)
{WordLeft}<left> <right>{WordRight} | <"!"> <"="> ;  {NewLine}

[Hyper+Shift+X] :  select
{WordLeft}<left> <right>{WordRight} | #(null <:><">; <shiftEnter>)

[Alt+X] : remap # 全角符号(rime默认半角符号)
menu-HJKL  |  {"chinese逗号"}{"chinese句号"};  <escape>
```
{NM<>/}
--------------------------------
```
[CapsLock+X] : del
{del-WordLeft}<backsapce>| <delete>{del-WordRight}  {"-"}

#(null) [Hyper+Shift+X] : select
charN,charM |#(null {<} {>}   <?>)

Alt - remap
menu-N,menu-M | {LeftBrace}{RightBrace}  {"_"}
```
