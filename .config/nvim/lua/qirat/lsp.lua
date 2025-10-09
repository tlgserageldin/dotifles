-- after/plugin/lsp.lua

local lspconfig       = require("lspconfig")
local mason           = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- Bootstrap Mason
mason.setup()

-- Define LSP servers list
local servers = {
  "jedi_language_server",    -- Python
  "clangd",                  -- C/C++
  "ts_ls",                   -- JavaScript/TypeScript
  "bashls",                  -- Bash
  "lua_ls",                  -- Lua, including Neovim
  "arduino_language_server", -- Arduino
}

-- Ensure the servers are installed
-- is a double call to setup, just let it loop
-- mason_lspconfig.setup({ ensure_installed = servers, })

-- Common on_attach and capabilities
local on_attach = function(client, bufnr)
  if vim.bo[bufnr].filetype == 'python' then
    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   buffer = bufnr,
    --   callback = function()
    --     vim.fn.system("black " .. vim.fn.shellescape(vim.fn.expand("%")))
    --     vim.cmd("edit") -- reload the buffer
    --   end,
    -- })
  elseif client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  local telescope = require("telescope.builtin")
  local function buf_map(keys, func, desc)
    if desc then desc = "LSP: " .. desc end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  buf_map("<leader>rn", vim.lsp.buf.rename, "Rename")
  buf_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  buf_map("gd", telescope.lsp_definitions, "Goto Definition")
  buf_map("gr", telescope.lsp_references, "References")
  buf_map("gI", vim.lsp.buf.implementation, "Implementation")
  buf_map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
  buf_map("<leader>ds", telescope.lsp_document_symbols, "Document Symbols")
  buf_map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")
  buf_map("K", vim.lsp.buf.hover, "Hover Documentation")
  buf_map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
  buf_map("gD", vim.lsp.buf.declaration, "Declaration")
  buf_map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
  buf_map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
  buf_map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List Workspace Folders")
  buf_map("<leader>e", vim.diagnostic.open_float, "[E]rror")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- -- after you define `servers` and before the for‐loop, insert:
-- vim.notify("LSP setup: checking servers “" .. table.concat(servers, ", ") .. "”", vim.log.levels.INFO)
--
-- -- then change your loop to:
-- for _, name in ipairs(servers) do
--   local mod = lspconfig[name]
--   if not mod then
--     vim.notify(("🚨  lspconfig[%q] is nil – no such server"):format(name), vim.log.levels.ERROR)
--   elseif type(mod.setup) ~= "function" then
--     vim.notify(("🚨  lspconfig[%q].setup is a %s, not a function")
--                :format(name, type(mod.setup)), vim.log.levels.ERROR)
--   else
--     vim.notify(("✅  setting up %q"):format(name), vim.log.levels.INFO)
--     local opts = { on_attach = on_attach, capabilities = capabilities }
--     if name == "lua_ls" then
--       opts.settings = {
--         Lua = {
--           runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
--           diagnostics = { globals = { "vim" } },
--           workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
--           telemetry = { enable = false },
--         },
--       }
--     end
--     mod.setup(opts)
--   end
-- end
-- Setup each server
-- In your lsp.lua, replace the setup loop with this:
for _, name in ipairs(servers) do
  local opts = { on_attach = on_attach, capabilities = capabilities }

  if name == "lua_ls" then
    opts.settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  elseif name == "arduino_language_server" then
    opts.cmd = {
      "arduino-language-server",
      "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
      "-fqbn", "arduino:avr:uno", -- Default board, can be overridden
      "-cli", "arduino-cli",
      "-clangd", "clangd"
    }
    opts.filetypes = { "arduino", "cpp" }
  elseif name == "clangd" then
    -- Enhanced clangd config for Arduino support
    opts.cmd = {
      "clangd",
      "--compile-commands-dir=build",
      "--header-insertion=never",
      "--clang-tidy",
      "--completion-style=detailed"
    }
    opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "arduino" }
  end

  lspconfig[name].setup(opts)
end
