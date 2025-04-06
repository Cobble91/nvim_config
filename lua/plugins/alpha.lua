return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    local header = {
      "                                                                       ",
      "  ██████   █████                   █████   █████  ███                  ",
      " ░░██████ ░░███                   ░░███   ░░███  ░░░                   ",
      "  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ",
      "  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ",
      "  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ",
      "  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ",
      "  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ",
      " ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ",
      "                                                                       ",
    }

    vim.api.nvim_set_hl(0, "nvim_blue", {fg="#7db5fe"})
    vim.api.nvim_set_hl(0, "nvim_green", {fg="#a2e8af"})

    dashboard.section.header.val = header
    dashboard.section.header.opts = {
      position = "center",
      hl = {
        { {"nvim_blue",0, 1}, {"nvim_green",1,2} },
        { {"nvim_blue",0,56}, {"nvim_green",56,119} },
        { {"nvim_blue",0,60}, {"nvim_green",60,123} },
        { {"nvim_blue",0,82}, {"nvim_green",82,169} },
        { {"nvim_blue",0,92}, {"nvim_green",92,185} },
        { {"nvim_blue",0,90}, {"nvim_green",90,175} },
        { {"nvim_blue",0,86}, {"nvim_green",86,173} },
        { {"nvim_blue",0,90}, {"nvim_green",90,175} },
        { {"nvim_blue",0,78}, {"nvim_green",78,157} },
        { {"nvim_blue",0, 1}, {"nvim_green",1,2} },
      },
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
