" source C:\Users\lucas\AppData\local\nvim\config_files\coc_c++_config.vim

let config_path = expand('<sfile>:p:h') . '/config_files/coc_c++_config.vim'
" execute 'source' config_path


" This line enables the true color support.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256

" Note, the above line is ignored in Neovim 0.1.5 above, use this line instead.
set termguicolors

"Config Section
" :set nowrap
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

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'loctvl842/monokai-pro.nvim'
    Plug 'mswift42/vim-themes'

    Plug 'vague2k/vague.nvim'
    Plug 'rebelot/kanagawa.nvim'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
    Plug 'jakemason/ouroboros'

    Plug 'tiagovla/scope.nvim'
    
    " Plug 'folke/snacks.nvim'
    " Plug 'mikavilpas/yazi.nvim'

    Plug 'nvim/nvim-lspconfig'

    Plug 'echasnovski/mini.nvim'
    " Plug 'lukas-reineke/indent-blankline.nvim'

    " Utilities
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

    Plug 'sheerun/vim-polyglot'
    " Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'plasticboy/vim-markdown'

    Plug 'numToStr/Comment.nvim'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

" colorscheme monokai-pro-spectrum
" colorscheme true-monochrome
" colorscheme true-true-monochrome
" colorscheme darktooth
" colorscheme rams
" colorscheme minicyan
" colorscheme vague 
colorscheme kanagawa-dragon
" colorscheme munich 
" colorscheme menguless 

"let blacklist = ['vim', 'help']

let g:airline_powerline_fonts = 0
" let g:airline_theme = "violet"
" let g:airline_theme = "monochrome"
" let g:airline_theme = "silver"
" let g:airline_theme = "base16_darktooth"
let g:airline_theme = "base16_black_metal_dark_funeral"
" let g:airline_theme = "sol"
" let g:airline_theme = "luna"

let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                                                           
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right                                                           
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 0

let g:fzf_layout = { 'down': '~20%' }

inoremap jk <Esc>
nmap <F8> :NERDTreeToggle<CR>

let mapleader = "\<Space>"
nnoremap <Leader><Leader> :w<CR>
nnoremap <silent> <Leader>h :bp<CR>
nnoremap <silent> <Leader>l :bn<CR>
nnoremap <silent> <Leader>j :Ex<CR>
nnoremap <silent> <Leader>J :Vex<CR>

nnoremap <silent> <Leader>f :Telescope find_files<CR>

nnoremap <silent> <Leader>b :Telescope buffers<CR>
nnoremap <silent> <Leader>B :Telescope scope buffers<CR>

nnoremap <silent> <Leader>r :Telescope live_grep<CR>
nnoremap <silent> <Leader>m :Telescope marks<CR>
nnoremap <silent> <Leader>/ :noh<CR>
nnoremap <silent> <Leader>Y :ToggleTermToggleAll<CR>

nnoremap <silent> <Leader>t :tabn<CR>
nnoremap <silent> <Leader>T :tabp<CR>
nnoremap <silent> <Leader>g :BufferPick<CR>
nnoremap <silent> <Leader>G :BufferPickDelete<CR>

tnoremap jk <C-\><C-n>

nnoremap :hs :split<CR> <C-w>j
nnoremap :vs :vsplit<CR> <C-w>l
"
" Set PowerShell as the default terminal
if has('win32') || has('win64')
  let &shell = 'powershell'
  let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
  let &shellquote = ''
  let &shellxquote = ''
  set shellpipe=2>&1\|\ Out-File\ -Encoding\ UTF8
  set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif

"Indent guides setup

lua << EOF
require('Comment').setup()

require("scope").setup({})

local highlight = {
    "Grey",
}

require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })
require("telescope").load_extension("scope")

local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

require('toggleterm').setup {
    size = 25,
    open_mapping = [[<leader>y]],
    direction = 'float',
    insert_mappings = false,
    direction = 'float',
    start_in_insert = true,
    persist_mode = true,
    shade_terminals = false
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
        ['<c-d>'] = require('telescope.actions').delete_buffer
      },
      n = {
    	['<c-d>'] = require('telescope.actions').delete_buffer
      } -- n
    }
  }
}

require('mini.indentscope').setup {
    draw = {
        delay = 5,
        animation = require('mini.indentscope').gen_animation.quadratic({ easing = 'out', duration = 100, unit = 'total' }),
    },
    options = {
        try_as_border = true,
    }
}

require('mini.cursorword').setup()

require('kanagawa').setup({
    colors = {
        palette = {
            -- change all usages of these colors
        },
        theme = {
            -- change specific usages for a certain theme, or for all of them
            wave = {
                ui = {
                    float = {
                        bg = "none",
                    },
                },
            },
            dragon = {
                syn = {
                    parameter = "yellow",
                },
            },
            all = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    },
})

vim.lsp.set_log_level("debug")

vim.lsp.start({
  name = 'c-server',
  cmd = {'clangd'},
  root_dir = vim.fs.dirname(vim.fs.find({'.gitignore','setup.py', 'pyproject.toml'}, { upward = true })[1]),
})

vim.lsp.enable('c-server')

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
    -- Do not display location errors
    if result and result.diagnostics then
        for _, diagnostic in ipairs(result.diagnostics) do
            if diagnostic.severity == 2 then -- Error severity level
                diagnostic.message = ""
            end
        end
    end
    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end


EOF

