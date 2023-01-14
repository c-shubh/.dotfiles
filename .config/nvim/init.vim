" Plugins
call plug#begin()
    " Gruvbox Theme
    " Plug 'gruvbox-community/gruvbox'

    " onedark theme
    " Plug 'joshdick/onedark.vim'

    " onehalf theme
    Plug 'sonph/onehalf', { 'rtp': 'vim' }

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " autopair
    Plug 'windwp/nvim-autopairs'

    " Tree explorer
    Plug 'preservim/nerdtree'

    " Fuzzy file finder
    Plug 'junegunn/fzf'

    " Language server client
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Comment plugin
    Plug 'numToStr/Comment.nvim'
call plug#end()

" Config
colorscheme onehalfdark
set number
set colorcolumn=80
set cursorline
set mouse=nvi
set clipboard=unnamed
set splitright
set splitbelow

" https://gist.github.com/pthrasher/3933522

filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
function Tab2()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
endfunction
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block

" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

" Mappings
" save on Ctrl-S
nnoremap <C-s> <ESC>:w<CR>
" close on Ctrl-W
nnoremap <C-w> <ESC>:q<CR>
" un tab on Shift-Tab
inoremap <S-Tab> <C-S-D>
" Clear search highlight when ESC is pressed
nnoremap <silent> <ESC> :noh<CR><ESC>

" https://jeffkreeftmeijer.com/vim-number/
" Hybrid line numbers in Normal mode
" Absolute line numbers in Insert Mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeIgnore = []
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fzf
nnoremap <C-p> :FZF<CR>
let fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
" requires silversearcher-ag
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" coc
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Ctrl-Alt-o go to symbol
nnoremap <C-A-o> <ESC>:CocList -I symbols<CR>
" Ctrl-F format
nnoremap <C-F> <ESC>:CocCommand editor.action.formatDocument<CR>

" Comment.nvim
lua << EOF
require('Comment').setup()
EOF

" autopair
" lua << EOF
" require("nvim-autopairs").setup {}
" EOF

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
