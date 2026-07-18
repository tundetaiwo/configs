"""
This script is meant to be used when setting neovim. Neovim configuration
is for offline files so this script clones all extension to where they are
meant to be

If a folder name is different to what is clone such as catppuccin-nvim you
can set a value in the extension_urls dictionary to choose the folder name

NOTE: plenary might need github credentials in which case it's easier to just
download zip file from github repo
"""

# fmt: off
import os
import logging
import shutil
from argparse import ArgumentParser
from dataclasses import dataclass
from git import Repo

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

handler = logging.StreamHandler()
handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s: %(message)s', datefmt="%H:%M")
handler.setFormatter(formatter)
logger.addHandler(handler)
dest_folder = f"{os.environ['HOME']}/.local/share/nvim/lazy"


@dataclass
class Extension:
    name: str  
    url: str
    commit_id: str
    Notes: str | None = ""
    disable: bool = False

extensions_list = [
    Extension(
        name="nvim-autopairs",
        url="https://github.com/windwp/nvim-autopairs",
        commit_id="68f0e5c3dab23261a945272032ee6700af86227a",
    ),
    Extension(
        name="nvim-surround",
        url="https://github.com/kylechui/nvim-surround",
        commit_id="ae298105122c87bbe0a36b1ad20b06d417c0433e",
    ),
    Extension(
        name="telescope.nvim",
        url="https://github.com/nvim-telescope/telescope.nvim",
        commit_id="3333a52ff548ba0a68af6d8da1e54f9cd96e9179",
    ),
    Extension(
        name="telescope-fzf-native.nvim",
        url="https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        commit_id="2a5ceff981501cff8f46871d5402cd3378a8ab6a",
    ),
    Extension(
        name="nvim-tree.lua",
        url="https://github.com/nvim-tree/nvim-tree.lua",
        commit_id="v1.15.0",
    ),
    Extension(
        name="nvim-web-devicons",
        url="https://github.com/nvim-tree/nvim-web-devicons",
        commit_id="1020869742ecb191f260818234517f4a1515cfe8",
    ),
    Extension(
        name="conform.nvim",
        url="https://github.com/stevearc/conform.nvim",
        commit_id="8ed162b0637d4c4f69ebe3e8e49b35662a82e137",
    ),
    Extension(
        name="nvim-lspconfig",
        url="https://github.com/neovim/nvim-lspconfig",
        commit_id="7af2c37192deae28d1305ae9e68544f7fb5408e1",
    ),
    Extension(
        name="nvim-treesitter",
        url="https://github.com/nvim-treesitter/nvim-treesitter",
        commit_id="v0.10.0",
    ),
    Extension(
        name="nvim-nio",
        url="https://github.com/nvim-neotest/nvim-nio",
        commit_id="21f5324bfac14e22ba26553caf69ec76ae8a7662",
    ),
    Extension(
        name="nvim-dap",
        url="https://github.com/mfussenegger/nvim-dap",
        commit_id="0.10.0",
    ),
    Extension(
        name="nvim-dap-python",
        url="https://github.com/mfussenegger/nvim-dap-python",
        commit_id="1808458eba2b18f178f990e01376941a42c7f93b",
    ),
    Extension(
        name="nvim-dap-ui",
        url="https://github.com/rcarriga/nvim-dap-ui",
        commit_id="cf91d5e2d07c72903d052f5207511bf7ecdb7122",
    ),
    Extension(
        name="LuaSnip",
        url="https://github.com/L3MON4D3/LuaSnip",
        commit_id="c9b9a22904c97d0eb69ccb9bab76037838326817",
    ),
    Extension(
        name="cmp_luasnip",
        url="https://github.com/saadparwaiz1/cmp_luasnip",
        commit_id="98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
    ),
    Extension(
        name="friendly-snippets",
        url="https://github.com/rafamadriz/friendly-snippets",
        commit_id="efff286dd74c22f731cdec26a70b46e5b203c619",
    ),
    Extension(
        name="cmp-nvim-lua",
        url="https://github.com/hrsh7th/cmp-nvim-lua",
        commit_id="f12408bdb54c39c23e67cab726264c10db33ada8",
    ),
    Extension(
        name="cmp-nvim-lsp",
        url="https://github.com/hrsh7th/cmp-nvim-lsp",
        commit_id="99290b3ec1322070bcfb9e846450a46f6efa50f0",
    ),
    Extension(
        name="cmp-buffer",
        url="https://github.com/hrsh7th/cmp-buffer",
        commit_id="3022dbc9166796b644a841a02de8dd1cc1d311fa",
    ),
    Extension(
        name="cmp-path",
        url="https://github.com/hrsh7th/cmp-path",
        commit_id="91ff86cd9c29299a64f968ebb45846c485725f23",
    ),
    Extension(
        name="cmp-cmdline",
        url="https://github.com/hrsh7th/cmp-cmdline",
        commit_id="d250c63aa13ead745e3a40f61fdd3470efde3923",
    ),
    Extension(
        name="vim-slime",
        url="https://github.com/jpalardy/vim-slime",
        commit_id="9bc2e13f8441b09fd7352a11629a4da0ea4cb058",
    ),
    Extension(
        name="lazy.nvim",
        url="https://github.com/folke/lazy.nvim",
        commit_id="ac21a639c7ecfc8b822dcc9455deceea3778f839",
    ),
    Extension(
        name="toggleterm.nvim",
        url="https://github.com/akinsho/toggleterm.nvim",
        commit_id="e76134e682c1a866e3dfcdaeb691eb7b01068668",
    ),
    Extension(
        name="nvim-cmp",
        url="https://github.com/hrsh7th/nvim-cmp",
        commit_id="12509903a5723a876abd65953109f926f4634c30",
    ),
    Extension(
        name="bufferline.nvim",
        url="https://github.com/akinsho/bufferline.nvim",
        commit_id="655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3",
    ),
    Extension(
        name="catppuccin-nvim",
        url="https://github.com/catppuccin/nvim",
        commit_id="beaf41a30c26fd7d6c386d383155cbd65dd554cd",
    ),
    Extension(
        name="alpha-nvim",
        url="https://github.com/goolord/alpha-nvim",
        commit_id="de72250e054e5e691b9736ee30db72c65d560771",
    ),
    Extension(
        name="persistence.nvim",
        url="https://github.com/folke/persistence.nvim",
        commit_id="f6aad7dde7fcf54148ccfc5f622c6d5badd0cc3d",
    ),
    Extension(
        name="tabout.nvim",
        url="https://github.com/abecodes/tabout.nvim",
        commit_id="9a3499480a8e53dcaa665e2836f287e3b7764009",
    ),
    Extension(
        name="plenary.nvim",
        url="https://github.com/nvim-lua/plenary.nvim",
        commit_id="857c5ac632080dba10aae49dba902ce3abf91b35",
    ),
    Extension(
        name="lualine.nvim",
        url="https://github.com/nvim-lualine/lualine.nvim",
        commit_id="47f91c416daef12db467145e16bed5bbfe00add8",
    ),
    Extension(
        name="fzf-lua",
        url="https://github.com/ibhagwan/fzf-lua",
        commit_id="0a3b70feb05879a8001c51f7a2a42fa52a9e552c",
    ),
    Extension(
        name="diffview.nvim",
        url="https://github.com/sindrets/diffview.nvim",
        commit_id="4516612fe98ff56ae0415a259ff6361a89419b0a",
    ),
    Extension(
        name="tabby.nvim",
        url="https://github.com/nanozuki/tabby.nvim",
        commit_id="c119c91f3ada1a7c62ca2d10685ac8a3e2928fb8",
    ),
    Extension(
        name="gitsigns.nvim",
        url="https://github.com/lewis6991/gitsigns.nvim",
        commit_id="6668f379ca634c36b8e11453118590b91bf8b295",
    ),
    Extension(
        name="gruvbox.nvim",
        url="https://github.com/ellisonleao/gruvbox.nvim",
        commit_id="cc202a7c5e5ffca06f92a04073275dec371cbfe3",
    ),
    Extension(
        name="nvim-treesitter-context",
        url="https://github.com/nvim-treesitter/nvim-treesitter-context",
        commit_id="v1.0.0",
    ),
    Extension(
        name="auto-session",
        url="https://github.com/rmagatti/auto-session",
        commit_id="292492ab7af4bd8b9e37e28508bc8ce995722fd5",
    ),
    Extension(
        name="harpoon",
        url="https://github.com/ThePrimeagen/harpoon",
        commit_id="87b1a3506211538f460786c23f98ec63ad9af4e5",
        Notes="Working commit of harpoon2"
    ),
    Extension(
        name="nvim-dap-virtual-text",
        url="https://github.com/theHamsta/nvim-dap-virtual-text",
        commit_id="fbdb48c2ed45f4a8293d0d483f7730d24467ccb6",
    ),
    Extension(
        name="codecompanion.nvim",
        url="https://github.com/olimorris/codecompanion.nvim",
        commit_id="dfb0ca928c439b65b1ac33758d90a9bc49c72138",
        disable=True
    ),
    Extension(
        name="moltern-nvim",
        url="https://github.com/benlubas/molten-nvim",
        commit_id="4fd7be6a12b5efda5179db642f13bad60893acca",
        disable=True
    ),
    Extension(
        name="image.nvim",
        url="https://github.com/benlubas/molten-nvim",
        commit_id="446a8a5cc7a3eae3185ee0c697732c32a5547a0b",
        disable=True
    ),
    Extension(
        name="csvview.nvim",
        url="https://github.com/hat0uma/csvview.nvim",
        commit_id="8d068c526ab5ade68226de036d533298cd93a399",
    ),
]

# --  easily retrieve object -- #
extensions_dict = {extension.name: extension for extension in extensions_list}

def parse_overwrite(overwrite: str) -> list[str] | bool:
    if isinstance(overwrite, str):
        match overwrite.lower():
            case "true":
                return True
            case "false":
                return False
            case _:
                ext_to_overwrite = overwrite.split(sep=";")
                return [ext.strip() for ext in ext_to_overwrite]

def setup_cli():
    parser = ArgumentParser(prog="clone_nvim")
    parser.add_argument("--overwrite", default=False, required=False, type=parse_overwrite)
    parser.add_argument("--verbose", action="store_true", default=False, required=False)
    return parser.parse_args()

def clone_extensions(extensions: list[Extension], overwrite: bool | list[str] = False, verbose: bool = False) -> None:
    """
    Parameters
    ----------
    `extensions`: list of extension objects to clone. Note that the name of the folder 
        is defined by the name attribute of the extension object.
    `overwrite (bool | list)`: Provide a list of 

    Examples
    --------
    overwrite parameter should be a list 

    Return
    ------
    `None`
    """

    if overwrite is True:
        overwrite = [extension.name for extension in extensions]
    elif overwrite is False :
        overwrite = []


    for ext in extensions:
        if ext.disable:
            logger.info("%s is disabled, skipping...", ext.name)
            continue
        dest_path = f"{dest_folder}/{ext.name}"

        if ext.name in overwrite and os.path.exists(dest_path):
            logger.info(f"{ext.name} exists and will be overwritten")
            shutil.rmtree(dest_path)

        if not os.path.exists(dest_path):
            logger.info(f"Cloning {ext.name} - checked out at {ext.commit_id}")
            repo = Repo.clone_from(url=ext.url, to_path=dest_path)

            repo.git.checkout(ext.commit_id)
        else: 
            if verbose:
                logger.info(f"'{ext.name}' exists in {dest_folder}")

        if ext.name == "telescope-fzf-native.nvim":
            logger.info(f"Building (via make) {ext.name}")
            os.system("make -C ~/.local/share/nvim/lazy/telescope-fzf-native.nvim/")


if __name__ == "__main__":
    args = setup_cli()
    overwrite = args.overwrite
    verbose = args.verbose
    clone_extensions(extensions_list, overwrite=overwrite, verbose=verbose)

