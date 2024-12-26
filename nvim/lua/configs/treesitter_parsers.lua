local TS_folder = "/Users/tundetaiwo/.local/share/lazy/treesitter/"
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

require'nvim-treesitter.configs'.setup{
  parser_install_dir = TS_folder,
}
vim.opt.runtimepath:prepend("TS_folder")

parser_config.python = {
  install_info = {
    url = TS_folder .. "tree-sitter-python", -- local path or git repo
    -- url = "/Users/tundetaiwo/.local/share/nvim/treesitter/tree-sitter-python",
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  -- filetype = "py", -- if filetype does not match the parser name
}
parser_config.lua = {
  install_info = {
    url = TS_folder .. "tree-sitter-lua", -- local path or git repo
    -- url = "/Users/tundetaiwo/.local/share/nvim/treesitter/tree-sitter-lua",
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  filetype = "python", -- if filetype does not match the parser name
}

parser_config.rust = {
  install_info = {
    url = TS_folder .. "tree-sitter-rust", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  filetype = "rust", -- if filetype does not match the parser name
}

parser_config.toml = {
  install_info = {
    url = TS_folder .. "tree-sitter-toml", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  filetype = "toml", -- if filetype does not match the parser name
}
