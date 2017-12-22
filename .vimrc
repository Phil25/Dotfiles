set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'yuttie/comfortable-motion.vim'
Plugin 'artur-shaik/vim-javacomplete2'
call vundle#end()
filetype plugin indent on
syntax on

let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_key_invoke_completion = '<C-b>'
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" allow recursive searching
set path+=**

map <F3> :tabp<cr>
map <F4> :tabn<cr>

set timeoutlen=1000
set ttimeoutlen=0
set noshowmode
set laststatus=2
set wildmenu

" hybrid line numbers
set number relativenumber

set history=200

" show unfinished commands
set showcmd

" # of lines from top after centering
set scrolloff=8

" auto indent
set ai

" tab size
set tabstop=4
set shiftwidth=4

" word line wrap
set lbr

" run custom scripts for various stuff
map <F5> :! ./run.sh "%"<cr>
map <F6> :! ./compile.sh "%"<cr>

let g:Tex_DefaultTargetFormat='pdf'

au FileType java setlocal omnifunc=javacomplete#Complete
au FileType java map <F7> <Plug>(JavaComplete-Imports-AddMissing)
au FileType java map <F8> <Plug>(JavaComplete-Imports-RemoveUnused)
