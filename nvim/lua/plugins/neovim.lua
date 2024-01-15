return {
  {
    -- Neovim GUI plugin/shim
    "equalsraf/neovim-gui-shim",
    lazy = false,
  },

  {
    -- Switch between workspaces
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = true,
      detection_methods = { "pattern" },
      patterns = { ".git", "Makefile", "makefile", "justfile", "requirements.txt" },
    },
    event = "VeryLazy",
    config = function(_, opts)  
      require("project_nvim").setup(opts)
      require("lazyvim.util").on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },

  -- dashboard to greet
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set headers

      dashboard.section.header.val = {
        [[██╗    ██╗ ██████╗ ███╗   ██╗██████╗ ███████╗██████╗ ██╗  ██╗ ██████╗ ██╗   ██╗██╗]],
        [[██║    ██║██╔═══██╗████╗  ██║██╔══██╗██╔════╝██╔══██╗██║  ██║██╔═══██╗╚██╗ ██╔╝██║]],
        [[██║ █╗ ██║██║   ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝███████║██║   ██║ ╚████╔╝ ██║]],
        [[██║███╗██║██║   ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗██╔══██║██║   ██║  ╚██╔╝  ╚═╝]],
        [[╚███╔███╔╝╚██████╔╝██║ ╚████║██████╔╝███████╗██║  ██║██║  ██║╚██████╔╝   ██║   ██╗]],
        [[ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝]],
      }

      -- -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
        dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
        dashboard.button("c", " " .. " Config",          "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit Neovim",            "<cmd> qa <cr>"),
      }
      -- dashboard.section.buttons.val = {
      -- 	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      -- 	dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
      -- 	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
      -- 	dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h<cr>"),
      -- 	dashboard.button("q", "󰅚  > Quit NVIM", ":qa<CR>"),
      -- }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.header.opts.hl = "AlphaHeader"
      -- dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      
      -- local fortune = require("alpha.fortune")
      -- dashboard.section.footer.val = fortune({
      --   fortune_list = {
      --     { "You otter be proud of yourself!", "", "— 🦦" },
      --     { "Hello from the otter slide!", "", "— Otterdele" },
      --     { "To otter space!", "", "— 🦦" },
      --     { "What if I say I'm not like the otters?", "", "— Foo Fighters" },
      --   },
      -- })

      -- Send config to alpha
      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local startup_time = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
          
          local fortune = require("alpha.fortune")
          dashboard.section.footer.val = fortune({
            fortune_list = {
              { startup_time, "", "⚡ You otter be proud of yourself!", "⚡", "⚡ —🦦" },
              { startup_time, "", "⚡ Hello from the otter slide!", "⚡", "⚡ —Otterdele" },
              { startup_time, "", "⚡ To otter space!", "⚡", "⚡ —🦦" },
              { startup_time, "", "⚡ What if I say I'm not like the otters?", "⚡", "⚡ —Foo Fighters" },
            },
          })

          pcall(vim.cmd.AlphaRedraw)
        end,
      })

    end,
  },
}
