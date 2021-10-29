" setup minpac
packadd minpac
call minpac#init()

" shorten a few minpac commands
command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()

" install plugins
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-projectionist')
call minpac#add('vim-syntastic/syntastic')
call minpac#add('vim-airline/vim-airline')
call minpac#add('tpope/vim-fugitive')
call minpac#add('elzr/vim-json')
call minpac#add('hashivim/vim-terraform')
call minpac#add('scrooloose/nerdtree')
call minpac#add('itchyny/lightline.vim')
call minpac#add('nicknisi/vim-base16-lightline')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-sleuth')
call minpac#add('Xuyuanp/nerdtree-git-plugin')
call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')
call minpac#add('chriskempson/base16-vim')
call minpac#add('joshdick/onedark.vim')
" call minpac#add('Valloric/YouCompleteMe', {'do': {-> system('./install.py --clang-completer --go-completer')}})
call minpac#add('Valloric/ListToggle')
call minpac#add('ervandew/supertab')

" load all plugins
packloadall

" Enable loading filetype and indent plugins
filetype plugin on
filetype indent on

set autoread " Reload files that have changed outside of vim
set number " always show line numbers

" allows vim to act like other editors
" by carrying over buffers between sessions
set hidden

" Allow backspacing over everything
set backspace=indent,eol,start

" Insert mode completion options
set completeopt=menu,menuone,preview

" Remember up to 5000 'colon' commmands and search patterns
set history=5000

" Set the background to dark
set background=dark

" Make all tabs 4 spaces
" Make tabs delete properly
" Make autoindent add 4 spaces per indent level
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " Convert all tabs
set smarttab
set nowrap " No wrapping unless I say so

set encoding=utf-8 " Allow editing of utf-8 files.
set iskeyword+=_,$,@,%,#,- " Adds things to the keyword search

" When a bracket is inserted, briefly jump to a matching one
set showmatch
set matchtime=3 " Match brackets for 3/10th of a sec.

set autoindent " Auto Indent
set smartindent " Smart Indent

set ignorecase
set smartcase

set nohlsearch " Don't Highlight searches

" Always show status line, even for one window
set laststatus=2

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3
set scrolljump=5 " Set the scroll jump to be 5 lines

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
" switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


let g:lightline = {
\   'colorscheme': 'base16',
\   'active': {
\       'left': [ [ 'mode', 'paste' ],
\               [ 'gitbranch' ],
\               [ 'readonly', 'filetype', 'filename' ]],
\       'right': [ [ 'percent' ], [ 'lineinfo' ],
\               [ 'fileformat', 'fileencoding' ],
\               [ 'linter_errors', 'linter_warnings' ]]
\   },
\   'component_expand': {
\       'linter': 'LightlineLinter',
\       'linter_warnings': 'LightlineLinterWarnings',
\       'linter_errors': 'LightlineLinterErrors',
\       'linter_ok': 'LightlineLinterOk'
\   },
\   'component_type': {
\       'readonly': 'error',
\       'linter_warnings': 'warning',
\       'linter_errors': 'error'
\   },
\   'component_function': {
\       'fileencoding': 'LightlineFileEncoding',
\       'filename': 'LightlineFileName',
\       'fileformat': 'LightlineFileFormat',
\       'filetype': 'LightlineFileType',
\       'gitbranch': 'LightlineGitBranch'
\   },
\   'tabline': {
\       'left': [ [ 'tabs' ] ],
\       'right': [ [ 'close' ] ]
\   },
\   'tab': {
\       'active': [ 'filename', 'modified' ],
\       'inactive': [ 'filename', 'modified' ],
\   },
\   'separator': { 'left': '', 'right': '' },
\   'subseparator': { 'left': '', 'right': '' }
\ }
" \   'separator': { 'left': '▓▒░', 'right': '░▒▓' },
" \   'subseparator': { 'left': '▒', 'right': '░' }

function! LightlineFileName() abort
    let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
    if filename =~ 'NERD_tree'
        return ''
    endif
    let modified = &modified ? ' +' : ''
    return fnamemodify(filename, ":~:.") . modified
endfunction

function! LightlineFileEncoding()
    " only show the file encoding if it's not 'utf-8'
    return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

function! LightlineFileFormat()
    " only show the file format if it's not 'unix'
    let format = &fileformat == 'unix' ? '' : &fileformat
    return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! LightlineFileType()
    return WebDevIconsGetFileTypeSymbol()
endfunction

function! LightlineLinter() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
endfunction

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
endfunction

function! LightlineLinterOk() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? 'OK' : ''
endfunction

function! LightlineGitBranch()
    return "\uE725" . (exists('*fugitive#head') ? fugitive#head() : '')
endfunction

function! LightlineUpdate()
    if g:goyo_entered == 0
        " do not update lightline if in Goyo mode
        call lightline#update()
    endif
endfunction

augroup alestatus
    autocmd User ALELintPost call LightlineUpdate()
augroup end


" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.viminfo

" Set the default behavior of opening a buffer to use the one already open
set swb=useopen

" Set command-line completion mode:
"   Complete longest common string, then list alternatives.
set wildmode=longest,list,full

" Don't auto wrap anything
set textwidth=0
set linebreak " Wrap lines at convenient points

" Automatically write files out on buffer changes
set autowrite
set autowriteall

set colorcolumn=80
let mapleader = ","

" code folding settings
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1

" window moving shortcuts
map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" =============================================
" Plugin Configs
" =============================================
" NERDTree Configs
" autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "?"
  \ }

let g:syntastic_check_on_open=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting = 1
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': ['puppet','python','php', 'javascript'],
            \ 'passive_filetypes': [] }
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_python_flake8_args = " --ignore F403 "  " Ingore from bla import * errors
let g:syntastic_puppet_puppetlint_args = " --no-80chars-check "
let g:syntastic_phpcs_conf = "--standard=PSR2 "
let g:syntastic_ruby_checkers = ['rubylint', 'rubocop']
let g:syntastic_javascript_checkers = ['standard']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Airline Config
let g:airline_detect_paste=1
" let g:airline_theme= "gotham256"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '-'
let g:airline_left_alt_sep = '-'
let g:airline_right_sep = '-'
let g:airline_right_alt_sep = '-'
let g:airline_symbols.branch = '-'
let g:airline_symbols.readonly = '-'
let g:airline_symbols.linenr = '-'
let g:airline_symbols.whitespace = 'Ξ'

" Ack config to use silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" VIM Terraform Config
let g:terraform_align=1          " allow plugin to squash other indent directives
let g:terraform_fold_sections=1  " allow fold/unfold
let g:terraform_remap_spacebar=1 " use spacebar in command mode to fold/unfold
