-- would like this to work but does not
-- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})

local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

ls.config.set_config {
    history = true,
    -- update dynamic snippetes
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

vim.keymap.set({"i", "s"}, "<C-f>", function() ls.jump( 1) end, {desc = 'Luasnip [F]orward', silent = true})
vim.keymap.set({"i", "s"}, "<C-b>", function() ls.jump(-1) end, {desc = 'Luasnip [B]ack', silent = true})
