""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          config for nvim-qt                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To check if neovim-qt is running, use `exists('g:GuiLoaded')`,
" see https://github.com/equalsraf/neovim-qt/issues/219

if exists('g:GuiLoaded')
  " Start with a maximized window
  call GuiWindowMaximized(1)

  " Enable Mouse
  set mouse=a

  " Set Editor Font
  if exists(':GuiFont')
      " Use GuiFont! to ignore font errors
      GuiFont! CaskaydiaCove\ Nerd\ Font:h11
  endif

  " Disable GUI Tabline
  if exists(':GuiTabline')
      GuiTabline 0
  endif

  " Disable GUI Popupmenu
  if exists(':GuiPopupmenu')
      GuiPopupmenu 0
  endif

  " Enable GUI ScrollBar
  if exists(':GuiScrollBar')
      GuiScrollBar 1
  endif

  " Right Click Context Menu (Copy-Cut-Paste)
  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
  snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
endif
