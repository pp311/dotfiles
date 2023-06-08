-- general
lvim.log.level = "info"
lvim.lsp.code_lens_refresh = 1000
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>" --Save

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.format_on_save = true
lvim.colorscheme = "catppuccin-mocha"
-- lvim.transparent_window = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.builtin.lualine.options.component_separators = { left = '', right = '', }
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- lvim.lsp.installer.setup.ensure_installed = {"csharp-language-server"}
-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
vim.cmd [[
    augroup remember_folds
    autocmd!
    au BufWinLeave, BufLeave ?* silent! mkview | filetype detect
    au BufWinEnter, BufEnter ?* silent! loadview | filetype detect
    augroup END
]]

lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        flavor = "mocha",
        integrations = {
          nvimtree = true,
        },
        highlight_overrides = {
          mocha = function(mocha)
            return {
              NvimTreeNormal = { bg = mocha.none },
            }
          end,
        },
      })
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-w>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-;>",
            prev = "<C-'>",
            dismiss = "<C-]>",
          },
        },
      })
    end
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
      require("leap").setup({
        max_phase_one_targets = nil,
        highlight_unlabeled_phase_one_targets = true,
        max_highlighted_traversal_targets = 10,
        case_sensitive = true,
        special_keys = {
          repeat_search = '<enter>',
          next_phase_one_target = '<enter>',
          next_target = { '<enter>', ';' },
          prev_target = { '<tab>', ',' },
          next_group = '<space>',
          prev_group = '<tab>',
          multi_accept = '<enter>',
          multi_revert = '<backspace>',
        }
      })
    end
  },
}
lvim.builtin.lualine.on_config_done = function()
  local custom_auto = require('lualine.themes.auto')
  custom_auto.normal.c.bg = 'None'
  require('lualine').setup {
    options = {
      theme = custom_auto
    }
  }
end

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
--
-- vim.keymap.set('n', '<C-c>', '"+yi')
vim.keymap.set('v', '<C-c>', '"+yi')
-- vim.keymap.set('n', '<C-x>', '"+c')
vim.keymap.set('v', '<C-x>', '"+c')
-- vim.keymap.set('n', '<C-v>', 'c<ESC>"+p')
vim.keymap.set('v', '<C-v>', 'c<ESC>"+p')
vim.keymap.set('i', '<C-v>', '<C-r><C-o>+')

vim.cmd [[
  function ToggleWrap()
 if (&wrap == 1)
   set nowrap
 else
   set wrap
 endif
endfunction
  map <F9> :call ToggleWrap()<CR>
map! <F9> ^[:call ToggleWrap()<CR>
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.backup = false                        -- creates a backup file
vim.opt.clipboard = "unnamedplus"             -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2                         -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"                 -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                      -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                -- the encoding written to a file
vim.opt.foldmethod = "expr"                   -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr =
"nvim_treesitter#foldexpr()"                  -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "Liga SFMono Nerd Font:h12" -- the font used in graphical neovim applications
vim.opt.hidden = true                         -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                       -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                     -- ignore case in search patterns
vim.opt.mouse = "a"                           -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                        -- pop up menu height
vim.opt.showmode = false                      -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                       -- always show tabs
vim.opt.smartcase = true                      -- smart case
vim.opt.smartindent = true                    -- make indenting smarter again
vim.opt.splitbelow = true                     -- force all horizontal splits to go below current window
vim.opt.splitright = true                     -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                      -- creates a swapfile
vim.opt.termguicolors = true                  -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 100                      -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                          -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim"    -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                       -- enable persistent undo
vim.opt.updatetime = 300                      -- faster completion
vim.opt.writebackup = false                   -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                      -- convert tabs to spaces
vim.opt.shiftwidth = 2                        -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                           -- insert 2 spaces for a tab
vim.opt.cursorline = true                     -- highlight the current line
vim.opt.number = true                         -- set numbered lines
vim.opt.relativenumber = true                 -- set relative numbered lines
vim.opt.numberwidth = 4                       -- set number column width to 2 {default 4}
vim.opt.signcolumn =
"yes"                                         -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.foldenable = false

if vim.g.neovide then
  vim.opt.linespace = 0
  vim.g.neovide_no_idle = true
  vim.g.neovide_transparency = 0.85
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.g.neovide_cursor_vfx_opacity = 500.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 20.0
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
end

vim.cmd([[
augroup MyColors
autocmd!
autocmd ColorScheme * highlight LeapLabelPrimary guifg=#24273a guibg=#a6da95
" autocmd ColorScheme * highlight LeapBackdrop guifg=#6e738d
augroup end
]])

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Fix startup error by disabling semantic tokens for omnisharp",
  group = vim.api.nvim_create_augroup("OmnisharpHook", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.name == "omnisharp" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})


-- vim.cmd [[
--   function! IBusOff()
--     " Lưu engine hiện tại
--     let g:ibus_prev_engine = system('ibus engine')
--     " Chuyển sang engine tiếng Anh
--     execute 'silent !ibus engine xkb:us::eng'
--   endfunction
--   function! IBusOn()
--     let l:current_engine = system('ibus engine')
--     " nếu engine được set trong normal mode thì
--     " lúc vào insert mode duùn luôn engine đó
--     if l:current_engine !~? 'xkb:us::eng'
--       let g:ibus_prev_engine = l:current_engine
--     endif
--     " Khôi phục lại engine
--     execute 'silent !' . 'ibus engine ' . g:ibus_prev_engine
--   endfunction
--   augroup IBusHandler
--       autocmd CmdLineEnter [/?] call IBusOn()
--       autocmd CmdLineLeave [/?] call IBusOff()
--       autocmd InsertEnter * call IBusOn()
--       autocmd InsertLeave * call IBusOff()
--   augroup END
--   call IBusOff()
-- ]]
