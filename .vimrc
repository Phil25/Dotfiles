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

" ycm configuration
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_key_invoke_completion = '<C-b>'

" colors
"hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
"hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
"afterglow anderson angr happy_hacking
colorscheme angr

" allow recursive searching
set path+=**

" tabs
map <F3> :tabp<cr>
map <F4> :tabn<cr>
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = '|'
"let g:airline#extensions#tabline#left_alt_sep = '|'

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

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
