#Requires AutoHotkey v1.1

#NoEnv
#Persistent
#SingleInstance, Force
SetFormat, IntegerFast, Hex
SetBatchLines, -1
SetWinDelay, -1

Global Cached_Windows := {}

Menu, Tray, NoStandard
Menu, Tray, Icon, C:\Windows\system32\shell32.dll, 3
Menu, Tray, Add, Exit, Exit
Menu, Tray, Icon, Exit, C:\Windows\system32\shell32.dll, 113

;---------------------- Functions ----------------------
MenuItemClick(WinID, WinTitle, ItemName, ItemPosition) {
  WinShow, ahk_id %WinID%
  Cached_Windows.Delete(WinID)
  Menu, Tray, Delete, %ItemPosition%&
}
;-------------------------------------------------------
Return


!F1::
WinGet, WinID, ID, A
WinGet, WinIcon, ProcessPath, ahk_id %WinID%
WinGetTitle, WinTitle, ahk_id %WinID%
WinGet, Style, Style, ahk_id %WinID%
if (Style & 0xC00000) { ; If active window has titlebar
  ObjRawSet(Cached_Windows, WinID, WinID)
  BoundGivePar := Func("MenuItemClick").Bind(WinID, WinTitle)
  if (StrLen(WinTitle) > 50) {
    WinTitle := SubStr(WinTitle, 1, 50) "..."
  }
  Menu, Tray, Insert, 1&, %WinTitle%, %BoundGivePar%
  Menu, Tray, Icon, %WinTitle%, %WinIcon%
  WinHide, ahk_id %WinID%
}
Return


Exit:
For index, WinID in Cached_Windows {
  WinShow, ahk_id %WinID%
}
ExitApp
Return