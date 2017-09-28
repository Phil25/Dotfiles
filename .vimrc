let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_key_invoke_completion = '<C-b>'
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

set timeoutlen=1000
set ttimeoutlen=0
set noshowmode
set laststatus=2

" hybrid line numbers
set number relativenumber

set history=200

" show unfinished commands
set showcmd

" # of lines from top after centering
set scrolloff=5

" tab size
set tabstop=4

" word line wrap
set lbr

" auto indent
set ai

" filetype detection and syntax highlighting
filetype plugin on
syntax on
