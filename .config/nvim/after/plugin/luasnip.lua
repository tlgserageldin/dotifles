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

ls.add_snippets("all", {
})

ls.add_snippets("c", {
    s("vmain", {
        t({"int main(void) {",}), i(1),
        t({"","  return 0;", ""}),
        t({"}"}),
    }),
    s("main", {
        t({"#include <stdlib.h>", "", ""}),
        t({"int main(int argc, char* argv[argc+1]) {",}), i(1),
        t({"","  return EXIT_SUCCESS;", ""}),
        t({"}"}),
    }),
    s("for", {
        t({"for ( "}), i(1), t("; "), i(2), t("; "), i(3), t({" ) {", ""}),
        t("}")
    }),
    s("if", {
        t("if ( "), i(1), t({" ) {", "}"})
    }),
    s("else", {
        t({"else {"}), i(1),
        t({"", "}"}),
    }),
    s("else if", {
        t("else if ( "), i(1), t({" ) {", "", "}"})
    }),
    s("while", {
        t("while ( "), i(1), t({" ) {", "}"})
    }),
    s("do while", {
        t({"do {", "} while ( ",}), i(1), t(" );"),
    }),
    s("/*", {
        t({"/* "}), i(1), t({" */"}),
    })

})

vim.keymap.set({"i", "s"}, "<C-f>", function() ls.jump( 1) end, {desc = 'Luasnip [F]orward', silent = true})
vim.keymap.set({"i", "s"}, "<C-b>", function() ls.jump(-1) end, {desc = 'Luasnip [B]ack', silent = true})
