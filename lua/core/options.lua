-- Reference: https://neovim.io/doc/user/options.html

local opt = vim.opt

-- Line Numbers
opt.number = true -- line number
opt.relativenumber = true -- line numbers relative to the current line (helps in yank etc)

-- Left Gutter
opt.numberwidth = 4 -- gutter for showing line numbers (default)
opt.signcolumn = "yes" -- always show sign column

-- Tab Key Behaviour
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
vim.bo.softtabstop = 4
opt.expandtab = true -- Press tab to fill with spaces as defined above

-- Indentation
opt.autoindent = true -- Automatic indent
opt.smartindent = true
opt.breakindent = true

-- Folding
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Utilize Treesitter folds

-- General Behaviors
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
opt.backup = false -- disable backup file creation
-- opt.clipboard:append("unnamedplus") -- enable system clipboard access
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- set file encoding to UTF-8
opt.mouse = "a" -- enable mouse support
opt.showmode = false -- hide mode display
opt.backspace = "indent,eol,start" -- This is default anyways but still

-- Split
-- opt.splitbelow = true -- force horizontal splits below current window
-- opt.splitright = true -- force vertical splits right of current window

-- Appearance
opt.termguicolors = true -- enable term GUI colors
opt.undofile = true -- enable persistent undo
opt.updatetime = 100 -- set faster completion
opt.writebackup = false -- prevent editing of files being edited elsewhere

-- Cursor
opt.cursorline = true -- highlight current line
opt.scrolloff = 10 -- number of lines to keep above/below cursor
opt.sidescrolloff = 8 -- number of columns to keep to the left/right of cursor

-- Search
opt.hlsearch = true -- highlight all matches in search
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- match case if explicitly stated

-- Diagnostics display
vim.diagnostic.config {
    float = { border = "rounded" }, -- add border to diagnostic popups
    -- virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
}

