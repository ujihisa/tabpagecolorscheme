command! -bar -nargs=1
      \   TabpageColorscheme
      \   execute 'colorscheme' <q-args>
      \   | let t:colorscheme = g:colors_name

autocmd TabEnter *
      \   if !exists('t:colorscheme')
      \ |   let t:colorscheme = g:colors_name
      \ | endif
      \ | execute 'colorscheme' t:colorscheme

let g:unite_colorscheme_command = 'TabpageColorscheme'
