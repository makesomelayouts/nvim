return {
  -- fix notify - "no information available" when using some languages in one file

  "folke/noice.nvim",
  opts = {
    function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,

    lsp = {
      hover = {
        -- Set not show a message if hover is not available
        -- ex: shift+k on Typescript code
        silent = true,
      },
    },
  },
}
