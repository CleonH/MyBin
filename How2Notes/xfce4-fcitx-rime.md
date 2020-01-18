sudo apt install fcitx fcitx-pinyin fcitx-rime librime-data-double-pinyin

nano ~/.config/fcitx/rime/default.custom.yaml

```
patch:
  schema_list:
#    - schema: luna_pinyin          # 朙月拼音
#    - schema: luna_pinyin_simp     # 朙月拼音 简化字模式
#    - schema: luna_pinyin_tw       # 朙月拼音 臺灣正體模式
    - schema: wubi_pinyin          # 五笔拼音混合輸入
    - schema: double_pinyin_mspy   # 微軟雙拼
    - schema: double_pinyin_flypy  # 小鶴雙拼
    - schema: emoji         # emoji表情
```
```
xfce4-start -> Perferences -> LanguageSupport ->
  Keyboard input method system [fcitx]
```
logout & login, test
---
