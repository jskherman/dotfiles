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

;=====================================================================|
global movingmouse := false
ToggleMouseMove() {
    CoordMode "Mouse", "Screen"         ; Set coordinates relative to the entire screen

    ; Static variables are only initialized once and retain their value between calls
    global movingmouse := !movingmouse  ; Toggle the state of movingmouse ON/OFF
    static delay := 1000                       ; One second delay for the timer that calls RandomMouseMove

    RandomMouseMove() {                 ; Define the function that moves the mouse randomly
        Sleep(Random(500, 4000))        ; Sleep for a random amount of time between 0.5 and 4 seconds

        x := Random(10, A_ScreenWidth // 2)     ; Random number of pixels to move the mouse horizontally
        y := Random(10, A_ScreenHeight // 2)    ; Random number of pixels to move the mouse vertically
        spd := Random(50, 100)                  ; Random speed to move the mouse
        MouseMove x, y, spd                     ; Move the mouse to the new position
    }

    SetTimer(RandomMouseMove, (movingmouse ? delay : 0))    ; Set the timer to call RandomMouseMove every second
}

; Insert + m to toggle random mouse movement
Ins & m:: ToggleMouseMove()


;=====================================================================|

; global komorebi_on := false

; ToggleKomorebi() {
;     global komorebi_on
;     komorebi_on := !komorebi_on

;     if komorebi_on {
;         RunWait('pwsh -Command "komorebic start --ahk"', , "Hide")
;         Persistent
;     } else {
;         RunWait('pwsh -Command "komorebic stop"', , "Hide")
;     }
; }

; Windows + Insert to launch Komorebi
Ins & k:: Run('pwsh -Command "komorebic start --ahk"', , "Hide")

;=====================================================================|
