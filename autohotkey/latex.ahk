#Requires AutoHotkey v2.0

; Settings =========================================================

global latex_mode := true   ; Initialize LaTeX math mode flag variable

!F10:: {
    ; Use Alt+F10 to toggle LaTeX math mode on and off
    global latex_mode := !latex_mode
    MsgBox("LaTeX math mode is now " (latex_mode ? "ON" : "OFF"), "AHK Mode", "Iconi")
    return
}

#HotIf latex_mode

; Functions =========================================================

surround_text(left_delim, right_delim, backtrack) {
    ; Surround recently copied text with delimiters

    currently_selected := A_Clipboard             ; Save selected text to variable
    currently_selected := StrReplace("{Raw}" currently_selected, "`r")

    Send left_delim
    Send currently_selected
    Send right_delim
    Send "{Left " backtrack "}"
    return
}

; Visual Surround ==================================================
;
; Make sure to copy the text you want to surround with Ctrl+C
; before using these hotstrings

#Hotstring "*O"
::mk;:: {
    ; Surround with dollar signs, inlines math mode
    Send surround_text("$", "$", 1)
}
::dm;:: {
    ; Surround with double dollar signs, display math mode
    Send surround_text("$${Enter}", "{Enter}$$", 3)
}
::beg;:: {
    ; Surround with \begin{} and \end{} environment
    Send surround_text("\begin{{}{}}{Enter}", "{Enter}\end{{}{}}", 1)   
}

; Snippets =========================================================
#Hotstring "*0" "c"

; Greek letters ----------------------------------------------------
:c1:latex::\LaTeX
:c1:@a::\alpha
:c1:@b::\beta
:c1:@c::\chi
::@D::\Delta
::@d::\delta
::@E::\epsilon
::@e::\varepsilon
::@f::\phi
::@F::\Phi
::@G::\Gamma
::@g::\gamma
:c1:@h::\eta
::@i::\iota
::@j::\psi
::@J::\Psi
:c1:@k::\kappa
::@L::\Lambda
::@l::\lambda
:c1:@m::\mu
:c1:@n::\nu
::@O::\Omega
::@o::\omega
::@P::\Pi
::@p::\pi
::@q::\theta
::@Q::\Theta
:c1:@r::\rho
::@S::\Sigma
::@s::\sigma
:c1:@t::\tau
::@U::\Upsilon
::@u::\upsilon
::@v::\varphi
::@V::\varPhi
::@w::\omega
::@W::\Omega
::@X::\Xi
::@x::\xi
:c1:@z::\zeta

:c1:alpha::\alpha
:c1:beta::\beta
:c1:chi::\chi
::delta::\delta
::Delta::\Delta
::epsilon::\varepsilon
::phi::\phi
::Phi::\Phi
::Gamma::\Gamma
::gamma::\gamma
:c1:eta::\eta
::iota::\iota
::psi::\psi
::Psi::\Psi
:c1:kappa::\kappa
::Lambda::\Lambda
::lambda::\lambda
:c1:mu::\mu
:c1:nu::\nu
::Omega::\Omega
::omega::\omega
::Pi::\Pi
::pi::\pi
::theta::\theta
::Theta::\Theta
:c1:rho::\rho
::Sigma::\Sigma
::sigma::\sigma
:c1:tau::\tau
::Upsilon::\Upsilon
::upsilon::\upsilon
::varphi::\varphi
::varPhi::\varPhi
::Xi::\Xi
::xi::\xi
:c1:zeta::\zeta







