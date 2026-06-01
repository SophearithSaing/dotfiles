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
})
