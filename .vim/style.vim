" command to show all current highlight groups in their colors
" useful for identification
" :runtime syntax/hitest.vim

" enable syntax highlighting
" do it before setting colorscheme to reduce load time
syntax on

set background=dark
"set background=light
" allow italic comments
let g:gruvbox_italic=1
colorscheme gruvbox

" use true colors. doesn't work in tmux screen-256color (all white)
" and outputs wrong colors in tmux xterm-256color
"set termguicolors

" disable ~ characters in empty lines
highlight NonText ctermfg=0 ctermbg=none guifg=#000000
" transparent background
highlight Normal ctermbg=none guibg=#282828
highlight SignColumn ctermbg=none guibg=#282828
highlight CursorLineNr ctermbg=none guibg=#282828
highlight YcmErrorSign ctermbg=none guibg=#282828 ctermfg=red guifg=#fb4934
highlight YcmWarningSign ctermbg=none guibg=#282828 ctermfg=yellow guifg=#fabd2f


" always show the (transparent) sign column containing compilation errors (YCM)
"autocmd BufEnter * sign define dummy
"autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" hide status
set noruler

" hide current mode
set noshowmode

" show whitespace
set list
set listchars=tab:»\ ,nbsp:·,trail:·,extends:›,precedes:‹

" replace the default text on an empty vim an empty screen
fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Start a new buffer
    enew

    " and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber

    " Empty the screen
    call append('$', "")

    " No modifications to this buffer
    setlocal nomodifiable nomodified

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
    " When copying from system clipboard, create a new buffer and paste
    nnoremap <buffer><silent> "+p :enew <bar> normal "+p<CR>
    nnoremap <buffer><silent> "*p :enew <bar> normal "*p<CR>
endfun

" Run after vim startup
autocmd VimEnter * call Start()
