vim.api.nvim_command('set runtimepath^=~/.config/nvim')
vim.api.nvim_command('set runtimepath^=~/.config/nvim/lua')
vim.api.nvim_command('set runtimepath^=~/.local/site/nvim')
vim.api.nvim_command('set runtimepath^=~/.local/share/nvim')
vim.api.nvim_command('set runtimepath^=~/.local/nvim/site/after')
vim.api.nvim_command('let &packpath = &runtimepath')


vim.g.mapleader =','
vim.g.maplocalleader = ','

require('plugins')

-- tags
vim.api.nvim_command('set tabstop=4')
vim.api.nvim_command('set shiftwidth=4 smarttab')
vim.api.nvim_command('set expandtab')

-- make macro mispresses harder 
vim.keymap.set('n', '<leader>q', 'q')
vim.keymap.set('n', 'q', '<Nop>')

-- misc
vim.keymap.set('n', '<leader>b', ':set invrelativenumber<CR>')

-- nav overrides
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc='lspa', 
    callback=function(ev)
        vim.bo[ev.buf].omnifunc='v:lua.vim.lsp.omnifunc'
        local opts={buffer=ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format{async=true}
        end, opts)
    end
})


local rt = require('rust-tools')
rt.setup({
    server={
        on_attach=function(_, bufnr)
            vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group, {bufnr=bufnr})
        end, 
        settings={
            ['rust-analyzer']={
                cargo={
                    features='all'
                }, 
                procMacro={
                    enable=true
                }, 
            }
        }
    },
})

require('osc52').setup {
  max_length = 0,           -- Maximum length of selection (0 for no limit)
  silent = false,           -- Disable message on successful copy
  trim = false,             -- Trim surrounding whitespaces before copy
  tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
}

vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

function copy()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
    require('osc52').copy_register('+')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

-- copy paste yadayada over ssh inc
vim.g.clipboard = {
    name='osc52',
    copy={['+']=copy, ['*']=copy},
    paste={['+']=paste, ['*']=paste},
}

vim.keymap.set('n', '<leader>c', '"+y')
vim.keymap.set('n', '<leader>cc', '"+yy')


require('nvim-treesitter.configs').setup{
    ensure_installed={"lua", "rust", "toml", "c", "cpp", "python"},
    auto_install=true,
    highlight={
        enable=true,
        disable={"cpp", "cmake", "dockerfile"},
        additional_vim_regex_highlighting=false,
    },
    incremental_selection={
        enable=true,
        keymaps={
            init_selection='<CR>',
            scope_incremental='<CR>',
            node_incremental='<TAB>',
            node_decremental='<TAB>',
        },
    },
    ident={enable=true},
    rainbow={
        enable=true,
        extended_mode=true,
        max_file_lines=10000,
    }
}

-- yeaaaah no thanks to folding
vim.wo.foldmethod='expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'
vim.wo.foldenable=false
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap=true, silent=true})

-- colors for when in the mood
require("rose-pine").setup {
    transparent_background = true,
    semantic_tokens = true,
    highlight_overrides= {},
    color_overrides = {},
    styles = {},
}
require("monet").setup {
    transparent_background = true,
    semantic_tokens = true,
    highlight_overrides= {},
    color_overrides = {},
    styles = {},
}

vim.cmd('colorscheme rose-pine') -- default
vim.keymap.set('n', "<leader>rp", ":colorscheme rose-pine<CR>")
vim.keymap.set('n', "<leader>cmn", ":colorscheme monet<CR>")
vim.keymap.set('n', "<leader>bl", ":set background=light<CR>")
vim.keymap.set('n', "<leader>bd", ":set background=dark<CR>")


-- finding shit
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

-- telescope defailts loool
-- <C-n>/<Down> 	Next item
-- <C-p>/<Up> 	Previous item
-- j/k 	Next/previous (in normal mode)
-- H/M/L 	Select High/Middle/Low (in normal mode)
-- gg/G 	Select the first/last item (in normal mode)
-- <CR> 	Confirm selection
-- <C-x> 	Go to file selection as a split
-- <C-v> 	Go to file selection as a vsplit
-- <C-t> 	Go to a file in a new tab
-- <C-u> 	Scroll up in preview window
-- <C-d> 	Scroll down in preview window
-- <C-f> 	Scroll left in preview window
-- <C-k> 	Scroll right in preview window
-- <M-f> 	Scroll left in results window
-- <M-k> 	Scroll right in results window
-- <C-/> 	Show mappings for picker actions (insert mode)
-- ? 	Show mappings for picker actions (normal mode)
-- <C-c> 	Close telescope (insert mode)
-- <Esc> 	Close telescope (in normal mode)
-- <Tab> 	Toggle selection and move to next selection
-- <S-Tab> 	Toggle selection and move to prev selection
-- <C-q> 	Send all items not filtered to quickfixlist (qflist)
-- <M-q> 	Send all selected items to qflist
