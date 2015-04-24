let s:save_cpo = &cpo
set cpo&vim

function! tabpagecolorscheme#command(...)
  if a:0 == 1
    call tabpagecolorscheme#set(a:1)
  else
    echo t:colorscheme
  endif
endfunction

function! tabpagecolorscheme#set(colorname)
  if a:colorname !=# tabpagecolorscheme#colors_name()
    execute 'colorscheme ' . a:colorname
    " Don't trust g:colors_name, because
    "   1. Some legacy colorschemes do't define it
    "   2. Some colorschemes even put wrong values; like wrong upcase/downcase.
    " let t:colorscheme = g:colors_name
    let t:colorscheme = a:colorname
  endif
endfunction

function! tabpagecolorscheme#colors_name()
  return exists("g:colors_name") ? g:colors_name : ""
endfunction

function! tabpagecolorscheme#colors(A, L, P)
  let l:colors = []
  for l:item in split(globpath(&rtp, 'colors/' . a:A . '*.vim'), "\n")
    call add(l:colors, fnamemodify(l:item, ":t:r"))
  endfor
  return l:colors
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
