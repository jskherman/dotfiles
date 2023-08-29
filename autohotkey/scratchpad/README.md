# README

This folder contains the files needed to run `mdsp.ahk` which is an AutoHotKey script
which creates a GUI for a scratchpad that supports previewing text in Markdown (and math equations via [KaTeX](https://katex.org/)).

## Requirements

- [AutoHotKey v2](https://www.autohotkey.com/)
- This whole `scratchpad` folder with all its contents.
- Microsoft Edge WebView2 Runtime (for the Markdown preview to work). See Joe's [YouTube video](https://www.youtube.com/watch?v=ErvDqabKjfw&t=3m17s) on WebView2.[^1]

## Usage

Download the whole `scratchpad` folder and just invoke `#Include scratchpad/mdsp.ahk` in your AutoHotKey script and then you can use the following hotkeys:

- `Alt` + `F10` to show the scratchpad.
- `Alt` + `F11` to toggle saving content to Obsidian daily note upon closing the window.[^2]
- `Alt` + `F4` to close the scratchpad.
- `Ctrl` + `M` to toggle math mode and enable hotstrings/hotkeys for editing math equations.[^3]

![Demo of scratchpad window](https://github.com/jskherman/dotfiles/assets/68434444/d990092d-47d2-4035-8513-123a776f2e0c)

[^1]: Already installed if you have Microsoft Office 365.<br> Source: [the-automator](https://www.the-automator.com/downloads/webview2-example-files-display-modern-websites-with-autohotkey-v2/) and [YouTube video](https://www.youtube.com/watch?v=ErvDqabKjfw&t=3m17s).
[^2]: See the [`daily_note.ahk` file](./daily_note.ahk) to specify the path to your Obsidian vault and other variables.
[^3]: Still incomplete and a work-in-progress.
