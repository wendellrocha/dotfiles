set nocompatible

set encoding=UTF-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'xolox/vim-misc'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'vimsence/vimsence'
Plug 'gko/vim-coloresque'
Plug 'scrooloose/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" --- General settings ---
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"

set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set textwidth=80 colorcolumn=+1
highlight ColorColumn ctermbg=238
syntax enable

set mouse=a
set background=dark
set laststatus=2
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1


" ----------- fatih/vim-go ------------
filetype plugin indent on

set autowrite

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with CTRL + B
nmap <silent> <C-b> :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

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
let g:dart_format_on_save = 1

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

"-------------------------------------------------------------------- FZF {{{1
" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':    ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

let g:fzf_preview_window = []

" Bcommits
" Blines
" Btags
" Files
let $FZF_DEFAULT_COMMAND=''
nnoremap <leader>p :Files<CR>
nnoremap <leader>fc    :<C-u>Colors<cr>
nnoremap <leader>fcmd  :<C-u>Commands<cr>
nnoremap <leader>fgc   :<C-u>Commits<cr>
nnoremap <leader>fft   :<C-u>Filetypes<cr>
nnoremap <leader>fht   :<C-u>Helptags<cr>
nnoremap <leader>fh    :<C-u>History-command<cr>
nnoremap <leader>fhf   :<C-u>History-files<cr>
nnoremap <leader>fhs   :<C-u>History-search<cr>
nnoremap <leader>fmap  :<C-u>Maps<cr>
nnoremap <leader>fmark :<C-u>Marks<cr>
nnoremap <leader>fw    :<C-u>Windows<cr>

" ---- keymaps -----
"  ctrl+s save file
nnoremap <C-s> :w!<CR>
" ctrl+q quit vim/nvim
nnoremap <C-q> :qa<CR>
" run :DartFmt
nnoremap <A-F> :DartFmt<CR>
" navigate between buffers with f1/f2
nnoremap <F1> :bprevious<CR>
nnoremap <F2> :bnext<CR>
" move live up or down with shift+up/down key
nnoremap <silent> <s-Down> :m +1<CR>
nnoremap <silent> <s-Up> :m -2<CR>
" copy text to clipboard
vnoremap <C-c> "+y<CR>
