local M = {}

function M.configure()
  local lspconfig = require "lspconfig"
  local builtin = require "telescope.builtin"

  -- Auto cmd that should run any time lsp attaches
  -- Every time a new file is opened that's associated
  -- with an lsp server, this should execute on the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(modes, keys, func, desc)
        vim.keymap.set(modes, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      local renameMap = function()
        if pcall(require, "inc_rename") then
          return ":IncRename "
        else
          vim.lsp.buf.rename()
        end
      end

      local format = function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.bo[buf].filetype
        local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

        if pcall(require, "conform") then
          local conform = require "conform"

          conform.format {
            bufnr = buf,
            filter = function(client)
              if have_nls then
                return client.name == "null-ls"
              end
              return client.name ~= "null-ls"
            end,
          }
        else
          vim.lsp.buf.format {
            bufnr = buf,
            filter = function(client)
              if have_nls then
                return client.name == "null-ls"
              end
              return client.name ~= "null-ls"
            end,
          }
        end
      end

      map("n", "gd", builtin.lsp_definitions, "[G]oto [D]efinition")
      map("n", "gr", builtin.lsp_references, "[G]oto [R]eferences")
      map("n", "gI", builtin.lsp_implementations, "[G]oto [I]mplementations")
      map("n", "<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
      map("n", "<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
      map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      map("n", "<leader>rn", renameMap(), "[R]e[n]ame")
      map("n", "gh", vim.lsp.buf.hover, "[H]over Documentation")
      map("n", "gH", vim.lsp.buf.signature_help, "[G]oto Signature Help")
      map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]action")
      map({ "n", "v" }, "<leader>cf", format, "[C]ode [F]ormat")

      -- These two autos will highlight references of the word under your cursor
      -- when your cusor rests there for a while.
      --  Check `:help CursorHold` for more info about when this executes
      --
      -- When you move the cursor, the highlights will be cleared
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  local servers = {
    -- Lua
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
    -- Docker
    dockerls = {},
    -- Bash
    bashls = {},
    -- Awk
    awk_ls = {},
    -- Emmet (html)
    emmet_ls = {
      init_options = {
        html = {
          options = {
            ["bem.enabled"] = true,
          },
        },
      },
    },
    -- Markdown
    marksman = {},
    -- CSS, SCSS, LESS
    cssls = {},
    -- Html
    html = {
      filetypes = { "html", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    },
    -- C#
    omnisharp = {
      organize_imports_on_format = true,
      enable_import_completion = true,
    },
    -- TS, JS,
    tsserver = {
      settings = {
        typescript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        javascript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
    },
    eslint = {
      settings = {
        workingDirectory = { mode = "auto" },
      },
    },
  }

  require("mason").setup()

  vim.keymap.set("n", "<leader>cm", vim.cmd.Mason, { desc = "[C]heck [M]ason" })

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    "stylua",
  })

  require("mason-tool-installer").setup { ensure_installed = ensure_installed }

  require("mason-lspconfig").setup {
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- Handles override only values explicitly passd
        -- by the server config above, Usefule for disabling
        -- certain features of an LSP (like turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        lspconfig[server_name].setup(server)
      end,
    },
  }

  local nls = require "null-ls"
  nls.setup {
    sources = {
      nls.builtins.formatting.stylua,
      nls.builtins.diagnostics.ruff.with { extra_args = { "--max-line-length=180" } },
    },
  }
end

return M
