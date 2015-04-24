let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_tabpagecolorscheme")
  finish
endif
let g:loaded_tabpagecolorscheme = 1

command! -bar -nargs=? -complete=customlist,tabpagecolorscheme#colors Tcolorscheme call tabpagecolorscheme#run(<f-args>)

augroup TabpageColorscheme
  autocmd!
  autocmd TabEnter * nested
        \   if !exists('t:colorscheme')
        \ |   let t:colorscheme = tabpagecolorscheme#colors_name()
        \ | endif
        \ | call tabpagecolorscheme#run(t:colorscheme)
  autocmd VimEnter * let t:colorscheme = tabpagecolorscheme#colors_name()
augroup END

let g:unite_colorscheme_command = 'Tcolorscheme'

let &cpo = s:save_cpo
