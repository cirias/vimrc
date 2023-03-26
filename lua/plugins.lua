-- This file can be loaded by calling `lua require('plugins')` from your init.vim

function install_packer_if_not_exist()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/" .. "opt/packer.nvim"

  -- Auto-install packer in case it hasn't been installed.
  if fn.empty(fn.glob(install_path)) <= 0 then
    return
  end

  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, install_path)

  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

install_packer_if_not_exist()

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

local distant_on_attach = function()
  local opts = { noremap=true, silent=true }

  vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  use { 'neovim/nvim-lspconfig', config = function()
    require('lsp')
  end}

  use 'nvim-lua/plenary.nvim'

  use { 'nvim-telescope/telescope.nvim', config = function()
    vim.api.nvim_set_keymap('n', '<Leader>ff', '<CMD>lua require(\'telescope.builtin\').find_files()<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>fg', '<CMD>lua require(\'telescope.builtin\').live_grep()<CR>', { noremap = true })
  end}

  use { 'nvim-treesitter/nvim-treesitter', disable = true, run = ':TSUpdate', config = function()
    require('treesitter')
  end}

  use { 'scrooloose/nerdcommenter', config = function()
    vim.g.NERDSpaceDelims = 1
  end}

  use 'altercation/vim-colors-solarized'
  use 'jiangmiao/auto-pairs'
  -- use 'kana/vim-textobj-indent'
  -- use 'kana/vim-textobj-user'
  use 'tpope/vim-abolish'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'vim-scripts/ReplaceWithRegister'

  use {
    'prettier/vim-prettier',
    run = 'npm install',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' },
    config = function()
      vim.g['prettier#autoformat'] = 0

      vim.g['prettier#config#print_width' ]= 110
      vim.g['prettier#config#bracket_spacing'] = 'true'
      vim.g['prettier#config#trailing_comma'] = 'es5'

      vim.cmd([[
augroup for_prettier
  autocmd!
  autocmd BufWritePre *.json,*.js,*.jsx,*.ts,*.tsx Prettier
augroup END
      ]])
    end
  }
end)
