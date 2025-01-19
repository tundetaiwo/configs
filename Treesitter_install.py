"""
This Scirpt is for setting up neovim and installs all the required treesitter files
"""
# fmt: off
import os
import subprocess

TS_PATH = f"{os.environ['HOME']}/.local/share/nvim//treesitter/"

TS_URLS = [
        "https://github.com/tree-sitter/tree-sitter-python",
        "https://github.com/tree-sitter-grammars/tree-sitter-lua",
        "https://github.com/tree-sitter/tree-sitter-rust",
        "https://github.com/tree-sitter-grammars/tree-sitter-toml",
        "https://github.com/tree-sitter/tree-sitter-bash",
        "https://github.com/camdencheek/tree-sitter-dockerfile",
        "https://github.com/stsewd/tree-sitter-comment",
        "https://github.com/tree-sitter-grammars/tree-sitter-yaml",
        ]


for url in TS_URLS:
    ts_name = url.split('/')[-1]

    install_path = f"{TS_PATH}/{ts_name}"
    if not os.path.exists(install_path):
        subprocess.run(["git", "clone", url, install_path])
    else:
        print(f"{install_path} exists, skipping {ts_name}.")

