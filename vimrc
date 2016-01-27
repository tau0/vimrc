" ##############################################################################
" General
" ##############################################################################
set ruler
set autoread
set number
set relativenumber
let mapleader = ","
set autoindent
set cindent
set shiftwidth=4
set expandtab  
set so=7
set cmdheight=2
set showmatch 

set encoding=utf8
set colorcolumn=81
set history=5000

" Turn backup off
set nobackup
set nowb
set noswapfile

" Show spaces and tabs
set listchars=nbsp:.,trail:.,tab:--
set list

" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

map 0 ^

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


" Ignore case when searching
set ignorecase

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" ##############################################################################
" Hotkeys
" ##############################################################################
map <leader>bd :Bclose<cr>
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>gd :YcmCompleter GoTo<CR>
nnoremap <F10> :YcmForceCompileAndDiagnostics<CR>


" Windows fast switch
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" ##############################################################################
" Vundle setup
" ##############################################################################
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
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/a.vim'

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

" ##############################################################################
" YCM
" ##############################################################################
if has('python')
    python import os.path
    let g:ycm_extra_conf_globlist = [
        \ pyeval('os.path.realpath(os.path.expandvars("$ARCADIA_ROOT/.ycm_extra_conf.py"))')
    \ ]
endif

" ##############################################################################
" Local config 
" ##############################################################################
let local_config_path = $HOME . '/.local_vimrc.vim'
if filereadable(local_config_path)
    exec 'source ' . local_config_path
    endif
" ##############################################################################
" NerdTree
" ##############################################################################
nnoremap <leader>nn :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ##############################################################################
" Themes
" ##############################################################################
set background=dark
colorscheme gruvbox

" ##############################################################################
" Helpers
" ##############################################################################
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
