-- Set lazy installation path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check to see if lazy itself has been cloned, if not clone it into the lazy.nvim directory
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- Add the path to the lazy plugin repositories to the vim runtime path
vim.opt.rtp:prepend(lazypath)

-- This has to be set before initializing lazy
-- Alternatively we can setup lazy _after_ loading the keymap but then all plugin configs will need to be in different place
-- TODO::Visit later
vim.g.mapleader = " "

-- Declare a few options for lazy
local opts = {
	change_detection = {
		-- Don't notify us every time a change is made to the configuration
		notify = false,
	},
	checker = {
		-- Automatically check for package updates
		enabled = true,
		-- Don't spam us with notification every time there is an update available
		notify = false,
	},
}

require("lazy").setup("plugins", opts)

require("core.options") -- all options go to lua/core/options.lua
require("core.keymaps") -- global keymaps go to lua/core/keymaps.lua

