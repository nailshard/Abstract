
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ───────────────────────────────────────────────── --
--    Plugin:    packer.nvim
--    Github:    github.com/wbthomason/packer.nvim
-- ───────────────────────────────────────────────── --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --





-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--              NOTE:1
-- If you want to automatically ensure that packer.nvim is installed on any machine you clone your configuration to,
-- add the following snippet (which is due to @Iron-E) somewhere in your config before your first usage of packer:
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path
	})
end

-- safely import packer
local ok, packer = pcall(require, "packer")
if not ok then return end

local commits = require("plugins.commits")


return packer.startup {

	config = {
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',

		display = {
			open_fn = function()
				return require('packer.util').float({border = 'single'})
			end
		}
	},


	function()

		use { -- Packer can manage itself
			'wbthomason/packer.nvim',
			commit = commits.packer_nvim,
		}

		use {
			'rmagatti/alternate-toggler'
		}
		-- Improve Start-UP time
		use { -- Speed up loading Lua modules in Neovim to improve startup time.
			'lewis6991/impatient.nvim',
			commit = commits.impatient_nvim,
		}

		use { -- Easily speed up your neovim startup time!. A faster version of filetype.vim
			'nathom/filetype.nvim',
			commit = commits.filetype_nvim,
		}

		use { -- colorscheme for (neo)vim written in lua specially made for Abstract
			'nailshard/Abstract-cs',
			-- commit = commits.Abstract_cs,
			branch = 'v2',
		}

		use 'bluz71/vim-moonfly-colors'

		use { -- A collection of common configurations for Neovim's built-in language server client
			'neovim/nvim-lspconfig',
			commit = commits.nvim_lspconfig,
			requires = {
				{ -- Companion plugin for nvim-lspconfig that allows you to seamlessly install LSP servers locally (inside :echo stdpath("data")).
					'williamboman/mason.nvim',
					--[[ branch = "alpha", ]]
					requires = {
						'williamboman/mason-lspconfig.nvim',
					},
				}
			},
			config = [[ require('plugins/nvim-lspconfig') ]]
		}

		use { -- vscode-like pictograms for neovim lsp completion items Topics
			'onsails/lspkind-nvim',
			commit = commits.lspkind_nvim,
			config = [[ require('plugins/lspkind-nvim') ]]
		}

		use { -- Standalone UI for nvim-lsp progress
			'j-hui/fidget.nvim',
			config = [[ require('plugins/fidget_nivm') ]]
		}

		use { -- Nvim Treesitter configurations and abstraction layer
			'nvim-treesitter/nvim-treesitter',
			commit = commits.nvim_treesitter,
			run = ':TSUpdate',
			requires = {'nvim-treesitter/playground', commit=commits.playground, opt = true},  -- Treesitter playground integrated into Neovim
			config = [[ require('plugins/nvim-treesitter') ]]
		}

		use { -- A completion plugin for neovim coded in Lua.
			'hrsh7th/nvim-cmp',
			commit = commits.nvim_cmp,
			requires = {
				{ -- Snippet Engine for Neovim written in Lua.
					'L3MON4D3/LuaSnip',
					commit = commits.LuaSnip,
					requires = {"rafamadriz/friendly-snippets", commit=commits.friendly_snippets},  -- Snippets collection for a set of different programming languages for faster development.
				},
				{"hrsh7th/cmp-nvim-lsp", commit=commits.cmp_nvim_lsp},   -- nvim-cmp source for neovim builtin LSP client
				{"hrsh7th/cmp-buffer", commit=commits.cmp_buffer},       -- nvim-cmp source for buffer words.
				{"hrsh7th/cmp-path", commit=commits.cmp_path},           -- nvim-cmp source for filesystem paths.
				{"saadparwaiz1/cmp_luasnip", commit=commits.cmp_luasnip},-- luasnip completion source for nvim-cmp
				{"hrsh7th/cmp-nvim-lsp-signature-help", commit=commits.cmp_nvim_lsp_signature_help}, -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
				{"hrsh7th/cmp-nvim-lua", ft = 'lua', commit=commits.cmp_nvim_lua}, -- nvim-cmp source for nvim lua
			},
			config = [[
				require('plugins/nvim-cmp')
				require('plugins/LuaSnip')
			]]
		}

		use { -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
			'jose-elias-alvarez/null-ls.nvim',
			commit = commits.null_ls_nvim,
			config = [[ require('plugins/null-ls_nvim') ]]
		}

		use { -- A super powerful autopairs for Neovim. It support multiple character.
			'windwp/nvim-autopairs',
			commit = commits.nvim_autopairs,
			config = [[ require('plugins/nvim-autopairs') ]]
		}

		use { --  Add/change/delete surrounding delimiter pairs with ease.
			'kylechui/nvim-surround',
			commit = commits.nvim_surround,
			config = [[ require('plugins/nvim-surround') ]]
		}

		use { -- Find, Filter, Preview, Pick. All lua, all the time.
			'nvim-telescope/telescope.nvim',
			commit = commits.telescope_nvim,
			requires = {
				{'nvim-lua/popup.nvim', commit=commits.popup_nvim},
				{'nvim-lua/plenary.nvim', commit=commits.plenary_nvim},
				{'nvim-telescope/telescope-fzf-native.nvim', commit=commits.telescope_fzf_native_nvim, run = 'make'}, -- FZF sorter for telescope written in c
				{'nvim-telescope/telescope-file-browser.nvim', commit=commits.telescope_file_browser_nvim}, -- File Browser extension for telescope.nvim
				{'nvim-telescope/telescope-media-files.nvim', commit=commits.telescope_media_files_nvim}, -- Telescope extension to preview media files using Ueberzug.
				{'nvim-telescope/telescope-ui-select.nvim', commit=commits.telescope_ui_select_nvim}, -- It sets vim.ui.select to telescope.
			},
			config = [[ require('plugins/telescope_nvim') ]]
		}

		use { -- Use (neo)vim terminal in the floating/popup window.
			'voldikss/vim-floaterm',
			commit = commits.vim_floaterm,
			config = [[ require('plugins/vim-floaterm') ]]
		}

		use { -- lua `fork` of vim-web-devicons for neovim
			'kyazdani42/nvim-web-devicons',
			commit = commits.nvim_web_devicons,
			config = [[ require('plugins/nvim-web-devicons') ]]
		}

		use { -- Maximizes and restores the current window in Vim
			'szw/vim-maximizer',
			commit = commits.vim_maximizer,
			config = [[ require('plugins/vim-maximizer') ]]
		}

		use { -- Smart and powerful comment plugin for neovim. Supports commentstring, dot repeat, left-right/up-down motions, hooks, and more
			'numToStr/Comment.nvim',
			commit = commits.Comment_nvim,
			config = [[ require('plugins/Comment_nvim') ]]
		}

		use {
			'JoosepAlviste/nvim-ts-context-commentstring', --  Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
			commit = commits.nvim_ts_context_commentstring,
			config = [[ require('plugins/nvim-ts-context-commentstring') ]]
		}

		use { -- The fastest Neovim colorizer.
			'norcalli/nvim-colorizer.lua',
			commit = commits.nvim_colorizer_lua,
			config = [[ require('plugins/nvim-colorizer_lua') ]]
		}

		use { --  Indent guides for Neovim
			'lukas-reineke/indent-blankline.nvim',
			commit = commits.indent_blankline_nvim,
			config = [[ require('plugins/indent-blankline_nvim') ]]
		}

		use { -- Git signs written in pure lua
			'lewis6991/gitsigns.nvim',
			commit = commits.gitsigns_nvim,
			requires = {'nvim-lua/plenary.nvim', commit=commits.plenary_nvim},
			config = [[ require('plugins/gitsigns_nvim') ]]
		}

		use { -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
			'folke/trouble.nvim',
			commit = commits.trouble_nvim,
			config = [[ require('plugins/trouble_nvim') ]]
		}

		use { -- A snazzy bufferline for Neovim
			'akinsho/nvim-bufferline.lua',
			commit = commits.nvim_bufferline_lua,
			requires = {'kyazdani42/nvim-web-devicons', commit=commits.nvim_web_devicons},
			config = [[ require('plugins/nvim-bufferline_lua') ]]
		}

		use { -- A File Explorer For Neovim Written In Lua
			'kyazdani42/nvim-tree.lua',
			commit = commits.nvim_tree_lua,
			config = [[ require('plugins/nvim-tree_lua') ]]
		}

		use { -- A minimal, stylish and customizable statusline for Neovim written in Lua
			'feline-nvim/feline.nvim',
			commit = commits.feline_nvim,
			-- requires = {
			--   'nvim-lua/lsp-status.nvim',
			-- },
			config = [[ require('plugins/feline_nvim') ]]
		}

		use { -- fast and highly customizable greeter for neovim.
			"goolord/alpha-nvim",
			commit = commits.alpha_nvim,
			requires = {'kyazdani42/nvim-web-devicons', commit=commits.nvim_web_devicons},
			config = [[ require('plugins/alpha-nvim') ]]
		}

		use { --  smart indent and project detector with project based config loader
			'Abstract-IDE/penvim',
			commit = commits.penvim,
			config = [[ require('plugins/penvim') ]]
		}

		use { -- preview native LSP's goto definition calls in floating windows.
			'rmagatti/goto-preview',
			commit = commits.goto_preview,
			config = [[ require('plugins/goto-preview') ]]
		}

		use { --  A simple wrapper around :mksession
			'Shatur/neovim-session-manager',
			commit = commits.neovim_session_manager,
			config = [[ require('plugins/neovim-session-manager') ]]
		}

		use { -- VS Code-like renaming UI for Neovim, writen in Lua.
			'filipdutescu/renamer.nvim',
			commit = commits.renamer_nvim,
			branch = 'master',
			requires = {'nvim-lua/plenary.nvim', commit=commits.plenary_nvim},
			config = [[ require('plugins/renamer_nvim') ]]
		}

		use { -- EditorConfig plugin for Neovim
			'gpanders/editorconfig.nvim',
			commit = commits.editorconfig_nvim,
		}

		use { --  Neovim motions on speed!
			'phaazon/hop.nvim',
			commit = commits.hop_nvim,
			config = [[ require('plugins/hop_nvim') ]]
		}

		-- ━━━━━━━━━━━━━━━━━❰ DEVELOPMENT ❱━━━━━━━━━━━━━━━━━ --

		----           for flutter/dart
		use { -- Tools to help create flutter apps in neovim using the native lsp
			'akinsho/flutter-tools.nvim',
			commit = commits.flutter_tools_nvim,
			ft = {'dart'},
			requires = {
				{'nvim-lua/plenary.nvim', commit=commits.plenary_nvim},
				{'Neevash/awesome-flutter-snippets', commit=commits.awesome_flutter_snippets}, -- collection snippets and shortcuts for commonly used Flutter functions and classes
				{
					'dart-lang/dart-vim-plugin', -- Syntax highlighting for Dart in Vim
					commit = commits.dart_vim_plugin,
					config = [[ require('plugins/dart-vim-plugin') ]]
				}
			},
			config = [[ require('plugins/flutter-tools_nvim') ]]
		}

		--            for Web-Development
		use { --  Use treesitter to auto close and auto rename html tag, work with html,tsx,vue,svelte,php.
			"windwp/nvim-ts-autotag",
			commit = commits.nvim_ts_autotag,
			ft = {'html', 'tsx', 'vue', 'svelte', 'php'},
			requires = {'nvim-treesitter/nvim-treesitter', commit=commits.nvim_treesitter},

			config = [[ require('plugins/nvim-ts-autotag') ]]
		}


		use({
			"mcauley-penney/tidy.nvim",
			config = function()
				require("tidy").setup()
			end
		})

		use {
			'AckslD/nvim-revJ.lua',
			requires = {'kana/vim-textobj-user', 'sgur/vim-textobj-parameter'},
			config = function()
				require("revj").setup{
					brackets = {first = '([{<', last = ')]}>'}, -- brackets to consider surrounding arguments
					new_line_before_last_bracket = true, -- add new line between last argument and last bracket (only if no last seperator)
					add_seperator_for_last_parameter = true, -- if a seperator should be added if not present after last parameter
					enable_default_keymaps = false, -- enables default keymaps without having to set them below
					keymaps = {
						operator = '<Leader>J', -- for operator (+motion)
						line = '<Leader>j', -- for formatting current line
						visual = '<Leader>j', -- for formatting visual selection
					},
					parameter_mapping = ',', -- specifies what text object selects an arguments (ie a, and i, by default)
					-- if you're using `vim-textobj-parameter` you can also set this to `vim.g.vim_textobj_parameter_mapping`
				}
			end
			-- or
			-- requires = {'wellle/targets.vim'},
			-- or ...
		}

		use {
			'yamatsum/nvim-cursorline',
			config = function()
				require('nvim-cursorline').setup {
					cursorline = {
						enable = true,
						timeout = 1000,
						number = false,
					},
					cursorword = {
						enable = true,
						min_length = 3,
						hl = { underline = true },
					}
				}
			end
		}
		use {
			's1n7ax/nvim-comment-frame',
			requires = {
				{ 'nvim-treesitter' }
			},
			config = function()
				require('nvim-comment-frame').setup()
			end
		}
		-- use {
		-- 	'nmac427/guess-indent.nvim',
		-- 	config = function() require('guess-indent').setup {} end,
		-- }
		-- ━━━━━━━━━━━━━━❰ end of DEVELOPMENT ❱━━━━━━━━━━━━━ --
use {
  'chipsenkbeil/distant.nvim',
  config = function()
    require('distant').setup {
      -- Applies Chip's personal settings to every machine you connect to
      --
      -- 1. Ensures that distant servers terminate with no connections
      -- 2. Provides navigation bindings for remote directories
      -- 3. Provides keybinding to jump into a remote file's parent directory
      ['*'] = require('distant.settings').chip_default()
    }
  end
}

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if Packer_bootstrap then
			packer.sync()
		end
	end
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
