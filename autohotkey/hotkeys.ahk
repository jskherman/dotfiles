; Custom Windows Modifier shortcuts
#o:: Run(EnvGet("LOCALAPPDATA") "\Programs\Obsidian\Obsidian.exe")          ; Obsidian
#c:: Run(EnvGet("LOCALAPPDATA") "\Programs\Microsoft VS Code\Code.exe")     ; VS Code
#t:: Run("wt.exe")                                                          ; Windows Terminal
#+d:: Run(EnvGet("USERPROFILE") "\Downloads")                               ; Open Downloads folder
#+e:: Run(EnvGet("PROGRAMFILES") "\Everything\Everything.exe")              ; Everything Search
#+g:: Run("https://github.com")                                             ; GitHub
#+h:: Run(EnvGet("JSKHOME"))                                                ; Open Windows Explorer to "Home"
#+p:: Run(EnvGet("USERPROFILE") "\Pictures\Screenshots")                    ; Open Screenshots folder
#+t:: Run(EnvGet("APPDATA") "\Telegram Desktop\Telegram.exe")               ; Telegram

;=====================================================================|
; Remap Insert key as a modifier key                                  |
;=====================================================================|

; ; Remap Insert as the Hyper key: Ctrl + Alt + Shift + Win
; ~Ins:: {
;     Send "{Ctrl DownTemp}{Shift DownTemp}{Alt DownTemp}{LWin DownTemp}"
;     KeyWait "Ins"
;     Send "{Ctrl Up}{Shift Up}{Alt Up}{LWin Up}"
; }

; Remap Insert Key to middle click (mouse)
Ins::MButton

; Remap Function keys to have access to F13-F24
Ins & F1::F13
Ins & F2::F14
Ins & F3::F15
Ins & F4::F16
Ins & F5::F17
Ins & F6::F18
Ins & F7::F19
Ins & F8::F20
Ins & F9::F21
Ins & F10::F22
Ins & F11::F23
Ins & F12::F24

; Insert + m to toggle random mouse movement
global movingmouse := false
Ins & m:: ToggleMouseMove()

ToggleMouseMove() {
    CoordMode "Mouse", "Screen"

    global movingmouse := !movingmouse
    delay := 1000

    RandomMouseMove() {
        Sleep(Random(500, 4000))

        x := Random(10, A_ScreenWidth // 2)
        y := Random(10, A_ScreenHeight // 2)
        spd := Random(50, 100)
        MouseMove x, y, spd
    }

    SetTimer(RandomMouseMove, (movingmouse ? delay : 0))
}

;=====================================================================|
