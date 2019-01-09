;;;; Samples of  Support more than 2 combine key （备注： Shift, Control, Fn, Alt 没有输出，仅是辅助键）
;;
;;#If GetKeyState("[") && GetKeyState("]")
;; \::MsgBox ItWorks,you pressed "[" & "]" & "\
;;return
;;
;;#If GetKeyState("Capslock")
;;+\::MsgBox It Works, You Pressed Caps+Shift+\
;;;Send ^+{Left}
;;;Send {Del}
;;Return

;;Mouse Scroll simulation
Capslock & Up::Wheelup
Capslock & Down::WheelDown
Capslock & Left::WheelLeft
Capslock & Right::WheelRight
Capslock & q::WheelUp
Capslock & z::WheelDown






;;;; Emacs & VIM Like Editing Shortcut

Capslock & a::Home
Capslock & e::End

;;DEL till end
Capslock & k::
Send +{End}
Send {Del}
Return


;; Left Hand Navigation
Capslock & b::Left
Capslock & f::Right
Capslock & w::Up
Capslock & s::Down

;; Right Hand Nav and Delete function
Capslock & u::Up
Capslock & m::Down 
Capslock & ,::Backspace
Capslock & .::Del


;;;; Jump And Delete ---by WORDS---
Capslock & j::^Left     ;;Caps+J = Caps+【
Capslock & l::^Right	;;Caps+L = Caps+】

;;Caps+J = Caps+【
Capslock & [::
Send ^{Left}     ;; Send ^+{left} or Press Shift, if want to select
Return

;;Caps+L = Caps+】
Capslock & ]::
Send ^{Right}     ;; Send ^+{left} or Press Shift,if want to select
Return

;;;; select ---by WORDS---

;; same as windows build-in [Ctrl+Shift + Left]
Capslock & -::
Send ^+{Left}     ;; Send ^+{left} if want to select
;Send {Del}      ;; Send {del} if want to delete
Return

;; same as windows build-in [Ctrl+Shift + Right]
Capslock & =::
Send ^+{Right}       ;; Send ^+{right} if want ot select
;Send {Del}         ;; Send {del} if want to delete
Return





Capslock & h::
Send ^{Left}     ;; Send ^+{left} if want to select
Return

Capslock & g::
Send ^{Right}     ;; Send ^+{left} if want to select
Return



; 把Capslock替换为Control
CapsLock::^b


#IfWinActive mintty
CapsLock::^b
#IfWinActive

#IfWinActive babun
CapsLock::^b
#IfWinActive

#IfWinActive zsh
CapsLock::^b
#IfWinActive

#IfWinActive tmux
CapsLock::^b
#IfWinActive

#IfWinActive ConEmu
CapsLock::^b
#IfWinActive


#IfWinActive emacs  ;

#Control::Capslock ; 把Control替换为Capslock

Capslock::Control   ; 把Capslock替换为Control
#IfWinActive


