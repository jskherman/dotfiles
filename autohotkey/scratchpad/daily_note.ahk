#Requires AutoHotkey v2.0

; ============================================================================
; Obsidian Daily Note Main Logic
; ============================================================================
; If the daily note file doesn't exist, create it
write_log_entry(*) {

    ; ============================================================================
    ; Variables
    ; ============================================================================

    current_year := FormatTime(A_Now, "yyyy")
    current_month := FormatTime(A_Now, "MMM")
    current_date := FormatTime(A_Now, "yyyy-MM-dd")
    current_timestamp := FormatTime(A_Now, "yyyy-MM-ddTHH:mm:ss") "+08:00"
    days := DateDiff(A_Now, 20010529, "D")

    obsidian_dir := "E:\OneDrive\z"
    dailynote_file := obsidian_dir "\10-personal\1A-journal\" current_year "\" current_date ".md"

    log_content := TextContent.Value

    ; Check if the daily note file exists
    if !FileExist(dailynote_file) {
        if log_content != "" {
            ; If it doesn't exist, create it
            daily_note := FileOpen(dailynote_file, "a", "UTF-8")
            daily_note.Write(Format('
(
---
title: {1}
type: journal
tags: ["-/journal", "-j/daily", "-j/{4}", "-j/{5}"]
date: {2}
lastmod: {2}
---

## Log Entries

> The current entry is **§{3}**.

)',
    current_date, current_timestamp, days, current_year, current_month))

        ; After creating the file, append the log entry

        daily_note.Write("`n" FormatTime(A_Now, "``HH:mm``") " " log_content "`n")
        daily_note.Close()
        }
    }
    else if FileExist(dailynote_file) {
        if log_content != "" {
            ; If it exists, append the log entry
            daily_note := FileOpen(dailynote_file, "a", "UTF-8")
            daily_note.Write("`n" FormatTime(A_Now, "``HH:mm``") " " log_content "`n")
            daily_note.Close()
        }
    }
}