local servers = {
    'clangd', -- C/C++
    'ruff', -- Python
    'pylsp',
    -- 'basedpyright',
    'ts_ls', -- TypeScript/JavaScript
    -- 'cssls', -- CSS/SCSS
    'somesass_ls', -- CSS/SCSS
    'css_variables',
    'cssmodules_ls',
    'tailwindcss',
    'eslint', -- eslint
    'bashls', -- Bash
    'lua_ls', -- Lua
    'fennel_language_server',
    'rust_analyzer', -- Rust
    'svelte', -- Svelte
    'perlpls', -- Perl
    'marksman', -- Markdown
    'vala_ls', -- Vala
    'rnix', -- Nix
}

return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true
        local navic = require('nvim-navic')

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                capabilities = capabilities,
                on_attach = function(client, n)
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, n)
                    end
                end,
            })
        end
    end,
}
