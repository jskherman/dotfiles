#Requires AutoHotkey v2.0
#Include lib\WebView2.ahk
#Include latex.ahk

!F10:: {
    main := Gui(, "MD Scratchpad")
    editor := main.Add("GroupBox", "h610 w400", "Editor")
    TextContent := main.Add("edit", "xp+5 yp+20 h580 w390", "Euler's identity $e^{i\pi}+1=0$ is a beautiful formula.")
    plh := main.Add("text", "x+20 h580 w580")
    main.Show("w1020 h620")
    wv := WebView2.create(plh.Hwnd)
    html_preview := 'file:///' A_LineFile '\..\markdown.html'
    ; wv.CoreWebView2.Navigate(html_preview)

    updatePreview(*) {
        script_content := "var textcontent = ``" StrReplace(TextContent.Value, "\", "\\") "``"
        render_script := '
        (
            document.addEventListener("DOMContentLoaded", () => {
                const md = markdownit({ html: true })
                    .use(texmath, {
                        engine: katex,
                        delimiters: "dollars",
                        katexOptions: { macros: { "\\RR": "\\mathbb{R}" } }
                    });
                out.innerHTML = md.render(textcontent);
            });
            )'
        wv.CoreWebView2.Navigate(html_preview)
        wv.CoreWebView2.ExecuteScript(script_content, 0)
        wv.CoreWebView2.ExecuteScript(render_script, 0)
    }

    updatePreview()
    TextContent.onEvent("Change", updatePreview)
}
