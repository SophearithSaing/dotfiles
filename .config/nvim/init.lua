vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basics
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true

require("lazy").setup({
  -- Syntax highlighting
  {
	  "nvim-treesitter/nvim-treesitter",
	  branch = "master",
	  build = ":TSUpdate",
	  config = function()
		  require("nvim-treesitter.configs").setup({
			  ensure_installed = { "go", "gomod", "gowork", "gosum", "lua" },
			  highlight = { enable = true },
		  })
	  end,
  },
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("gopls", {
		  capabilities = capabilities,
	  })

	  vim.lsp.enable("gopls")
    end,
  },

  -- Completion
  {
	  "hrsh7th/nvim-cmp",
	  dependencies = {
		  "hrsh7th/cmp-nvim-lsp",
		  "hrsh7th/cmp-buffer",
		  "L3MON4D3/LuaSnip",
	  },
	  config = function()
		  local cmp = require("cmp")

		  cmp.setup({
			  completion = {
				  autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
			  },

			  snippet = {
				  expand = function(args)
					  require("luasnip").lsp_expand(args.body)
				  end,
			  },

			  mapping = cmp.mapping.preset.insert({
				  ["<C-Space>"] = cmp.mapping.complete(),
				  ["<CR>"] = cmp.mapping.confirm({ select = true }),
				  ["<Tab>"] = cmp.mapping.select_next_item(),
				  ["<S-Tab>"] = cmp.mapping.select_prev_item(),
			  }),

			  sources = {
				  { name = "nvim_lsp" },
				  { name = "buffer" },
			  },
		  })
	  end,
  },

  -- Statusline: shows git branch
  {
	  "nvim-lualine/lualine.nvim",
	  dependencies = {
		  "nvim-tree/nvim-web-devicons",
	  },
	  config = function()
		  require("lualine").setup({
			  options = {
				  theme = "auto",
				  globalstatus = true,
			  },
			  sections = {
				  lualine_b = { "branch", "diff", "diagnostics" },
			  },
		  })
	  end,
  },

  -- Quick search / fuzzy finder
  {
	  "nvim-telescope/telescope.nvim",
	  dependencies = {
		  "nvim-lua/plenary.nvim",
	  },
	  config = function()
		  local builtin = require("telescope.builtin")

		  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search text" })
		  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
	  end,
  }, 

  -- Theme
  {
	  "Mofiqul/vscode.nvim",
	  priority = 1000,
	  config = function()
		  require("vscode").setup({
			  transparent = true,
		  })

		  vim.cmd.colorscheme("vscode")
	  end,
  },
})

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Diagnostics: show LSP errors/warnings and navigate between them
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line error" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "File diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
