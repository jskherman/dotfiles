; ===========================================================================
; @description A temporary popup window for editing markdown and previewing it.
; @file mdsp.ahk
; @author jskherman
; @date 2023-08-29
; @version 1.0.0
; ============================================================================

#Requires AutoHotkey v2.0
#Include lib\WebView2.ahk
#Include "math_snippets.ahk"

; ============================================================================
; Variables
; ============================================================================

; Set to true if you want to copy the content in the editor to somewhere else
; every time the window is closed
append_to_data := True

; ============================================================================
; Popup window
; ============================================================================

!F10:: {
    main := Gui(, "MD Scratchpad")
    editor := main.Add("GroupBox", "h610 w400", "Editor")
    initial_text := "Press <kbd>Ctrl</kbd> + <kbd>M</kbd>  to toggle ``Math Mode`` and use $\LaTeX$ hotstrings and hotkeys. See <a href='https://github.com/goessner/markdown-it-texmath' target='_blank'>markdown-it-texmath</a>."
    TextContent := main.Add("edit", "xp+5 yp+20 h580 w390", initial_text)
    plh := main.Add("text", "x+20 h580 w580")
    main.Show("w1020 h620")
    wv := WebView2.create(plh.Hwnd)
    html_preview := 'file:///' A_LineFile '\..\markdown.html'

    updatePreview(*) {
        content := StrReplace(TextContent.Value, "\", "\\")
        content := StrReplace(content, "``", "\``")
        script_content := "var textcontent = ``" content "``"
        render_script := '
        (
            document.addEventListener("DOMContentLoaded", () => {
                const md = markdownit({ html: true })
                    .use(texmath, {
                        engine: katex,
                        delimiters: "dollars",
                        katexOptions: {
                            macros: {
                                "\\RR": "\\mathbb{R}"
                            } 
                        }
                    });
                out.innerHTML = md.render(textcontent);
            });
            )'
    wv.CoreWebView2.Navigate(html_preview)
        wv.CoreWebView2.ExecuteScript(script_content, 0)
        wv.CoreWebView2.ExecuteScript(render_script, 0)
    }

    #Include "daily_note.ahk"

    ClipcopyContent(*) {
        A_Clipboard := TextContent.Value
    }

    updatePreview()
    TextContent.onEvent("Change", updatePreview)

    if append_to_data {
        main.onEvent("Close", write_log_entry)
        ; main.onEvent("Close", ClipcopyContent)
    }
}