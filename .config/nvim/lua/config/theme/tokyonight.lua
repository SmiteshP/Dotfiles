-- Theme
require("tokyonight").setup({
  style = "night",
  light_style = "day",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "NvimTree", "terminal", "help" },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = true,
  lualine_bold = true,
})

vim.cmd[[colorscheme tokyonight]]
