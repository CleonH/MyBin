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


## left hand - emacs like Home/End
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
## right hand - vim like Up/Down
```
- Small Jump -->  <alt>+<left> ; 
- Big Jump -->  <ctrl>+<left>;

*{SELECT} --> <shift>+{JUMP}
```

 - {-I-\-enter-} keys special defind:{copy/paste}{cut/<insert>} <escape> {cut-tillLineEnd} {newline}
 ```
<capslock> + <i> = {copy}                               <capslock> + < \ >  = {cut-tillend}
<hyper>+<alt>+<i>    = <escape>                          *   <alt> + < \ >  = <escape>
<hyper>+<shift>+<i>  = <insert>                         <capslock> + <enter> = {newline}
<hyper>+<ctl>+<i>    = {cut}                               #<alt>  + <enter> = <escape>
<casplock> + <v> = {paste}                                 #<shift>+ <enter> = {shift+insert}
                                                           #<ctrl> + <enter> = {newline}
#<shift>+<i>= <charI>
#<alt>+<i>  = menu-I         # <capslock>+<B>={prefix/escape}
*super+i  {*undefind}        # <capslock>+<Z-M>={undefind}  ## <capslock>+<v>={paste}

```

{YU<i>OP|[ ] \}  :  FN
--------------------------------
```
[CapsLock+X] (+SHIFT<Esc><Caps><Inst> <(><)> | select-home/end)
 {paste} {cut}   {-i-} {PageDown} {PageUp}   |   [home][end]   , *{\defind\back\slash}
[Alt+X] : remap 
 menu-YUIOP                                  |  {"("号}{")"号}  , *{\defind\back\slash}
 ```

 {HJKL | : " <Enter>} : jump
---------------------------------
```
[CapsLock+X] (+SHIFT   select-WL-up-down-WR|-charL-charR)
{WordLeft} <up> <down> {WordRight}         | <left> <right>    ; *{defind_Enter}
[Alt+X] : remap # 全角符号(rime默认半角符号)
menu-HJKL                                  |  {"!"号}{"="号}    ; *{defind_Enter}
```

{NM | <>/} : del (+shift)
--------------------------------
``` 
[CapsLock+X]   (+SHIFT  {del-Home}{del-END} | {!undo}{!!redo}     .  {"+"})
{del-WordLeft}{del-WordRight}               | <backsapce> <delete>.  {"-"}
[Alt+X] - remap
menu-N,menu-M                               | {"逗号"}{"句号"}     .  {"_"}
```
