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

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

handler = logging.StreamHandler()
handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s: %(message)s', datefmt="%H:%M")
handler.setFormatter(formatter)
logger.addHandler(handler)

dest_folder = f"{os.environ['HOME']}/.local/share/nvim/lazy"
extension_urls = {
    "https://github.com/windwp/nvim-autopairs": ("68f0e5c3dab23261a945272032ee6700af86227a", None),
    "https://github.com/kylechui/nvim-surround": ("ae298105122c87bbe0a36b1ad20b06d417c0433e", None),
    "https://github.com/nvim-telescope/telescope.nvim": ("78857db9e8d819d3cc1a9a7bdc1d39d127a36495", None),
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim": ("2a5ceff981501cff8f46871d5402cd3378a8ab6a", None),
    "https://github.com/nvim-tree/nvim-tree.lua": ("1020869742ecb191f260818234517f4a1515cfe8", None),
    "https://github.com/nvim-tree/nvim-web-devicons": ("1020869742ecb191f260818234517f4a1515cfe8", None),
    "https://github.com/stevearc/conform.nvim": ("8ed162b0637d4c4f69ebe3e8e49b35662a82e137", None),
    "https://github.com/neovim/nvim-lspconfig": ("7af2c37192deae28d1305ae9e68544f7fb5408e1", None),
    "https://github.com/nvim-treesitter/nvim-treesitter": ("00a513f87ee3c339c2024b08db3eb63ba7736ed6", None),
    "https://github.com/nvim-neotest/nvim-nio": ("21f5324bfac14e22ba26553caf69ec76ae8a7662", None),
    "https://github.com/mfussenegger/nvim-dap": ("52302f02fea3a490e55475de52fa4deb8af2eb11", None),
    "https://github.com/mfussenegger/nvim-dap-python": ("34282820bb713b9a5fdb120ae8dd85c2b3f49b51", None),
    "https://github.com/mfussenegger/nvim-dap": ("bc81f8d3440aede116f821114547a476b082b319", None),
    "https://github.com/mfussenegger/nvim-dap-python": ("34282820bb713b9a5fdb120ae8dd85c2b3f49b51", None),
    "https://github.com/rcarriga/nvim-dap-ui": ("bc81f8d3440aede116f821114547a476b082b319", None),
    "https://github.com/L3MON4D3/LuaSnip": ("c9b9a22904c97d0eb69ccb9bab76037838326817", None),
    "https://github.com/saadparwaiz1/cmp_luasnip": ("98d9cb5c2c38532bd9bdb481067b20fea8f32e90", None),
    "https://github.com/rafamadriz/friendly-snippets": ("efff286dd74c22f731cdec26a70b46e5b203c619", None),
    "https://github.com/hrsh7th/cmp-nvim-lua": ("f12408bdb54c39c23e67cab726264c10db33ada8", None),
    "https://github.com/hrsh7th/cmp-nvim-lsp": ("99290b3ec1322070bcfb9e846450a46f6efa50f0", None),
    "https://github.com/hrsh7th/cmp-buffer": ("3022dbc9166796b644a841a02de8dd1cc1d311fa", None),
    "https://github.com/hrsh7th/cmp-path": ("91ff86cd9c29299a64f968ebb45846c485725f23", None),
    "https://github.com/hrsh7th/cmp-cmdline": ("d250c63aa13ead745e3a40f61fdd3470efde3923", None),
    "https://github.com/jpalardy/vim-slime": ("9bc2e13f8441b09fd7352a11629a4da0ea4cb058", None),
    "https://github.com/folke/lazy.nvim": ("ac21a639c7ecfc8b822dcc9455deceea3778f839", None),
    "https://github.com/akinsho/toggleterm.nvim": ("e76134e682c1a866e3dfcdaeb691eb7b01068668", None),
    "https://github.com/hrsh7th/nvim-cmp": ("12509903a5723a876abd65953109f926f4634c30", None),
    "https://github.com/akinsho/bufferline.nvim": ("655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3", None),
    "https://github.com/catppuccin/nvim": ("0b2437bcc12b4021614dc41fcea9d0f136d94063", "catppuccin-nvim"),
    "https://github.com/goolord/alpha-nvim": ("de72250e054e5e691b9736ee30db72c65d560771", None),
    "https://github.com/folke/persistence.nvim": ("f6aad7dde7fcf54148ccfc5f622c6d5badd0cc3d", None),
    "https://github.com/abecodes/tabout.nvim": ("9a3499480a8e53dcaa665e2836f287e3b7764009", None),
    "https://github.com/nvim-lua/plenary.nvim": ("857c5ac632080dba10aae49dba902ce3abf91b35", None),
    "https://github.com/nvim-lualine/lualine.nvim": ("f4f791f67e70d378a754d02da068231d2352e5bc", None),
    "https://github.com/ibhagwan/fzf-lua": ("0a3b70feb05879a8001c51f7a2a42fa52a9e552c", None),
    "https://github.com/sindrets/diffview.nvim": ("4516612fe98ff56ae0415a259ff6361a89419b0a", None),
    "https://github.com/nanozuki/tabby.nvim": ("c119c91f3ada1a7c62ca2d10685ac8a3e2928fb8", None),
    "https://github.com/tpope/vim-fugitive": ("4a745ea72fa93bb15dd077109afbb3d1809383f2", None),
}

def clone_extensions(extension_urls: dict, overwrite: bool | list = False) -> None:
    """

    Parameters
    ----------
    `extension_urls (dict)`: dictionary where the key is the url for the extension to clone and the value is a list of length two where the first element is the commit id and the second is the name of the extension. To keep the same name as github repo set to None, this is not possible in cases where a '/' is part of the name e.g. 'catppuccin/nvim'

    `overwrite (bool | list)`: whether to overwrite extensions if they've already been cloned. True will overwrite all extensions provided - can also provide a list where the values are extenion url you want to overwrite

    Return
    ------
    `None`

    """
    if not isinstance(overwrite, (bool, list)):
        raise TypeError("overwrite must be a boolean or a list of extension urls, see docstrings.")
    elif overwrite is True:
        overwrite = list(extension_urls.keys())
    elif overwrite is False:
        overwrite = []

    
        

    for url, (commit_id, name) in extension_urls.items():
        if name is not None:
            extension = name
        else:
            extension = url.split('/')[-1]

        dest_path = f"{dest_folder}/{extension}"


        if url in overwrite and os.path.exists(dest_path):
            logger.info(f"{extension} exists and will be overwritten")
            shutil.rmtree(dest_path)

        if not os.path.exists(dest_path):
            logger.info(f"Cloning {extension} - checked out at {commit_id}")
            os.system(f"git clone {url} {dest_path} && cd {dest_path} && git switch -c {commit_id}")
        else: 
            logger.info(f"'{extension}' exists in {dest_folder}")

        if extension == "telescope-fzf-native.nvim":
            logger.info(f"Building (via make) {extension}")
            os.system("make -C ~/.local/share/nvim/lazy/telescope-fzf-native.nvim/")

if __name__ == "__main__":
    clone_extensions(extension_urls, overwrite=True)
