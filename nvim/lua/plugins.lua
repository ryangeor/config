local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
use 'wbthomason/packer.nvim'
use 'wbthomason/packer.nvim'
use 'rstacruz/vim-closer'
use 'voldikss/vim-floaterm'
use 'rose-pine/neovim'
use 'tpope/vim-surround'
use 'tpope/vim-fugitive'
use 'rust-lang/rust.vim'

use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'neovim/nvim-lspconfig'
use 'simrat39/rust-tools.nvim'
use("hrsh7th/nvim-cmp")
use({
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  after = { "hrsh7th/nvim-cmp" },
  requires = { "hrsh7th/nvim-cmp" },
})
use('hrsh7th/vim-vsnip')
use 'ojroques/nvim-osc52'
  if packer_bootstrap then
    require('packer').sync()
  end
end)

