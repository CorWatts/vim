set ruler
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set title
set binary noeol
set laststatus=2
set mouse=v
set ff=unix
set backspace=2
set splitbelow
set splitright

set tabstop=2 shiftwidth=2 expandtab

set textwidth=80
set colorcolumn=+1

let mapleader = ","

" ============================================================================
" FZF {{{
" ============================================================================
set rtp+=/usr/local/opt/fzf

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

function FuzzyFind()
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if empty(matchstr(gitparent, '^fatal:.*'))
    silent execute ':FZF ' . gitparent
  else
    silent execute ':FZF .'
  endif
endfunction

command! FZFMix call fzf#run({
            \'source':  'bash -c "'.
            \               'echo -e \"'.join(v:oldfiles, '\n').'\";'.
            \               'ag -l -g \"\"'.
            \           '"',
            \'sink' : 'e ',
            \'dir' : g:projectroot,
            \'options' : '-e -m --reverse',
            \'window' : 'enew',
            \})


"nnoremap <silent> <Leader><Leader> :FZF<CR>
nnoremap <silent> <Leader><Leader> :call FuzzyFind()<CR>
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" }}}

" Ctrl-f to escape insert
inoremap <C-f> <Esc>

" easy window movements
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" match HTML tags with %
runtime macros/matchit.vim

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

execute pathogen#infect()
call pathogen#incubate()
call pathogen#helptags()

filetype plugin on
filetype plugin indent on

:let g:PHP_vintage_case_default_indent = 1

set t_Co=256
set background=dark
colorscheme spacegray

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType make set noexpandtab
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype sass setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2

" hit control-n to toggle NERDTree on and off
map <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40

" Change directory to the current buffer when opening files.
set autochdir

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" hit control-p to toggle CtrlP plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" resize windows with +/- keys
"if bufwinnr(1)
  "map + <C-W>+
  "map - <C-W>-
  "map < <C-w><
  "map > <C-w>>
"endif

" deal with vim backups
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis

" activates rainbow.vim to color parentheses
let g:rainbow_active = 1

let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'html': 0,
    \       'css': 0,
    \       'hbs': 0,
    \   }
    \}

" type _debug in insert mode to insert full error reporting block for PHP
iab _debug error_reporting(E_ALL);<CR><BS><CR>ini_set('display_errors', 1);
iab dump var_dump(<CR><BS><CR>);<CR><BS><CR>exit();<Esc>kkk

"Handlebars stuff
let g:mustache_abbreviations = 1

"Disable tab helper on startup
let g:indentLine_enabled = 0

"Toggle tab helper on or off
noremap <Leader>t :IndentLinesToggle<CR> 

" Quick-Scope: Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Window Swap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

"js beautify
vnoremap <leader>bj :%!js-beautify -j -s 2 -q -B -f -<CR>
vnoremap <leader>bc :%!css-beautify -j -s 2 -q -B -f -<CR>
vnoremap <leader>bh :%!html-beautify -j -s 2 -q -B -f -<CR>
nnoremap <leader>bj :%!js-beautify -j -s 2 -q -B -f -<CR>
nnoremap <leader>bc :%!css-beautify -j -s 2 -q -B -f -<CR>
nnoremap <leader>bh :%!html-beautify -j -s 2 -q -B -f -<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" press K to search for the word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag <C-R><C-W><CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['php'],'passive_filetypes': ['javascript'] }
let g:syntastic_filetype_map = { 'html.handlebars': 'handlebars' }

" enable syntastic with ,se
noremap <Leader>se :SyntasticCheck<CR>
" disable syntastic with ,sd
noremap <Leader>sd :SyntasticToggleMode<CR>

""""""""""""""""""""""""""""""
" airline
" """"""""""""""""""""""""""""""
let g:airline_theme             = 'powerlineish'
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#syntastic#enabled = 1

syntax on
" change visual mode highlight color to something a bit more noticeable
hi Visual term=bold,underline cterm=bold ctermbg=8 gui=bold
