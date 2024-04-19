return {
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gs", "<cmd>LazyGit<cr>", desc = "[G]it [S]tatus" },
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
}
