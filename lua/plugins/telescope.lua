-- return {
--   "nvim-telescope/telescope.nvim",
--   cmd = "Telescope",
--   event = "LazyDone",
--   version = false,
--   dependencies = {
--     {
--       "nvim-telescope/telescope-fzf-native.nvim",
--       build = vim.fn.executable("make") == 1 and "make"
--         or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
--       enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
--     },
--     { "nvim-telescope/telescope-ui-select.nvim" },
--   },
--   keys = {
--     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
--     { "<leader>sf", require("utils").telescope("files"), desc = "[S]earch [F]iles (Root Dir)" },
--     { "<leader>sF", require("utils").telescope("files", { cwd = false }), desc = "[S]earch [F]iles (Cwd)" },
--     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
--   },
-- }
