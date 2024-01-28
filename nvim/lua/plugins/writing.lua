return {
  {
    "dfendr/clipboard-image.nvim",
    keys = {
      { "<leader>ip", ":PasteImg<cr>", desc = "image paste" },
    },
    cmd = {
      "PasteImg",
    },
    config = function()
      require("clipboard-image").setup({
        typst = {
          img_dir = { "assets", "img" },
          img_dir_txt = "/assets/img",
          affix = '#image("%s")',
        },
      })
    end,
  },
}
