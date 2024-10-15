require('plugins')

vim.o.clipboard = 'unnamed,unnamedplus'

-- hightlight search
vim.o.hlsearch = true
vim.o.incsearch = true

-- hybrid line number
vim.o.number = true
vim.o.relativenumber = true

-- highlight cursor line
vim.o.cursorline = true 

-- indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Write to file directly when ':w', not to create a new file and remove the old
-- one. Otherwise it will cause file watcher problem.
vim.o.backupcopy = 'yes'

-- syntax highlight
vim.cmd([[syntax on]])

-- colorful
-- require('solarized').set()
vim.cmd([[colorscheme solarized]])
vim.g.solarized_termcolors = 256
vim.o.background = 'light'


-- Key Bindings

local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.g.mapleader = ','

-- edit .vimrc.local quickly
-- vim.api.nvim_set_keymap('n', '<Leader>ev', ':vsplit ~/github.com/cirias/vimrc/.vimrc<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ev', ':vsplit ~/.config/nvim/init.lua<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ep', ':vsplit ~/.config/nvim/lua/plugins.lua<CR>', { noremap = true })

-- load .vimrc quickly
vim.api.nvim_set_keymap('n', '<Leader>sv', ':source $MYVIMRC<CR>', { noremap = true })

-- Mute Highlighting
vim.api.nvim_set_keymap('n', '<C-l>', ':'..t'<C-u>'..'nohlsearch<CR>'..t'<C-l>', { noremap = true, silent = true })

-- Move line
vim.api.nvim_set_keymap('n', '-', 'ddp', { noremap = true })
vim.api.nvim_set_keymap('n', '_',  'ddkP', { noremap = true })

-- git grep
vim.api.nvim_set_keymap('n', '<Leader>g', ':Ggrep ', { noremap = true })

-- Select word
vim.api.nvim_set_keymap('n', '<space>', 'viw', { noremap = true })
vim.api.nvim_set_keymap('v', '<space>', t'<esc>', { noremap = true })

-- Exit insert mode quickly
vim.api.nvim_set_keymap('i', 'jk', t'<esc>', { noremap = true })

-- Uppercase
vim.api.nvim_set_keymap('i', '<C-u>', t'<esc>'..'viwUea', { noremap = true })

-- Substitute the word under the cursor
vim.api.nvim_set_keymap('n', '<Leader>*', ':%s/\\<'..t'<C-r>'..t'<C-w>'..'\\>/', { noremap = true })
