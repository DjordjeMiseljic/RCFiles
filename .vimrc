"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"LEADER
:let mapleader = " "

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'w0rp/ale'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nvie/vim-flake8'
call vundle#end()            " required
filetype plugin on    " required

"SINGNAL COLUMN
set signcolumn = "yes"
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')


"YOUCOMPLETEME CONFIG
let g:ycm_show_diagnostics_ui = 1
let g:ycm_add_preview_to_completeopt = 1 
let g:ycm_autoclose_preview_window_after_completion = 1 
nnoremap <leader>/ :YcmCompleter GetDoc<CR> 
"nnoremap <leader>s :YcmCompleter GoTo<CR>
let g:ycm_register_as_syntastic_checker = 1

"SYNTASTIC CONFIG
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"AIRLINE CONFIG
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 3
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
let g:airline_theme='angr'
 
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      if empty(&shellxquote)
"        let l:shxq_sav = ''
"        set shellxquote&
"      endif
"      let cmd = '"' . $VIMRUNTIME . '\diff"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"  if exists('l:shxq_sav')
"    let &shellxquote=l:shxq_sav
"  endif
"endfunction

set t_Co=256
set background=dark


"Display numbers of lines
set number

"Color words reserved for programming languages
syntax on

"Set colorscheme
colorscheme oceanblack256

"Display information at the bottom of the window
set ruler laststatus=2 number title hlsearch

"Flashes instead of beeping
set visualbell
set belloff=all

"Remove menu 
set guioptions-=m
set guioptions-=M
set guioptions-=T

"Set tab width to 3 spaces
set tabstop=3
set shiftwidth=3

"Set indentation for programming
set smartindent

"Tab is now space the same as doint space 3 times
"set expandtab

"Plugin related
"execute pathogen#infect()

"KEY MAP
"Map Alt+a to sellect all and copy
nnoremap <A-a> gg"+VG

"Map Alt+hjkl to move maximally in respective directions
map <A-h> 0
map <A-l> $
map <A-j> G
map <A-k> gg

"Map Alt+oO to insert new lines without exiting normal mode
map <A-o> o<esc>
map <A-O> O<esc>

"Map Alt+pP to paste in new lines without exiting normal mode
nnoremap <A-p> o<esc>p
nnoremap <A-P> O<esc>p

"C Comment shortcuts
nnoremap <A-,> I/*<esc>
nnoremap <A-.> A*/<esc>
nnoremap <A-/> I//<esc>

"Press j+k at approx. sam time to exit insert mode
inoremap jk <esc>
inoremap kj <esc>

"Bracket manipulation
inoremap {} <CR>{<CR>}<C-o>==<C-o>O
inoremap () ()<left>
inoremap (); ();
inoremap ()<lt> ()<lt>
inoremap <lt>> <lt>><left>
inoremap "" ""<left>
inoremap [] []<left>
inoremap (){} ()<CR>{<CR>}<C-o>==<C-o>O

"Move trough panes 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l 

"Newtab
nnoremap <C-n> :tabnew .<CR>

"NERDTree toggle
nnoremap <S-Tab> :NERDTreeToggle <CR>

"ALE Toggle
map <F6> :ALEToggle <CR>
"Syntastic Mode
map <F5> :SyntasticToggleMode <CR>
"Spellcheck
map <F9> :setlocal spell! spelllang=en_us<CR>

"Map H and L to previous and next tab
nnoremap H gT
nnoremap L gt
"Move tabs left/right
nnoremap <silent> <A-H> :-tabmove<cr>
nnoremap <silent> <A-L> :+tabmove<cr>

"In visual mode selected text will be searched for using // 
vnoremap // y/<C-R>"<CR>
"In visual mode selected text will be searched for and then replaced
vnoremap <A-/> "hy:%s/<C-r>h//gc<left><left><left>


"fullscreen
if has('gui_running')
    set lines=999 columns=999
endif

"let g:airline#extensions#ale#enabled = 1
"let g:ale_completion_enabled = 1

