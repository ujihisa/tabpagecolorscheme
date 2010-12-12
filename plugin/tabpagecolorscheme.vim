let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_tabpagecolorscheme")
	finish
endif
let g:loaded_tabpagecolorscheme = 1

command! -bar -nargs=? -complete=customlist,s:Colors Tcolorscheme call s:TabpageColorscheme(<f-args>)

function! s:TabpageColorscheme(...)
	if a:0 == 1
		execute 'colorscheme ' . a:1
		let t:colorscheme = g:colors_name
	else
		echo t:colorscheme
	endif
endfunction

augroup TabpageColorscheme
	au!
	autocmd TabEnter *
	      \   if !exists('t:colorscheme')
	      \ |   let t:colorscheme = g:colors_name
	      \ | endif
	      \ | execute 'colorscheme' t:colorscheme
	autocmd VimEnter * let t:colorscheme = g:colors_name
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
