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

local function in_markup()
  return vim.api.nvim_eval("typst#in_markup()") == 1
end

local function in_math()
  return vim.api.nvim_eval("typst#in_math()") == 1
end

local function in_code()
  return vim.api.nvim_eval("typst#in_code()") == 1
end

local function in_comment()
  return vim.api.nvim_eval("typst#in_comment()") == 1
end

return {
  -- ============================================
  --              Triggered Snippets
  -- ============================================

  -- -------------- TEXT snippets ---------------

  -- FIGURES
  s(
    { trig = "figt", name = "Insert table figure" },
    fmt(
      [[
    figure(
      table(
        columns: ({}),
        align: ({}),
        {}
      ),
      caption: [{}],
    ) <ftbl-{}>{}]],
      {
        i(3, "auto"),
        i(4, "center"),
        i(5, "content"),
        i(1, "caption"),
        i(2, "label"),
        i(0),
      },
      { delimiters = "{}" }
    )
  ),

  s(
    { trig = "figi", name = "Insert image figure" },
    fmt(
      [[
    figure(
      image("{}", width: {}, height: {}),
      caption: [{}],
    ) <fimg-{}>{}]],
      {
        i(5, "href"),
        i(3, "auto"),
        i(4, "auto"),
        i(1, "caption"),
        i(2, "label"),
        i(0),
      },
      { delimiters = "{}" }
    )
  ),

  s(
    { trig = "figc", name = "Insert code figure" },
    fmt(
      [[
    figure(
      caption: [{}],
    )[
    ```{}
    {}
    ```
    ] <fcode-{}>{}]],
      {
        i(1, "caption"),
        i(3, "lang"),
        i(4, "code"),
        i(2, "label"),
        i(0),
      },
      { delimiters = "{}" }
    )
  ),

  s(
    { trig = "terml", name = "Insert term list item" },
    fmt(
      [[
    / {}: {}
    {}]],
      { i(1, "term"), i(2, "description"), i(0) },
      { delimiters = "{}" }
    )
  ),

  -- -------------- MATH snippets ---------------
  s(
    { trig = "\\/", name = "Fraction", dscr = "Creates a fraction" },
    fmt(
      [[
    ({})/({}) {}]],
      {
        i(1, "num"),
        i(2, "den"),
        i(0),
      },
      { delimiters = "{}" }
    ),
    { condition = in_math, show_condition = in_math }
  ),

  s(
    { trig = "/", name = "V-mode Fraction", dscr = "Creates a fraction from selection" },
    fmt(
      [[
    ({})/({}) {}]],
      {
        f(function(_, snip)
          local res, env = {}, snip.env
          for _, val in ipairs(env.LS_SELECT_RAW) do
            table.insert(res, val)
          end
          return res
        end, {}),
        i(1, "den"),
        i(0),
      },
      { delimiters = "{}" }
    ),
    { condition = in_math, show_condition = in_math }
  ),
}, {
  -- ============================================
  --                Auto Snippets
  -- ============================================

  -- -------------- TEXT snippets ---------------
  s(
    { trig = "dm", name = "Insert block math" },
    fmt(
      [[
    $ {} $

    {}]],
      { i(1), i(0) },
      { delimiters = "{}" }
    )
  ),

  s(
    { trig = "mk", name = "Insert inline math" },
    fmt(
      [[
    ${}$ {}]],
      { i(1), i(0) },
      { delimiters = "{}" }
    )
  ),

  -- -------------- MATH snippets ---------------
  -- sub/super scripts
  s(
    { trig = "(%a)(%d)", regTrig = true, name = "auto subscript", dscr = "hi" },
    fmt([[{}_{}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }, { delimiters = "{}" }),
    { condition = in_math, show_condition = in_math }
  ),

  s(
    { trig = "(%a)_(%d%d)", regTrig = true, name = "auto subscript 2", dscr = "auto subscript for 2+ digits" },
    fmt([[{}_({})]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }, { delimiters = "{}" }),
    { condition = in_math, show_condition = in_math }
  ),

  s(
    { trig = "==", name = "equals aligned" },
    fmt(
      [[
    &= {} \
    {}]],
      { i(1), i(0) },
      { delimiters = "{}" }
    )
  ),

  s({ trig = "ceil", name = "Ceiling function" }, fmt([[ceil({}) {}]], { i(1), i(0) }, { delimiters = "{}" })),
  s({ trig = "floor", name = "Floor function" }, fmt([[floor({}) {}]], { i(1), i(0) }, { delimiters = "{}" })),
  s({ trig = "abs", name = "Absolute value" }, fmt([[abs({}) {}]], { i(1), i(0) }, { delimiters = "{}" })),
  s({ trig = "round", name = "Round-up function" }, fmt([[round({}) {}]], { i(1), i(0) }, { delimiters = "{}" })),
  s({ trig = "norm", name = "Normal function" }, fmt([[norm({}) {}]], { i(1), i(0) }, { delimiters = "{}" })),
}
