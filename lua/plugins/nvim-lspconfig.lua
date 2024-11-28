local excluded_files= {
	"NvimTree",
	"NvimTree_1",
	"TelescopePrompt",
	"Telescope",
	"[No Name]",
	"[New]",
}

local servers = {
	"clangd", -- C/C++
	"pyright", -- Python
	"ts_ls", -- TypeScript/JavaScript
	"cssls", -- CSS/SCSS
	"bashls", -- Bash
	"lua_ls", -- Lua
	"rust_analyzer", -- Rust
	"svelte", -- Svelte
	--"perlnavigator",
	"perlpls", -- Perl
	"marksman", -- Markdown
}

local is_excluded = function(buffer_name)
	for _, name in ipairs(excluded_files) do
        if string.find(buffer_name, name, 1, true) then
			return true
		end
	end
	return false
end

return { 
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require"lspconfig"
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local navic = require("nvim-navic") 

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                capabilities = capabilities,
                on_attach = function(client, n)
                    local name = vim.api.nvim_buf_get_name(n)
                    if client.server_capabilities.documentSymbolProvider and not is_excluded(name) then
                        navic.attach(client, n)
                    end
                end
            })
        end
    end
}
