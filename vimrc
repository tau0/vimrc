" ##########################################################################################
" General 
" ##########################################################################################
set number
let mapleader = ","
set autoindent
set cindent
set shiftwidth=4
set expandtab

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" ##########################################################################################
" Vundle setup 
" ##########################################################################################
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'git://github.com/Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ##########################################################################################
" YCM
" ##########################################################################################
if has('python')
    python import os.path
    let g:ycm_extra_conf_globlist = [
        \ pyeval('os.path.realpath(os.path.expandvars("$ARCADIA_ROOT/.ycm_extra_conf.py"))')
    \ ]
endif

" ##########################################################################################
" Yandex
" ##########################################################################################
let yandex_config_path = $HOME . '/.yandex_vimrc.vim'
if filereadable(yandex_config_path)
    exec 'source ' . yandex_config_path
    endif
" ##########################################################################################
" NerdTree
" ##########################################################################################
nnoremap <leader>nn :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
