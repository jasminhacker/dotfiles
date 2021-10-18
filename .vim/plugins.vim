" load vim-plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " install plugins
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" install plugins with :PlugInstall

call plug#begin('~/.vim/plugged')

" color theme
Plug 'morhetz/gruvbox'

" python formatting
Plug 'psf/black'

" syntax coloring for ansible yaml+jinja
Plug 'chase/vim-ansible-yaml'
Plug 'lepture/vim-jinja'

" syntax coloring for shader files
Plug 'tikhomirov/vim-glsl'
autocmd! BufNewFile,BufRead *.vs,*.fs,*.shader set ft=glsl

" syntax coloring for qml files
"Plug 'peterhoeg/vim-qml'

" YouCompleteMe is memory and cpu intensive,
" substitute with a more lightweight alternative tab completion
Plug 'ackyshake/VimCompletesMe'
" use shift-tab for completion, no backward completion
let g:vcm_default_maps = 0
" TODO
inoremap <S-Tab> vim_completes_me_forward
"let vim_completes_me_backward

"Plug 'Valloric/YouCompleteMe'
"" use a global config to squelch prompts
"let g:ycm_global_ycm_extra_conf = '~/.dotfiles/vim/.ycm_extra_conf.py'
"" unicode icons
"let g:ycm_warning_symbol = ''
"let g:ycm_error_symbol = '✘'
"" let the errors populate the location list so we can jump to them
"let g:ycm_always_populate_location_list = 1
"" set some shortcuts for the cool features
"" reference: https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
"nmap <F2> :lnext<CR>
"nmap <A-f> :YcmCompleter GoToDeclaration<CR>
"nmap <C-f> :YcmCompleter GoToDefinition<CR>
"nmap <C-q> :YcmCompleter GetDoc<CR>
"" close the quickfix window afterwards
"nmap <C-c> :YcmCompleter FixIt<CR><C-w>j:close<CR>

call plug#end()
