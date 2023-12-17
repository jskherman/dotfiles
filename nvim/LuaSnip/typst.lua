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
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
local extdec = ls.extend_decorator

-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, this function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- ----------------------------------------------------------------------------

-- Typst detection functions
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

-- Function that returns either a space or an empty string based on the input.
local function space_conditional(args)
  -- args[1] will be the text from the first node
  local next_char = args[1]
  if next_char and not string.match(next_char, "[,%.%?%- ]") then
      return " "
  else
      return ""
  end
end

-- ----------------------------------------------------------------------------

-- Use LuaSnip's extend decorator to set opts = { condition = in_math, show_condition = in_math }
extdec.register(s, {arg_indx=3})
extdec.register(postfix, {arg_indx=3})
local sm = extdec.apply(s, { condition = in_math, show_condition = in_math })
local sb = extdec.apply(s, { condition = line_begin })

local postfixm = extdec.apply(postfix, { condition = in_math, show_condition = in_math })

-- ----------------------------------------------------------------------------

return {
  -- ============================================
  --              Triggered Snippets
  -- ============================================

  -- -------------- TEXT snippets ---------------

  -- FIGURES
  sb(
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
      }
    )
  ),

  sb(
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
      }
    )
  ),

  sb(
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
      }
    )
  ),

  sb(
    { trig = "tl", name = "Insert term list item" },
    fmt(
      [[
    / {}: {}
    {}]],
      { i(1, "term"), i(2, "description"), i(0) }
    )
  ),

  -- Callouts / Admonitions / Boxes
  sb(
    { trig = "defa", name = "Admonition: Defintion" },
    fmta(
      [[
      #definition(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),

  sb(
    { trig = "exma", name = "Admonition: Example" },
    fmta(
      [[
      #example(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),

  sb(
    { trig = "nota", name = "Admonition: Note" },
    fmta(
      [[
      #note(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),

  sb(
    { trig = "atta", name = "Admonition: Attention" },
    fmta(
      [[
      #attention(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),

  sb(
    { trig = "qta", name = "Admonition: Quote" },
    fmta(
      [[
      #quote(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),

  sb(
    { trig = "thma", name = "Admonition: Theorem" },
    fmta(
      [[
      #theorem(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),

  sb(
    { trig = "propa", name = "Admonition: Proposition" },
    fmta(
      [[
      #proposition(
        "<>",
        footer: [<>]
      )[
        <>
      ]
      
      <>]],
      {
        i(1, "title"),
        i(2, "footer text"),
        d(3, get_visual),
        i(0)
      }
    )
  ),


  -- -------------- MATH snippets ---------------
  -- Fractions
  sm(
    { trig = "/", name = "Fraction Num", dscr = "Creates a fraction with selection as numerator." },
    fmt(
      [[
    ({})/({}) {}]],
      {
        -- f(function(_, snip)
        --   local res, env = {}, snip.env
        --   for _, val in ipairs(env.LS_SELECT_RAW) do
        --     table.insert(res, val)
        --   end
        --   return res
        -- end, {}),
        d(1, get_visual),
        i(2, "den"),
        i(0),
      }
    )
  ),

  sm(
    { trig = "\\", name = "Fraction Den", dscr = "Creates a fraction with selection as denominator." },
    fmt([[({})/({}) {}]],
      {
        i(2, "num"),
        d(1, get_visual),
        i(0),
      }
    )
  ),

  postfixm(
    { trig = ".fr", name = "Surround into fraction" },
    fmt([[{}/({}) {}]], {
      d(1, function (_, parent)
        return sn(nil, {t("(" .. parent.env.POSTFIX_MATCH .. ")")})
      end),
      i(2, "den"),
      i(0)
    })
  ),

  -- Wraps/Surrounds
  postfixm({ trig = ".pr", name = "Wrap with ()" }, {l("( " .. l.POSTFIX_MATCH .. " )")} ),

  sm({ trig = "lrp", name = "Left-Right ()" }, fmt([[lr(( {} )) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "lrb", name = "Left-Right []" }, fmt([[lr([ {} ]) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "lrc", name = "Left-Right {}" }, fmta([[lr({ <> }) <>]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "lra", name = "Left-Right <>" }, fmt([[lr(angle.l {} angle.r) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "lr|", name = "Left-Right ||" }, fmt([[lr(abs( {} )) {}]], { d(1, get_visual), i(0) }) ),

  sm({ trig = "mcal", name = "Calligraphic variant" }, fmt([[cal({}) {}]], { i(1, "L"), i(0) }) ),

  -- Decorators: Over and Under
  sm({ trig = "conj", name = "Conjugate" }, fmt([[overline({}){}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "bar", name = "Over: bar" }, fmt([[overline({}){}]], { d(1, get_visual), i(0) }) ),

  -- Operators: Limits, Sums, Integrals, Product
  sm({ trig = "lim", name = "Limit" }, fmt([[lim_({} -> {}) ]], { i(1, "n"), i(2, "infinity") }) ),

  sm({ trig = "sum", name = "Summation (Sigma)" },
    fmt(
      [[
      sum_(n={})^({}) {}
      ]],
      { i(1, "index"), i(2, "infinity"), d(3, get_visual) }
    )
  ),

  -- sm({ trig = "taylor", name = "Taylor series" },
  --   fmt(
  --     [[
  --       sum_({}={})^({}) {}_{} (x-a)^{} {}
  --     ]],
  --     { i(1, "k"), i(2, "0") , i(3, "infinity"), i(4, "c"), rep(1), rep(1), i(0) }
  --   )
  -- ),

  sm({ trig = "iint", name = "Integral", priority = 300 },
    fmt(
      [[
      integral_({})^({}) {} {}
      ]],
      { i(1, "-infinity"), i(2, "infinity"), d(3, get_visual), i(0) }
    )
  ),

  sm({ trig = "prod", name = "Product (Pi)" },
    fmt(
      [[
      product_({}={})^({}) {} {}
      ]],
      { i(1, "n"), i(2, "1"), i(3, "infinity"), d(4, get_visual), i(0) }
    )
  ),

  sm({ trig = "case", name = "Cases, Piecewise" },
    fmt(
      [[
      cases(
          {}
      ) {}
      ]],
      { i(1, "cases here"), i(0) }
    )
  ),

  -- Derivatives
  sm({ trig = "part", name = "Partial Derivative" }, fmt([[(diff {})/(diff {}) {}]], { i(1, "f"), i(2, "x"), i(0) }) ),
  sm({ trig = "pdf", name = "Partial Derivative" }, fmt([[(diff {})/(diff {}) {}]], { i(1, "f"), i(2, "x"), i(0) }) ),
  sm({ trig = "ddf", name = "Total Derivative" }, fmt([[(d {})/(d {}) {}]], { i(1, "f"), i(2, "x"), i(0) }) ),
  sm({ trig = "la+", name = "Laplace {Transform}" }, fmta([[cal(L) lr({ <> }) <>]], { i(1), i(0) }) ),
  sm({ trig = "lap", name = "Laplace (Transform)" }, fmta([[cal(L) lr(( <> )) <>]], { i(1), i(0) }) ),
  
  -- vectors
  sm({ trig = "cvec", name = "Column Vector" }, fmt([[vec({}_{}, dots.v, {}_{})]], { i(1, "x"), i(2, "1"), rep(1), i(3, "n") }) ),  

  -- Symbols
  sm({ trig = "del", name = "Nabla" }, { t("nabla ") } ),

  -- Sets
  sm({ trig = "notin", name = "Not In" }, { t("in.not ") } ),
  sm({ trig = "OO", name = "Empty Set" }, { t("emptyset ") } ),

  -- Miscellaneous
  sm({ trig = "...", name = "ldots", priority = 100 }, { t("#sym.dots.h") } ),
  sm({ trig = "tt", name = "Text" }, fmt([["{}" {}]], { i(1, "text here"), i(0) }) ),

-- ----------------------------------------------------------------------------

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
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "mk", name = "Insert inline math" },
    fmt([[${}${}{} ]], {
      i(1),
      f(function(args, snip)
          if args[1][1] and not string.match(args[1][1], "^[%.,%?%- ]") then
              return " "
          else
              return ""
          end
      end, {2}),
      i(2),
    })
  ),

  -- -------------- MATH snippets ---------------
  -- Subscripts
  sm(
    { trig = "(%a)(%d)", regTrig = true, name = "Auto-subscript 1D", dscr = "Auto-subscript with 1 digit" },
    fmt([[{}_{}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    })
  ),

  sm(
    { trig = "(%a)_(%d%d)", regTrig = true, name = "Auto-subscript 2D", dscr = "Auto-subscript for 2 digits" },
    fmt([[{}_({})]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    })
  ),

  sm(
    { trig = "(%a)_(%d%d)", regTrig = true, name = "Auto-subscript 2D", dscr = "auto subscript for 2+ digits" },
    fmt([[{}_({})]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    })
  ),

  postfixm(
    { trig = ".ts", name = "Text Subscript" },
    fmt([[{}_("{}") {}]], {
      d(1, function (_, parent)
        return sn(nil, {t("(" .. parent.env.POSTFIX_MATCH .. ")")})
      end),
      i(2, "subscript"),
      i(0)
    })
  ),

  sm({ trig = "__", name = "Subscript", wordTrig = false }, fmt([[({})_{} {}]], { d(1, get_visual), i(2), i(0) }) ),
  sm({ trig = "xnn", name = "x_n", wordTrig = false }, { t("x_n") } ),
  sm({ trig = "ynn", name = "y_n", wordTrig = false }, { t("y_n") } ),
  sm({ trig = "xmm", name = "x_m", wordTrig = false }, { t("x_m") } ),
  sm({ trig = "ymm", name = "y_m", wordTrig = false }, { t("y_m") } ),
  sm({ trig = "xii", name = "x_i", wordTrig = false }, { t("x_i") } ),
  sm({ trig = "yii", name = "y_i", wordTrig = false }, { t("y_i") } ),
  sm({ trig = "xjj", name = "x_j", wordTrig = false }, { t("x_j") } ),
  sm({ trig = "yjj", name = "y_j", wordTrig = false }, { t("y_j") } ),

  sm({ trig = "xp1", name = "x_(n+1)", wordTrig = false }, { t("x_(n+1)") } ),

  -- Superscripts
  sm({ trig = "sr", name = "(V) Square Root" }, fmt([[sqrt({}) {}]], { d(1, get_visual), i(0) }) ),
  postfixm({ trig = ".sr", name = "(W) Square Root", priority = 1001 }, {l("sqrt(" .. l.POSTFIX_MATCH .. ") ")} ),

  sm({ trig = "inv", name = "Inverse (^-1)", wordTrig = false }, { t("^(-1)") } ),
  sm({ trig = "sq", name = "Squared (^2)", wordTrig = false }, { t("^2") } ),
  sm({ trig = "cb", name = "Cubed (^3)", wordTrig = false }, { t("^3") } ),
  sm({ trig = "td", name = "To the Power of {exponent}", wordTrig = false }, fmt([[({})^{} {}]], { d(1, get_visual), i(2), i(0) }) ),

  sm({ trig = "compl", name = "Complement (^complement)", wordTrig = false }, { t("^complement") } ),

  -- Symbols
  sm(
    { trig = "==", name = "equals aligned" },
    fmt([[&= {} \]], { i(1) })
  ),

  sm({ trig = "xx", name = "Cross Product" }, { t("times ") } ),
  sm({ trig = "..", name = "Dot Product", priority = 100 }, { t("dot ") } ),

  -- Wraps/Surrounds
  -- sm({ trig = "upr", name = "Upright variant for single letters" }, fmt([[upright({}){}]], { d(1, get_visual), i(0) }) ),
  postfixm({ trig = ".up", name = "Upright variant for single letters" }, {l("upright(" .. l.POSTFIX_MATCH .. ") ")} ),
  sm({ trig = "cl", name = "Ceiling function" }, fmt([[ceil({}) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "fl", name = "Floor function" }, fmt([[floor({}) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "abs", name = "Absolute value" }, fmt([[abs({}) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "rnd", name = "Round-up function" }, fmt([[round({}) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "norm", name = "Norm function" }, fmt([[norm({}) {}]], { d(1, get_visual), i(0) }) ),

  -- Matrices
  sm({ trig = "pmat", name = "() Matrix" }, fmt([[mat(delim: "(", {}) {}]], { d(1, get_visual), i(0) }) ),
  sm({ trig = "bmat", name = "[] Matrix" }, fmt([[mat(delim: "[", {}) {}]], { d(1, get_visual), i(0) }) ),

  -- Derivatives
  sm({ trig = "ddx", name = "d/dx Total Derivative" }, fmt([[(d {})/(d x) {}]], { i(1, "y"), i(0) }) ),
  sm({ trig = "pdx", name = "d/dx Partial Derivative" }, fmt([[(diff {})/(diff x) {}]], { i(1, "y"), i(0) }) ),
  sm({ trig = "ddt", name = "d/dt Total Derivative" }, fmt([[(d {})/(d t) {}]], { i(1, "y"), i(0) }) ),
  sm({ trig = "pdt", name = "d/dt Partial Derivative" }, fmt([[(diff {})/(diff t) {}]], { i(1, "y"), i(0) }) ),

  -- Decorators: Over/Under
  sm({ trig = "hbar", name = "hbar" }, { t("planck.reduce") } ),
  sm(
    { trig = "(%a)bar", name = "Letter bars", regTrig = true },
    fmt([[overline({}) ]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  sm(
    { trig = "(%a)hat", name = "Letter hats", regTrig = true },
    fmt([[hat({}) ]], {
      f(function(_, snip)
        return snip.captures[1]
      end)
    })
  ),

  sm(
    { trig = "(%a),.", name = "Vectors", regTrig = true },
    fmt([[arrow({}) ]], {
      f(function(_, snip)
        return snip.captures[1]
      end)
    })
  ),

  sm(
    { trig = "(%a).,", name = "Vectors", regTrig = true },
    fmt([[arrow({}) ]], {
      f(function(_, snip)
        return snip.captures[1]
      end)
    })
  ),
}
