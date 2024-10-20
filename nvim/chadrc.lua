-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	-- theme = "catppuccin",
  -- theme="tokyonight",
  -- theme="vscode_dark",
  transparency = true,
  -- hl_override = {
  --   -- Comment = {italic=true, }
  -- }
}

  M.term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.5, vsp = 0.4, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.1,
      col = 0.15,
      width = 0.75,
      height = 0.75,
      border = "single",
    },
  }
return M
