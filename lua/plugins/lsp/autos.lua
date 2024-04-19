local M = {}

function M.configure_formatting()
  require("conform").setup {
    notify_on_error = false,

    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,

    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { { "prettierd", "prettier" }, "eslint_d" },
      typescript = { { "prettierd", "prettier" }, "eslint_d" },
      html = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      csharp = { "csharpier" },
      xml = { "xmllint" },
      yaml = { "yamlfmt" },
      sql = { "sql_formatter" },
    },
  }
end

function M.configure_completions()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local icons = require "lua.config.icons"

  luasnip.config.setup {}

  cmp.setup {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      -- Scroll docs window
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),

      -- Accept completion
      --  This auto-imports, and expands snippets if your LSP supports it
      ["<Tab>"] = cmp.mapping.confirm { select = true },
      ["<CR>"] = cmp.mapping.confirm { select = true },

      -- Abort completions list
      ["<ESC>"] = cmp.mapping.abort(),

      -- Trigger completion
      --  Shouldn't need to do this often as cmp will display
      --  completions whenever it has options available
      ["<C-Space>"] = cmp.mapping.complete {},

      -- Think of these two like moving left/right of the snippet window
      -- e.g.
      --
      --  function $name($args)
      --    $body
      --  end
      --
      --  <c-l> will move to the right of the expansion window
      --  <c-h> wil move to the left(backwards) of the window
      ["<C-l>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "nvim_lsp_signature_help" },
      { name = "buffer" },
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      expandable_indicator = true,
      format = function(entry, item)
        local max_width = 0
        local source_names = {
          nvim_lsp = "(LSP)",
          path = "(Path)",
          luasnip = "(Snippet)",
          buffer = "(Buffer)",
        }
        local duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          lausnip = 1,
        }
        local duplicates_default = 0
        if max_width ~= 0 and #item.abbr > max_width then
          item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
        end
        item.kind = icons.kind[item.kind]
        item.menu = source_names[entry.source.name]
        item.dup = duplicates[entry.source.name] or duplicates_default
        return item
      end,
    },
  }

  -- Use buffer source for '/' and '?' (if 'native_menu' active, this won't work)
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if 'native_menu', this won't work)
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

function M.configure_autopairs()
  local autopair = require 'nvim-autopairs'
  local cmp_autopair = require 'nvim-autopairs.completion.cmp'
  local cmp = require 'cmp'

  autopair.setup {
    check_ts = true,
  }

  autopair.add_rules(require 'nvim-autopairs.rules.endwise-lua')

  -- Insert '(' after selecting functions or methods
  cmp.event:on('confirm_done', cmp_autopair.on_confirm_done())
end

return M
