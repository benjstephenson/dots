"================================================================
"Vim Resource File
"Ben Stephenson
"================================================================

"Set terminal to 256 colours
if &term =~ "xterm" || &term =~ "screen"
	set t_Co=16
  "256 color --
  let &t_Co=256
	if &term !~ "screen"
		" restore screen after quitting
		set t_ti=7[r[?47h t_te=[?47l8
	endif

  if has("terminfo")
    "let &t_Sf="[3%p1%dm"
    "let &t_Sb="[4%p1%dm"
    set t_AB=[48;5;%dm
    set t_AF=[38;5;%dm
  else
    let &t_Sf="[3%dm"
    let &t_Sb="[4%dm"
  endif
endif

"=================================================================
"Vundle
"=================================================================
set nocompatible
filetype off
set rtp+=~/Repos/Vundle.vim
call vundle#begin("~/.vim/bundle")

Plugin 'L9'
Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'drn/zoomwin-vim'
"Plugin 'ensime/ensime-vim'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'nanotech/jellybeans.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'oblitum/rainbow'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'wincent/command-t'
call vundle#end()

"=================================================================
"General Options
"=================================================================
"Set this first as some other features depend on it.
filetype indent plugin on

set nocp

set nu
set autoread
set hlsearch              "Highlights search results, clear with :noh
set incsearch             "Incremental search as you type
set keywordprg=man        "search for word under cursor using |keywordprg|
set cmdheight=1           "Set cmd window to 1 lines
set wildmenu              "turn on wild cmd menu
set laststatus=2
set cul                "Highlists the line the cursor is on
"set textwidth=110

"Set tab to length of 3 spaces
set tabstop=2
set shiftwidth=2


syn on
set background=dark
colorscheme jellybeans

" Usig=ng netrw over NERDTree
let g:netrw_browse_split=4 "Open files in a last buffer when exploring
let g:netrw_altv=1
let g:netrw_liststyle=3    "default to tree view for directories
let g:netrw_winsize=25     "Split window size to 25% of viewport

"Add some useful places to Vim's PATH
"set path+=./source,.*
set path+=$HOME/.vim/plugin/*
set path+=$PWD/**



" Auto remove trailing whitespace on file save
autocmd BufWritePre * :%s/\s\+$//e
"=================================================================
" Bundle Settings
"=================================================================

" Complete settings - Set Eclim to use YCM for semantic completion
let g:EclimCompletionMethod = 'omnifunc'

"Tell YCM to fall back to an available engine based on filetype if a native
"YCM one isn't available.
autocmd Filetype * runtime! autoload/eclim/<amatch>/complete.vim
    \ | let s:cfunc = 'eclim#'.expand('<amatch>').'#complete#CodeComplete'
    \ | if exists('*'.s:cfunc) | let &l:omnifunc=s:cfunc | endif

"SrcExpl
let g:SrcExpl_pluginList = [
	\ "__NERD_tree__",
	\ "__Tagbar__"
\ ]

"au FileType * call tagbar#autoopen(0)

" Match Tag Alwas
let g:mta_filetypes = {
    \ 'html'  : 1,
    \ 'xhtml' : 1,
    \ 'xml'   : 1,
    \ 'jinja' : 1,
		\ 'js'    : 1,
		\ 'groovy' : 1,
    \}


" UltiSnips
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
"let g:UltiSnipsListSnippets = '<c-m>'


" Rainbow Parenthesis highlighting
let g:rainbow_active = 1

" Command-T
set wildignore+=*.class,target/**

" Indent Guide
" manually set colours for solarized to avoid awful beige colour for odd
" columns
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2
let g:indent_guides_enable_on_vim_startup = 1

"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=blue ctermfg=red
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=magenta ctermfg=green

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Airline
let g:airline#extensions#eclim#enabled = 1
let g:airline_theme="jellybeans"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 "show tab number in tabbar
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
	let g:airline_symbols.linenr = '␊'
	let g:airline_symbols.linenr = '␤'
	let g:airline_symbols.linenr = '¶'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.paste = 'Þ'
	let g:airline_symbols.paste = '∥'
	let g:airline_symbols.whitespace = 'Ξ'
endif
"=================================================================
" Ensime
"=================================================================
au FileType scala noremap <leader>p :EnType<CR>
au FileType scala noremap <leader>df :EnDeclerationSplit<CR>


"==================================================================
"Fold Setup
"==================================================================
"Set the folding options
set foldmarker={{{,}}}     "Set a marker to use when foldmethod is |marker|
set foldmethod=marker
set foldcolumn=2          "Set the width of the lh column which shows fold marks
set foldminlines=5        "Set the min number of lines to make a fold
set foldopen-=search      "Don't open folds when searching

"If we've made some nice folds, save them when we leave and reload them when
"we comeback, but not if it's a ro file or we're in diff mode
if !&diff
  if !&readonly
    au BufWinLeave *.c mkview
    au BufWinEnter *.c silent loadview
  endif
endif

"Keymaps for folding
"Key = <C-f>s
noremap s :set fdm=syntax
"Key=<C-F>m
noremap m :set fdm=manual
"Key=<C-F>a
noremap a :set fdm=marker

"==================================================================
"Autocomplete and Tag Settings
"==================================================================
"Set autocomplete sources; dictionary, tags files etc
"Set the dictionary we would like to use for autocompletion
set tags=$HOME/.vim/tags/glibc.tags,$HOME/.vim/tags/gtkmm.tags,tags
set dict=$HOME/.vim/dictionary/*.list
set complete=.,t
set completeopt=menuone,menu,preview

set pumheight=30
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
map <F8> :!ctags --c++-kinds=+p --fields=+iaS --extra=+q *.cpp<CR>

"==================================================================
"Miscellaneous Key mappings
"==================================================================
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
fun! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &fdm, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


"Close all windows and exit - careful to save beforehand
command! -nargs=0 QQ qall
command! -nargs=0 WQ wall qall

" Remap keys to move between viewports
" Key=<C-LeftArrow>
nmap [1;5D <C-W>h
" Key=<C-DownArrow>
nmap [1;5B <C-W>j
" Key=<C-UpArrow>
nmap [1;5A <C-W>k
" Key=<C-RightArrow>
nmap [1;5C <C-W>l

map <Leader>o <c-w>o

"Opens file under cursor in new window, if in $PATH
"Key=<Gf>
noremap Gf gf


"Turn on/off hex editing of current file
command! -nargs=* Ox %!xxd
command! -nargs=* Nox %!xxd -r

noremap <F2> "=strftime("%c")<CR>p

" Adjust quickfix window to height of contents
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"Toggle NERDTree
noremap <silent> <Leader>nt :NERDTreeToggle<CR>
