"""
This script is meant to be used when setting neovim. Neovim configuration 
is for offline files so this script clones all extension to where they are 
meant to be

If a folder name is different to what is clone such as catppuccin-nvim you
can set a value in the extension_urls dictionary to choose the folder name
"""

import os
import subprocess

dest_folder = f"{os.environ['HOME']}/.local/share/nvim/lazy"
extension_urls = {
    "https://github.com/windwp/nvim-autopairs": "",
    "https://github.com/kylechui/nvim-surround: """
    "https://github.com/nvim.lua/plenary.nvim": "",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim": "",
    "https://github.com/kylechui/nvim-surround": "",
    "https://github.com/nvim-tree/nvim-tree.lua": "",
    "https://github.com/nvim-tree/nvim-web-devicons": "",
    "https://github.com/stevearc/conform.nvim": "",
    "https://github.com/nvim-treesitter/nvim-treesitter: """
    "https://github.com/nvim-neotest/nvim-nio": "",
    "https://github.com/rcarriga/nvim-dap-ui": "",
    "https://github.com/mfussenegger/nvim-dap": "",
    "https://github.com/mfussenegger/nvim-dap-python": "",
    "https://github.com/mfussenegger/nvim-dap: """
    "https://github.com/mfussenegger/nvim-dap-python": "",
    "https://github.com/rcarriga/nvim-dap-ui": "",
    "https://github.com/L3MON4D3/LuaSnip": "",
    "https://github.com/saadparwaiz1/cmp_luasnip": "",
    "https://github.com/hrsh7th/cmp-nvim-lua": "",
    "https://github.com/hrsh7th/cmp-nvim-lsp": "",
    "https://github.com/hrsh7th/cmp-buffer: """
    "https://github.com/hrsh7th/cmp-path": "",
    "https://github.com/jpalardy/vim-slime": "",
    "https://github.com/folke/lazy.nvim": "",
    "https://github.com/akinsho/toggleterm.nvim": "",
    "https://github.com/hrsh7th/nvim-cmp": "",
    "https://github.com/akinsho/bufferline.nvim": "",
    "https://github.com/catppuccin/nvim": "catppuccin-nvim",
    "https://github.com/goolord/alpha-nvim": "",
    "https://github.com/folke/persistence.nvim": "",
    "https://github.com/abecodes/tabout.nvim": "",
}

for url, name in extension_urls.items():
    if name:
        extension = name
    else:
        extension = url.split('/')[-1]

    dest_path = f"{dest_folder}/{extension}"
    if not os.path.exists(dest_path):
        print(f"Cloning {extension}")
        subprocess.run(["git", "clone", url, dest_path])
    else: 
        print(f"'{extension}' exists in {dest_folder}")
    
