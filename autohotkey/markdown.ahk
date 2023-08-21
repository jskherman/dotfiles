#Requires AutoHotkey v2.0

/* General markup */

::fn;;::{Raw}<!--- Footnotes --->

/* Highlights */

:*:==1;;::_====_{Left 3}        ; Italic highlight
:*:==2;;::**====**{Left 4}      ; Bold highlight
:*:==3;;::_**====**_{Left 5}    ; Bold italic highlight
:*:==y;;:: {
    ; Highlight yellow
    SendInput "{Raw}<mark style='background:yellow'></mark>"
    SendInput "{Left 7}"
    return
}
:*:==r;;:: {
    ; Highlight red
    SendInput "{Raw}<mark style='background:red'></mark>"
    SendInput "{Left 7}"
    return
}
:*:==g;;:: {
    ; Highlight green
    SendInput "{Raw}<mark style='background:lime'></mark>"
    SendInput "{Left 7}"
    return
}
:*:==b;;:: {
    ; Highlight blue
    SendInput "{Raw}<mark style='background:cyan'></mark>"
    SendInput "{Left 7}"
    return
}