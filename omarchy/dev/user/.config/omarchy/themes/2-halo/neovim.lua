return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#050503", -- Default background
                base01 = "#3e3e30", -- Lighter background (status bars)
                base02 = "#050503", -- Selection background
                base03 = "#3e3e30", -- Comments, invisibles
                base04 = "#EAEDF3", -- Dark foreground
                base05 = "#ffffff", -- Default foreground
                base06 = "#ffffff", -- Light foreground
                base07 = "#EAEDF3", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#CDBFA8", -- Variables, errors, red
                base09 = "#efeae2", -- Integers, constants, orange
                base0A = "#bebe89", -- Classes, types, yellow
                base0B = "#9cbd7a", -- Strings, green
                base0C = "#b9bbbb", -- Support, regex, cyan
                base0D = "#C8CCDA", -- Functions, keywords, blue
                base0E = "#ACB4CD", -- Keywords, storage, magenta
                base0F = "#e0e0c3", -- Deprecated, brown/yellow
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
