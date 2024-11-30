return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
        formatters_by_ft = {
            c = { 'clang-format' },
            ['c++'] = { 'clang-format' },
            lua = { 'stylua' },
            python = { 'isort', 'black' },
            javascript = { 'biome', 'ts-standard', stop_after_first = true },
            ['*'] = { 'prettierd' },
        },
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
    },
}
