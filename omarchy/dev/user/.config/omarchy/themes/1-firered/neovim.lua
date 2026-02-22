return {
  {
    "bjarneo/aether.nvim",
    name = "aether",
    priority = 1000,
    opts = {
      disable_italics = false,
      colors = {
        -- Monotone shades (base00-base07)
        base00 = "#ffffff", -- Default background
        base01 = "#eeeeee", -- Lighter background (status bars)
        base02 = "#d5d5d5", -- Selection background
        base03 = "#676767", -- Comments, invisibles
        base04 = "#000000", -- Dark foreground
        base05 = "#2e2e2e", -- Default foreground
        base06 = "#2e2e2e", -- Light foreground
        base07 = "#000000", -- Light background

        -- Accent colors (base08-base0F)
        base08 = "#a040a0", -- Variables, errors, red
        base09 = "#cb7dcb", -- Integers, constants, orange
        base0A = "#e83000", -- Classes, types, yellow
        base0B = "#78c850", -- Strings, green
        base0C = "#f8b010", -- Support, regex, cyan
        base0D = "#6890f0", -- Functions, keywords, blue
        base0E = "#f08030", -- Keywords, storage, magenta
        base0F = "#ff6f49", -- Deprecated, brown/yellow
      },
    },
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")

      -- Enable hot reload
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
