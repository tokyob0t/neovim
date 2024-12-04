return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    init = function()
        vim.api.nvim_create_user_command('ToggleFormat', function()
            local global_state = vim.g.disable_autoformat
            local buffer_state = vim.b.disable_autoformat
            if global_state or buffer_state then
                vim.b.disable_autoformat = false
            else
                vim.b.disable_autoformat = true
            end
        end, {
            desc = 'Toggle autoformat-on-save',
        })
    end,
    opts = {
        formatters_by_ft = {
            c = { 'clang-format' },
            ['c++'] = { 'clang-format' },
            lua = { 'stylua' },
            python = { 'isort', 'black' },
            javascript = { 'biome', stop_after_first = true },
        },
        format_on_save = function(bufnr)
            if vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
    },
}
