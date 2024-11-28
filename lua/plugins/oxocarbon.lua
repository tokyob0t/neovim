colorscheme = vim.cmd.colorscheme

return {
  "nyoom-engineering/oxocarbon.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    colorscheme("oxocarbon")
  end
}
