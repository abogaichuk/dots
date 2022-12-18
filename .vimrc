syntax enable
set tabstop=4
set expandtab
set hlsearch
set number
filetype indent on
set autoindent
set shell=/bin/bash
set nocompatible
set ruler
filetype off 
syntax on
colorscheme onedark

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'ap/vim-css-color'               "Color previews for CSS
"add plugins here to install, and clone plugin git repo to cd .vim/bundle/
"folder. Then, run :PluginInstall here

call vundle#end()
filetype plugin indent on
