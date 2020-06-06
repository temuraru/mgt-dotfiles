set runtimepath+=~/.dotfiles/.vim
" https://medium.com/usevim/vim-101-runtimepath-83194d411b0a
" :set runtimepath? => runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim81,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,~/.dotfiles/.vim

" Info: https://dougblack.io/words/a-good-vimrc.html
" colorscheme goodwolf 
" colorscheme molokai 
" colorscheme badwolf 
colorscheme desert 
syntax enable
set tabstop=4 
set softtabstop=4
set expandtab  
set number  
set showcmd  
set cursorline
filetype indent on 
filetype plugin indent on
set wildmenu 
set lazyredraw   
set showmatch
set incsearch  
set hlsearch 
" security issue: Vim/Neovim Arbitrary Code Execution via Modelines
" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set modelines=0
set nomodeline
" toggle line numbers with F3
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>
set laststatus=2 " allow statusline: https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }
if !has('gui_running')
  set t_Co=256
endif