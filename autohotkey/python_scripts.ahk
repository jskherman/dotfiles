#Requires AutoHotkey v2.0

/* FUNCTIONS */
gen_nanoid() {
    tmp_clip := ClipboardAll()
    A_Clipboard := ""
    Run '"pythonw.exe" "E:\OneDrive\Documents\Workspace\dotfiles\autohotkey\scripts\nanoid_gen.pyw"'
    status := ClipWait(,0)
    if status = 0 
    {
        gen_nanoid()
    } 
    else if status = 1
    {
        Send "^v"
        A_Clipboard := tmp_clip
    }
    return
}

/* HOTSTRINGS */

:*:nid;;:: {
    ; Generate a random 12-character nanoid
    gen_nanoid()
    Return
}