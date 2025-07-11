-- package management
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- packages
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "petertriho/nvim-scrollbar", name = "scrollbar", priority = 900 },
  { "ojroques/nvim-hardline", name = "hardline", priority = 900 },
  { "nvim-telescope/telescope.nvim", name = "telescope", dependencies = { "nvim-lua/plenary.nvim" } },
  { "stevearc/oil.nvim", name = "oil", lazy = false },
  { "benomahony/oil-git.nvim", name = "oil-git", dependencies = { "stevearc/oil.nvim" } },
  { "lewis6991/gitsigns.nvim", name = "gitsigns" },
}
local opts = { }
require("lazy").setup(plugins, opts)

-- general editor settings
vim.opt.number = true
vim.opt.tabstop = 4

vim.opt.shortmess:append('I') -- disable startup message

-- theme
vim.o.termguicolors = true
vim.opt.background = "light"
require("catppuccin").setup {
  color_overrides = {
    all = {
      text = "#0b1118",
    },
    latte = {
      base = "#d3e8f3",
      mantle = "#b5daed",
      crust = "#96cfed",
      surface1 = "#2898d2"
    },
    frappe = {},
    macchiato = {},
    mocha = {},
  }
}
vim.cmd.colorscheme "catppuccin"
require('hardline').setup {
  theme = 'custom',
  custom_theme = {
    text = {gui = "#0b1118", cterm = "NONE", cterm16 = "NONE"},
    normal = {gui = "#96cfed", cterm = "NONE", cterm16 = "NONE"},
    insert = {gui = "#96cfed", cterm = "NONE", cterm16 = "NONE"},
    replace = {gui = "#96cfed", cterm = "NONE", cterm16 = "NONE"},
    inactive_comment = {gui = "#b5daed", cterm = "NONE", cterm16 = "NONE"},
    inactive_cursor = {gui = "#b5daed", cterm = "NONE", cterm16 = "NONE"},
    inactive_menu = {gui = "#b5daed", cterm = "NONE", cterm16 = "NONE"},
    visual = {gui = "#96cfed", cterm = "NONE", cterm16 = "NONE"},
    command = {gui = "#96cfed", cterm = "NONE", cterm16 = "NONE"},
    alt_text = {gui = "#0b1118", cterm = "NONE", cterm16 = "NONE"},
    warning = {gui = "#96cfed", cterm = "NONE", cterm16 = "NONE"},
  }
}
require("scrollbar").setup({
  marks = {
    Cursor = {
      text = "|",
      color = "#96cfed"
    }
  }
})

-- utilities
require('telescope').setup()
require('oil').setup({
  view_options = {
    show_hidden = true
  }
})
require("oil-git").setup({
  highlights = {
    OilGitAdded = { fg = "#40a02b" },     -- green
    OilGitModified = { fg = "#df8e1d" },  -- yellow
    OilGitDeleted = { fg = "#d20f39" },   -- red
    OilGitRenamed = { fg = "#8839ef" },   -- purple
    OilGitUntracked = { fg = "#1e66f5" }, -- blue
    OilGitIgnored = { fg = "#6c6f85" },   -- gray
  }
})
require("gitsigns").setup()
