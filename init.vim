" source C:\Users\lucas\AppData\local\nvim\config_files\coc_c++_config.vim

let config_path = expand('<sfile>:p:h') . '/config_files/coc_c++_config.vim'
execute 'source' config_path


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
set tabstop=8               " number of columns occupied by a tab 
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


" " Get Autocomplete working properly
 inoremap! <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ coc#expandableOrJumpable() ?
\ "\<C-r>=coc#snippet#next()\<Cr>":
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap! <silent><expr> <S-Tab>
\ pumvisible() ? "\<C-p>" :
\ coc#expandableOrJumpable() ?
\ "\<C-r>=coc#snippet#prev()\<Cr>":
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1] =~# '\s'
endfunction
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>' 


inoremap <silent> <C-k> coc#refresh()

"COC Notes
"Ctrl N and Ctrl P to choose autocomplete
"Ctrl Y to select the first one
"Select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"

call plug#begin()

    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'loctvl842/monokai-pro.nvim'
    Plug 'mswift42/vim-themes'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
    Plug 'jakemason/ouroboros'

    Plug 'nvim/nvim-lspconfig'

    Plug 'lukas-reineke/indent-blankline.nvim'
    
    "Plug 'lukas-reineke/indent-blankline.nvim'   

    " Utilities
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

    Plug 'sheerun/vim-polyglot'
    " Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'plasticboy/vim-markdown'

    Plug 'numToStr/Comment.nvim'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

" colorscheme monokai-pro-spectrum
" colorscheme true-monochrome
" colorscheme true-true-monochrome
" colorscheme darktooth
colorscheme munich 
" colorscheme menguless 

" let b:coc_diagnostic_disable=1

"let blacklist = ['vim', 'help']
"autocmd CursorHold * if (index(blacklist, &ft) < 0 || !coc#rpc#ready()) | silent! call CocActionAsync('doHover')

nnoremap <silent> <leader>k :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

let g:airline_powerline_fonts = 1
" let g:airline_theme = "violet"
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
nnoremap <silent> <Leader>Y :ToggleTermToggleAll<CR>

tnoremap jk <C-\><C-n>

"nnoremap <A-o> :Ouroboros<CR>
nnoremap <silent> <A-o> :CocCommand clangd.switchSourceHeader<CR>

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

local highlight = {
    "Grey",
}

-- vim.api.nvim_set_hl(0, "Grey", { fg = "#2d555a" })
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Grey", { fg = "#555555" })
end)
require("ibl").setup { 
    indent = { highlight = highlight },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = true }
}

require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })

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
    start_in_insert = true,
    insert_mappings = false
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
      }
    }
  }
}

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

