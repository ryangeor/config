vim.api.nvim_command('set runtimepath^=~/.config/nvim')
vim.api.nvim_command('set runtimepath^=~/.config/nvim/lua')
vim.api.nvim_command('set runtimepath^=~/.local/site/nvim')
vim.api.nvim_command('set runtimepath^=~/.local/share/nvim')
vim.api.nvim_command('set runtimepath^=~/.local/nvim/site/after')
vim.api.nvim_command('let &packpath = &runtimepath')

require('plugins')
vim.cmd('colorscheme rose-pine')


vim.api.nvim_command('set tabstop=4')
vim.api.nvim_command('set shiftwidth=4 smarttab')
vim.api.nvim_command('set expandtab')

