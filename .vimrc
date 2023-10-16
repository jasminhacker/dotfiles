" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" include vim plugins
source ~/.vim/plugins.vim

source ~/.vim/style.vim

" auto indenting based on filetype
filetype plugin indent on

" Better command-line completion
set wildmenu

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" search while typing
set incsearch

" Highlight searches (use <C-L> to temporarily turn off highlighting)
" set hlsearch
" Map <C-L> (redraw screen) to turn off search highlighting 
nnoremap <C-L> :nohl<CR><C-L>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" don't move the cursor to the very edge
set scrolloff=5

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" tab characters appear as 4 spaces
set tabstop=4
" do not write spaces instead of tabs
set softtabstop=0 noexpandtab
" indents have width 4
set shiftwidth=4

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" keep record of changes to allow undos between vim sessions
set undofile
set undodir=~/.undodir

" associate *.zsh-theme with zsh filetype
au BufRead,BufNewFile *.zsh-theme setfiletype zsh
au BufNewFile,BufRead *.html setlocal ft=htmldjango

" Allow saving of files as sudo when I forgot to start vim using sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" jk for neo users
inoremap <special> ae <ESC>

" Use to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Use ctrl+i to show interface
nmap <C-i> :set invnumber <bar> set invrelativenumber <bar> set invruler <bar> set invshowmode <CR> 

" reduce linenumber column width
set numberwidth=1

" allow :^ to save
cnoreabbrev ^ w
cnoreabbrev ^q wq

" orient with shortcuts from intellij
" https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf

" Run black on save for python files
autocmd BufWritePre *.py execute ':Black'

" https://github.com/vim/vim/issues/5157
"xnoremap "+y y:call system("wl-copy", @")<cr>
"nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
"nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

" two space indent for js/ts
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab

" Ansible syntax highlighting for all yaml files
autocmd BufNewFile,BufRead *.yaml,*.yml set ft=ansible

" nginx config
au BufRead,BufNewFile /etc/nginx/*,/etc/nginx/conf.d/*,/usr/local/nginx/conf/*,*/conf/nginx.conf,*.nginx.conf if &ft == '' | setfiletype nginx | endif
