set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Raimondi/delimitMate'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'natebosch/vim-lsc'
Plugin 'natebosch/vim-lsc-dart'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'HTML-AutoCloseTag'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'valloric/youcompleteme'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'elzr/vim-json'
Plugin 'elixir-lang/vim-elixir'
Plugin 'luochen1990/rainbow'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'vimsence/vimsence'
Plugin 'neoclide/coc.nvim'
Plugin 'gko/vim-coloresque'
Plugin 'ryanoasis/vim-devicons'

call vundle#end()

"colorscheme dracula

filetype plugin indent on

" --- General settings ---
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"

set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

syntax enable

set mouse=a
set background=dark
set laststatus=2
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0

" ----- scrooloose/syntastic settings -----
"let g:syntastic_error_symbol = '✘'
"let g:syntastic_warning_symbol = "▲"
"augroup mySyntastic
"  au!
"  au FileType tex let b:syntastic_mode = "passive"
"augroup END

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" ----- airblade/vim-gitgutter settings -----
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ---- dart-lang/dart-lang settings -----
let dart_html_in_string=v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 0

" Use all the defaults (recommended):
let g:lsc_auto_map = v:true

" Apply the defaults with a few overrides:
let g:lsc_auto_map = {'defaults': v:true, 'FindReferences': '<leader>r'}

" Setting a value to a blank string leaves that command unmapped:
let g:lsc_auto_map = {'defaults': v:true, 'FindImplementations': ''}

" ... or set only the commands you want mapped without defaults.
" Complete default mappings are:
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'SignatureHelp': 'gm',
    \ 'Completion': 'completefunc',
    \}

autocmd CompleteDone * silent! pclose

" ---- ntpeters/vim-better-whitespace ----
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" ---- rainbow you belong with me ----
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" ---- keymaps -----
"  ctrl+s save file
nnoremap <C-s> :w!<CR>
" ctrl+q quit vim/nvim
nnoremap <C-q> :qa<CR>
" navigate between buffers with f1/f2
nnoremap <F1> :bprevious<CR>
nnoremap <F2> :bnext<CR>
" move live up or down with shift+up/down key
nnoremap <silent> <s-Down> :m +1<CR>
nnoremap <silent> <s-Up> :m -2<CR>
" copy text to clipboard
vnoremap <C-c> "+y<CR>
