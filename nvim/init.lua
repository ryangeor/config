vim.api.nvim_command('set runtimepath^=~/.config/nvim')
vim.api.nvim_command('set runtimepath^=~/.config/nvim/lua')
vim.api.nvim_command('set runtimepath^=~/.local/site/nvim')
vim.api.nvim_command('set runtimepath^=~/.local/share/nvim')
vim.api.nvim_command('set runtimepath^=~/.local/nvim/site/after')
vim.api.nvim_command('let &packpath = &runtimepath')

require('plugins')

vim.api.nvim_command('set tabstop=4')
vim.api.nvim_command('set shiftwidth=4 smarttab')
vim.api.nvim_command('set expandtab')

-- floatterm
vim.keymap.set('n', '<leader>b', ':set invrelativenumber<CR>')
vim.keymap.set('n', '<leader>ft', ':set FloatermNew<CR>')
vim.keymap.set('t', '<leader>ft', '<C-\\><C-n>:FloatermNew<CR>')
vim.keymap.set('n', '<leader>n', ':set FloatermNext<CR>')
vim.keymap.set('t', '<leader>n', '<C-\\><C-n>:FloatermNext<CR>')
vim.keymap.set('n', '<leader>p', ':set FloatermPrev<CR>')
vim.keymap.set('t', '<leader>p', '<C-\\><C-n>:FloatermPrev<CR>')
vim.keymap.set('n', 't', ':FloatermToggle<CR>')
vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:FloatermToggle<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CR>')

-- make macro mispresses harder 
vim.keymap.set('n', '<leader>q', 'q')
vim.keymap.set('n', 'q', '<Nop>')


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

vim.wo.foldmethod='expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'
vim.wo.foldenable=false
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap=true, silent=true})

-- colors for when in the mood
require("monet").setup {
    transparent_background = true,
    semantic_tokens = true,
    highlight_overrides= {},
    color_overrides = {},
    styles = {},
}
--vim.cmd('colorscheme rose-pine')
vim.cmd('colorscheme monet')
vim.keymap.set('n', "<leader>rp", ":colorscheme rose-pine<CR>")
vim.keymap.set('n', "<leader>cmn", ":colorscheme monet<CR>")
vim.keymap.set('n', "<leader>bl", ":set background=light<CR>")
vim.keymap.set('n', "<leader>bd", ":set background=dark<CR>")

