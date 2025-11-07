return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#030810", -- Default background
                base01 = "#283851", -- Lighter background (status bars)
                base02 = "#030810", -- Selection background
                base03 = "#283851", -- Comments, invisibles
                base04 = "#F1FAFC", -- Dark foreground
                base05 = "#ffffff", -- Default foreground
                base06 = "#ffffff", -- Light foreground
                base07 = "#F1FAFC", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#5094d8", -- Variables, errors, red
                base09 = "#97c2ed", -- Integers, constants, orange
                base0A = "#C6DBE5", -- Classes, types, yellow
                base0B = "#7eb9b1", -- Strings, green
                base0C = "#ABD0E2", -- Support, regex, cyan
                base0D = "#90adc5", -- Functions, keywords, blue
                base0E = "#8ab9db", -- Keywords, storage, magenta
                base0F = "#ffffff", -- Deprecated, brown/yellow
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
