" source C:\Users\lucas\AppData\local\nvim\config_files\coc_c++_config.vim

let config_path = expand('<sfile>:p:h') . '/config_files/coc_c++_config.vim'
execute 'source' config_path


" This line enables the true color support.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256

" Note, the above line is ignored in Neovim 0.1.5 above, use this line instead.
set termguicolors

"Config Section
:set nowrap
:set noshowmode
:set cmdheight=1
set signcolumn=no
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4            " width for autoindents
"set autoindent             " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=                     " set an 80 column border for good coding style
"filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim

"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

call plug#begin()

    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
    Plug 'jakemason/ouroboros'

    Plug 'lukas-reineke/indent-blankline.nvim'
    
    "Plug 'lukas-reineke/indent-blankline.nvim'   

    " Utilities
    Plug 'sheerun/vim-polyglot'
    " Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'plasticboy/vim-markdown'

    Plug 'numToStr/Comment.nvim'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme true-monochrome
" colorscheme lunaperche
" colorscheme menguless 

let b:coc_diagnostic_disable=1

"let blacklist = ['vim', 'help']
"autocmd CursorHold * if (index(blacklist, &ft) < 0 || !coc#rpc#ready()) | silent! call CocActionAsync('doHover')

let g:airline_powerline_fonts = 1
let g:airline_theme = "monochrome"

let g:fzf_layout = { 'down': '~20%' }

inoremap jk <Esc>
nmap <F8> :NERDTreeToggle<CR>

let mapleader = "\<Space>"
nnoremap <Leader><Leader> :w<CR>
nnoremap <silent> <Leader>h :bp<CR>
nnoremap <silent> <Leader>l :bn<CR>
nnoremap <silent> <Leader>t :tabNext<CR>
nnoremap <silent> <Leader>f :Telescope find_files<CR>
nnoremap <silent> <Leader>b :Telescope buffers<CR>
nnoremap <silent> <Leader>r :Telescope live_grep<CR>
nnoremap <silent> <Leader>/ :noh<CR>

nnoremap <A-o> :Ouroboros<CR>

nnoremap :hs :split<CR> <C-w>j
nnoremap :vs :vsplit<CR> <C-w>l

"Indent guides setup

lua << EOF
require('Comment').setup()

local highlight = {
    "Grey",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Grey", { fg = "#2d555a" })
end)

require("ibl").setup { indent = { highlight = highlight } }

EOF

