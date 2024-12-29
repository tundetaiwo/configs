local TS_folder = vim.fn.stdpath("data") .. "/treesitter/"
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- NOTE: YOU NEED TO RUN `TSInstall THE PARSER`

require'nvim-treesitter.configs'.setup{
  parser_install_dir = TS_folder,
}

vim.opt.runtimepath:prepend(TS_folder)

parser_config.python = {
  install_info = {
    url = TS_folder .. "tree-sitter-python", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
}
parser_config.lua = {
  install_info = {
    url = TS_folder .. "tree-sitter-lua", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  -- filetype = "lua", -- if filetype does not match the parser name
}

parser_config.rust = {
  install_info = {
    url = TS_folder .. "tree-sitter-rust", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
}

parser_config.toml = {
  install_info = {
    url = TS_folder .. "tree-sitter-toml",
    files = {"src/parser.c", "src/scanner.c"},
  },
}

parser_config.bash = {
  install_info = {
    url = TS_folder .. "tree-sitter-bash",
    files = {"src/parser.c", "src/scanner.c"},
  },
}

parser_config.dockerfile = {
  install_info = {
    url = TS_folder .. "tree-sitter-dockerfile",
    files = {"src/parser.c", "src/scanner.c"},
  },
}

parser_config.comment = {
  install_info = {
    url = TS_folder .. "tree-sitter-comment",
    files = {"src/parser.c", "src/scanner.c"},
  },
}


parser_config.yaml = {
  install_info = {
    url = TS_folder .. "tree-sitter-yaml",
    files = {"src/parser.c", "src/scanner.c"},
  },
}
