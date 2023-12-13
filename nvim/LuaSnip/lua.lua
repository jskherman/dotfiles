local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
  -- format snippet
  s(
    "snipf",
    fmt(
      [[ 
    <>({ trig='<>', name='<>' },
    fmt(<>,
    { <> },
    { delimiters='<>' }
    ),
    <>),
    
    <>]],
      {
        c(1, { t("s"), t("autosnippet") }),
        i(2, "trig"),
        i(3, "trig"),
        i(4, "snippet"),
        i(5, "inputs"),
        i(6, "{}"),
        i(7, "{ opts }"),
        i(0),
      },
      { delimiters = "<>" }
    )
  ),

  -- simple text snippet
  s(
    "snipt",
    fmt(
      [[ 
    <>(<>, {t('<>')}<>
    <>)<>,]],
      {
        c(1, { t("s"), t("autosnippet") }),
        c(2, { i(nil, "trig"), sn(nil, { t("{trig='"), i(1), t("'}") }) }),
        i(3, "text"),
        i(4, "opts"),
        i(5),
        i(0),
      },
      { delimiters = "<>" }
    )
  ),
}

