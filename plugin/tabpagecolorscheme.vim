let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_tabpagecolorscheme")
  finish
endif
let g:loaded_tabpagecolorscheme = 1

command! -bar -nargs=? -complete=customlist,s:Colors Tcolorscheme call s:TabpageColorscheme(<f-args>)

function! s:TabpageColorscheme(...)
  if a:0 == 1
    if a:1 !=# s:colors_name()
      execute 'colorscheme ' . a:1
      let t:colorscheme = g:colors_name
    endif
  else
    echo t:colorscheme
  endif
endfunction

function! s:colors_name()
  return exists("g:colors_name") ? g:colors_name : ""
endfunction

augroup TabpageColorscheme
  au!
  autocmd TabEnter * nested
        \   if !exists('t:colorscheme')
        \ |   let t:colorscheme = s:colors_name()
        \ | endif
        \ | call s:TabpageColorscheme(t:colorscheme)
  autocmd VimEnter * let t:colorscheme = s:colors_name()
augroup END

function! s:Colors(A, L, P)
  let l:colors = []
  for l:item in split(globpath(&rtp, 'colors/' . a:A . '*.vim'), "\n")
    call add(l:colors, fnamemodify(l:item, ":t:r"))
  endfor
  return l:colors
endfunction

let g:unite_colorscheme_command = 'Tcolorscheme'

let &cpo = s:save_cpo
