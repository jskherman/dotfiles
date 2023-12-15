#t:: {
    Run("wt.exe")
}

; Todoist Task Templates
#HotIf WinActive("– Todoist")

; Win + Alt + T
#!T:: {
    ; study_item := InputBox("Please enter what you are studying:", "Todoist: Chapter?", "W300 H100")
    ; Create a GUI window
    Prompt := Gui(, "Todoist Study Item")

    ; Prompt for the study item
    Prompt.Add("Text", "h1 w250", "")
    Prompt.Add("Text", "R1 w250 vPrompt1", "Please enter what you are studying:")
    study_item := Prompt.AddEdit("R1 w250 vStudyItem", "")
    Prompt.Add("Text", "h1 w250", "")

    ; Prompt for the category
    Prompt.Add("Text", "R1 w250 vPrompt2", "What is the subject category?")
    category := Prompt.AddDropDownList("R3 w250 vCategoryChoice Choose1", ["D1-PCP", "D2-CHE", "D3-GEN"])
    Prompt.Add("Text", "R1 w250", "")

    ; Add a submit button
    Prompt.AddButton("Default x35 w80 vSubmitBtn", "&Submit").OnEvent("Click", Submit)
    Prompt.AddButton("x+40 w80 vCloseBtn", "&Cancel").OnEvent("Click", Close)

    ; Show the GUI
    Prompt.Show()

    Close(*) {
        Prompt.Destroy()
    }

    ; Event to execute when the Submit button is clicked
    Submit(*) {
        ; Save the text to be inserted to the clipboard
        A_Clipboard := Format('
            (
                Read {1} @{2}
                Answer {1} Problems @{2}
                Anki: Save (5) Questions from {1} @{2}
                Anki: Create Flashcards from {1} @{2}
            )',
            study_item.Value, category.Text
        )
        ; Close the GUI
        Prompt.Destroy()
        ; Wait for the GUI to close
        WinWaitClose("Todoist Study Item")
        ; Activate the Todoist window
        WinActivate("– Todoist")
        ; Send the text to be inserted
        Send("^v{Enter}")
    }
}
#HotIf