local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local navic = require("nvim-navic")

local ExcludedFiles = {
	"NvimTree",
	"NvimTree_1",
	"TelescopePrompt",
	"Telescope",
	"[No Name]",
	"[New]",
	"nil",
	"",
	nil,
}

-- To add custom LSP servers installed with mason, add them to this table
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local servers = {
	"ast_grep", -- C, C++, Rust, Go, Java, Python, C#, JavaScript, JSX, TypeScript, HTML, CSS, Kotlin, Dart, Lua
	"clangd", -- C/C++
	"tsserver", -- TypeScript/JavaScript
	"bashls", -- Bash
	"lua_ls", -- Lua
	"marksman", -- Markdown
	"jdtls",
	"vimls",
	-- PYTHON
	"pyright",
	-- CSS/SASS
	"cssls", -- CSS/SCSS
	"somesass_ls", -- SASS/SCSS
	"cssmodules_ls", -- OTHER MODULES FOR CSS
	"css_variables", -- Css Variables
}

local function is_excluded(buffer_name)
	for _, excluded_name in ipairs(ExcludedFiles) do
		if buffer_name:find(excluded_name, 1, true) then
			return true
		end
	end
	return false
end

local function on_attach(client, bufnr)
	local buffer_name = vim.api.nvim_buf_get_name(bufnr)
	if not is_excluded(buffer_name) and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
