require("config.lazy")

vim.opt.termguicolors = true
--vim.opt.t_Co = 256
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.wildmode = { "longest", "list" }
vim.opt.colorcolumn = ""
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ttyfast = true
vim.opt.cmdheight = 1
vim.opt.signcolumn = "no"
vim.opt.showmode = false
vim.cmd("syntax on")
vim.cmd("filetype plugin on")

require("lazy").setup({
  spec = {
   -- import your plugins
   { import = "plugins" },

  -- Appearance
  { "vim-airline/vim-airline" },
  { "vim-airline/vim-airline-themes" },
  { "loctvl842/monokai-pro.nvim" },
  { "mswift42/vim-themes" },
  { "vague2k/vague.nvim" },
  { "rebelot/kanagawa.nvim" },

  -- Telescope & dependencies
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.6" },
  { "tiagovla/scope.nvim" },

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- Mini.nvim plugin collection
  { "echasnovski/mini.nvim" },

  -- Terminal toggle
  { "akinsho/toggleterm.nvim", version = "*" },

  -- Syntax and language packs
  { "sheerun/vim-polyglot" },
  { "preservim/nerdtree" },
  { "plasticboy/vim-markdown" },

  -- Comments
  { "numToStr/Comment.nvim" },

  -- FZF integration
  {
    "junegunn/fzf",
    build = function() vim.fn["fzf#install"]() end,
  },
  { "junegunn/fzf.vim" },

  -- Optional plugins (commented in your original vim-plug setup)
  -- { "folke/snacks.nvim" },
  -- { "mikavilpas/yazi.nvim" },
  -- { "lukas-reineke/indent-blankline.nvim" },
  -- { "jiangmiao/auto-pairs" },
  -- { "neoclide/coc.nvim", branch = "release" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
  sync = true,
})

require("lazy").setup("plugins")

vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<F8>", ":NERDTreeToggle<CR>", opts)
map("n", "<Leader><Leader>", ":w<CR>", opts)
map("n", "<Leader>j", ":Ex<CR>", opts)
map("n", "<Leader>J", ":Vex<CR>", opts)

map("n", "<Leader>h", ":bp<CR>", opts)
map("n", "<Leader>l", ":bn<CR>", opts)


local actions = require('telescope.actions')
local telescope = require('telescope.builtin')
map("n", "gd", ":Telescope lsp_definitions<CR>", opts)
map("n", "gr", ":Telescope lsp_references<CR>", opts)
map("n", "<Leader>f", ":Telescope find_files<CR>", opts)
map("n", "<Leader>b", ":Telescope buffers<CR>", opts)
map("n", "<Leader>B", ":Telescope scope buffers<CR>", opts)
map("n", "<Leader>r", ":Telescope live_grep<CR>", opts)
map("n", "<Leader>m", ":Telescope marks<CR>", opts)
map("n", "<Leader>o", ":Telescope lsp_document_symbols<CR>", opts)

map("n", "<Leader>/", ":noh<CR>", opts)
map("n", "<Leader>Y", ":ToggleTermToggleAll<CR>", opts)
map("n", "<Leader>t", ":tabn<CR>", opts)
map("n", "<Leader>T", ":tabp<CR>", opts)

map("n", ":hs", ":split<CR><C-w>j", opts)
map("n", ":vs", ":vsplit<CR><C-w>l", opts)

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  vim.opt.shell = 'powershell'
  vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8'
  vim.opt.shellredir = '| Out-File -Encoding UTF8'
end

require("Comment").setup()
require("lazy").setup("plugins.lsp")

require("scope").setup()
require("telescope").load_extension("scope")

require("toggleterm").setup({
  size = 25,
  open_mapping = [[<leader>y]],
  direction = 'float',
  insert_mappings = false,
  start_in_insert = true,
  persist_mode = true,
  shade_terminals = false,
})

-- Telescope with multi-select edit
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = function(bufnr)
          local picker = action_state.get_current_picker(bufnr)
          local multi = picker:get_multi_selection()
          if not vim.tbl_isempty(multi) then
            actions.close(bufnr)
            for _, entry in ipairs(multi) do
              if entry.path then
                vim.cmd("edit " .. entry.path)
              end
            end
          else
            actions.select_default(bufnr)
          end
        end,
        ["<C-d>"] = actions.delete_buffer,
      },
      n = {
        ["<C-d>"] = actions.delete_buffer,
      },
    },
  },
})

require("mini.cursorword").setup()
require("mini.indentscope").setup({
  draw = {
    delay = 5,
    animation = require("mini.indentscope").gen_animation.quadratic({
      easing = "out", duration = 100, unit = "total"
    }),
  },
  options = { try_as_border = true },
})

require("kanagawa").setup({
  colors = {
    theme = {
      -- dragon = {
      --   syn = { parameter = "yellow" },
      -- },
      all = {
        ui = { bg_gutter = "none" },
      },
    },
  },
})

vim.cmd.colorscheme("kanagawa-dragon")
local lspconfig = require('lspconfig')
--
local function switch_source_header(bufnr)
  local method_name = 'textDocument/switchSourceHeader'
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
  if not client then
    return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  client.request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify('corresponding file cannot be determined')
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end
local function symbol_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
  if not clangd_client or not clangd_client.supports_method 'textDocument/symbolInfo' then
    return vim.notify('Clangd client not found', vim.log.levels.ERROR)
  end
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
  clangd_client.request('textDocument/symbolInfo', params, function(err, res)
    if err or #res == 0 then
      -- Clangd always returns an error, there is not reason to parse it
      return
    end
    local container = string.format('container: %s', res[1].containerName) ---@type string
    local name = string.format('name: %s', res[1].name) ---@type string
    vim.lsp.util.open_floating_preview({ name, container }, '', {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      border = 'single',
      title = 'Symbol Info',
    })
  end, bufnr)
end

lspconfig.clangd.setup( {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_dir = vim.fs.dirname(vim.fs.find({'.gitignore', 'compile_commands.json', 'setup.py', 'pyproject.toml'}, { upward = true })[1]),
  capabilities = require("cmp_nvim_lsp").default_capabilities(),

  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    vim.api.nvim_buf_create_user_command(0, 'LspClangdSwitchSourceHeader', function()
      switch_source_header(0)
    end, { desc = 'Switch between source/header' })
  --
    vim.keymap.set('n', '<A-o>', function()
      vim.cmd('LspClangdSwitchSourceHeader')
    end, { buffer = bufnr, desc = 'Switch between source/header' })

    vim.api.nvim_buf_create_user_command(0, 'LspClangdShowSymbolInfo', function()
      symbol_info()
    end, { desc = 'Show symbol info' })

    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Go to references' })
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Show hover' })

  end,
  })

-- Suppress certain diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
  if result and result.diagnostics then
    for _, d in ipairs(result.diagnostics) do
      if d.severity == vim.diagnostic.severity.ERROR then
        d.message = ""
      end
    end
  end
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

vim.diagnostic.config({
  underline = false,  
})

vim.g.airline_theme = "base16_black_metal_dark_funeral"
vim.g.airline_powerline_fonts = 0
vim.g.airline_extensions_tabline_enabled = 0
vim.g.airline_extensions_whitespace_enabled = 0
vim.g['airline#extensions#nvimlsp#enabled'] = 0
vim.g.airline_extensions_coc_enabled = 0         -- if you ever used coc.nvim
vim.g.airline_extensions_languageclient_enabled = 0  -- for languageclient-neovim
vim.g['airline#extensions#diagnostics#enabled'] = 0
vim.g['airline#extensions#airline#theme'] = 'default'

