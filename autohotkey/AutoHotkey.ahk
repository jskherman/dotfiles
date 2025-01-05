#Requires AutoHotkey v2.0

; Settings =========================================================

GroupAdd "Snippets", "ahk_exe WindowsTerminal.exe"

; Includes =========================================================

#HotIf !WinActive("ahk_group Snippets")
#include "strings.ahk"
#include "markdown.ahk"
#include "tabletopics.ahk"
#HotIf

#include "hotkeys.ahk"
#include "datetimes.ahk"
#include "lorem_ipsum.ahk"
#include "python_scripts.ahk"

; Private includes
#include "private/personal_info.ahk"
#include "private/hp.ahk"
#include "private/logs.ahk"

; Complex scripts
; #include "scratchpad/mdsp.ahk"
