local telescope = require('telescope.builtin')

-- runs on every buffer with known lsp
local on_attach = function(_, bufnr)
    local lspnmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    lspnmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    lspnmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    lspnmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    lspnmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
    lspnmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    lspnmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    lspnmap('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
    lspnmap('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    lspnmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    lspnmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    lspnmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    lspnmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    lspnmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    lspnmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- show / hide lsp diagnostic
local function hide_diagnostics()
    vim.diagnostic.config({  -- https://neovim.io/doc/user/diagnostic.html
        virtual_text = false,
        signs = false,
        underline = false,
    })
end
local function show_diagnostics()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
    })
end
vim.keymap.set("n", "<leader>dh", hide_diagnostics, { desc = '[D]iagnostics [H]ide' })
vim.keymap.set("n", "<leader>ds", show_diagnostics, { desc = '[D]iagnostics [S]how' } )

-- define language servers
local servers = {
  clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      callSnippet = 'Replace',
    },
  },
}

-- Ensure the servers above are installed
local mason = require('mason')
local mason_lspconfig = require 'mason-lspconfig'

-- setup mason
mason.setup()
-- make mason aware of the servers
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}
