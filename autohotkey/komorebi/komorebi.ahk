; .shell pwsh
#Requires AutoHotkey v2.0.2
#SingleInstance Force

;=====================================================================|

global komorebi_keys_on := true

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}


#HotIf komorebi_keys_on
!q:: Komorebic("close")
!m:: Komorebic("minimize")

; Focus windows
!h:: Komorebic("focus left")
!j:: Komorebic("focus down")
!k:: Komorebic("focus up")
!l:: Komorebic("focus right")

!+[:: Komorebic("cycle-focus previous")
!+]:: Komorebic("cycle-focus next")

; Move windows
!+h:: Komorebic("move left")
!+j:: Komorebic("move down")
!+k:: Komorebic("move up")
!+l:: Komorebic("move right")

; Stack windows
!Left:: Komorebic("stack left")
!Down:: Komorebic("stack down")
!Up:: Komorebic("stack up")
!Right:: Komorebic("stack right")
!;:: Komorebic("unstack")
![:: Komorebic("cycle-stack previous")
!]:: Komorebic("cycle-stack next")

; Resize
!=:: Komorebic("resize-axis horizontal increase")
!-:: Komorebic("resize-axis horizontal decrease")
!+=:: Komorebic("resize-axis vertical increase")
!+_:: Komorebic("resize-axis vertical decrease")

; Manipulate windows
!t:: Komorebic("toggle-float")
!f:: Komorebic("toggle-monocle")

; Window manager options
!+r:: Komorebic("retile")

; Layouts
!x:: Komorebic("flip-layout horizontal")
!y:: Komorebic("flip-layout vertical")

; Workspaces
!1:: Komorebic("focus-workspace 0")
!2:: Komorebic("focus-workspace 1")
!3:: Komorebic("focus-workspace 2")
!4:: Komorebic("focus-workspace 3")
!5:: Komorebic("focus-workspace 4")
!6:: Komorebic("focus-workspace 5")
!7:: Komorebic("focus-workspace 6")
!8:: Komorebic("focus-workspace 7")

; Move windows across workspaces
!+1:: Komorebic("move-to-workspace 0")
!+2:: Komorebic("move-to-workspace 1")
!+3:: Komorebic("move-to-workspace 2")
!+4:: Komorebic("move-to-workspace 3")
!+5:: Komorebic("move-to-workspace 4")
!+6:: Komorebic("move-to-workspace 5")
!+7:: Komorebic("move-to-workspace 6")
!+8:: Komorebic("move-to-workspace 7")

#HotIf

; Stop Komorebi
>!F4:: {
    Run('pwsh -Command "komorebic stop"', , "Hide")
    TrayTip("Komorebi stopped.", "Komorebi AHK", "Iconi")
    Sleep(2000)
    TrayTip
    ExitApp
}

>!p:: {
    global komorebi_keys_on
    komorebi_keys_on := !komorebi_keys_on
    TrayTip("Komorebi keys are now " (komorebi_keys_on ? "enabled" : "disabled"), "Komorebi AHK", "Iconi")
    Sleep(2000)
    TrayTip
    Komorebic("toggle-pause")   ; Toggle pause of Komorebi
}

; Komorebi Hotkey Cheatsheet
>!+/:: {
    cheatsheet := "
(
    ┌───────────────┐                                           ┌───────────────┐
    │ Basic Actions │                                           │ Focus Windows │
    └───────────────┘                                           └───────────────┘

RAlt + F4 — Close Komorebi                                  RAlt + H — Focus Left
RAlt +  Q — Close Window                                    RAlt + J — Focus Down
RAlt +  M — Minimize Window                                 RAlt + K — Focus Up
                                                                RAlt + L — Focus Right
                                                        RAlt + Shift + [ — Cycle Focus Previous
                                                        RAlt + Shift + ] — Cycle Focus Next

    ┌──────────────┐                                            ┌───────────────┐
    │ Move Windows │                                            │ Stack Windows │
    └──────────────┘                                            └───────────────┘

RAlt + Shift + H — Move Left                            RAlt + Left  — Stack Left
RAlt + Shift + J — Move Down                            RAlt + Down  — Stack Down
RAlt + Shift + K — Move Up                              RAlt + Up    — Stack Up
RAlt + Shift + L — Move Right                           RAlt + Right — Stack Right
                                                                RAlt + ; — Unstack
                                                                RAlt + [ — Cycle Stack Previous
                                                                RAlt + ] — Cycle Stack Next

    ┌────────┐                                                ┌────────────────────┐
    │ Resize │                                                │ Manipulate Windows │
    └────────┘                                                └────────────────────┘

RAlt + = — Increase Horizontal Size                         RAlt + T — Toggle Float
RAlt + - — Decrease Horizontal Size                         RAlt + F — Toggle Monocle
RAlt + Shift + = — Increase Vertical Size
RAlt + Shift + - — Decrease Vertical Size

┌────────────────────────┐                                    ┌─────────┐
│ Window Manager Options │                                    │ Layouts │
└────────────────────────┘                                    └─────────┘

RAlt + Shift + R — Retile                                   RAlt + X — Flip Layout Horizontal
            RAlt + P — Toggle Pause                             RAlt + Y — Flip Layout Vertical

┌────────────┐
│ Workspaces │
└────────────┘

RAlt + 1-8 — Focus Workspace 1-8
RAlt + Shift + 1-8 — Move to Workspace 1-8
)"

    ShowCheatsheet() {
        main := Gui(, "Komorebi Cheatsheet")
        main.SetFont("s9", "Cascadia Mono")
        main.AddText("w1000 h750 x+10 y+10", cheatsheet)

        main.Show("w1020 h770")
    }

    ShowCheatsheet()
}