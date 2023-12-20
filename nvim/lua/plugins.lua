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

-- duh
use 'wbthomason/packer.nvim'
use 'rstacruz/vim-closer'

-- terminal
use 'voldikss/vim-floaterm'

-- the teachings of the vimscript wizard
use 'tpope/vim-surround'
use 'tpope/vim-fugitive'

-- colors
use 'rose-pine/neovim'
use 'fynnfluegge/monet.nvim'

-- all the lsp/autocomplete-related stuff
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

-- paste over ssh
use 'ojroques/nvim-osc52'
use 'nvim-treesitter/nvim-treesitter'


-- finding shit
use {'nvim-telescope/telescope.nvim', requires={'nvim-lua/plenary.nvim'}}
use 'nvim-telescope/telescope-fzf-native.nvim'


if packer_bootstrap then
require('packer').sync()
end
end)

