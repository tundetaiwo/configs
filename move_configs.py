import shutil
from pathlib import Path

PROJECT_PATH = Path(__file__).parent


def move_configs(app: str, machine: str, update: bool = False):
    """
    Function to retrieve or place certain configs on a machine


    Notes
    -----
    Configs Supported:
    * neovim/custom
    * zshrc
    """
    if app.lower() in ["nvim", "neovim", "all"] and machine in ["mac", "unix"]:
        # Where do configs live on machine
        native_dir: Path = Path("~/.config/nvim/lua/custom")
        config_dir: Path = Path(f"{PROJECT_PATH}/custom")

        if update is True:
            dir_to_replace = config_dir
            dir_to_move = native_dir
        elif update is False:
            dir_to_replace = native_dir
            dir_to_move = config_dir

        if dir_to_replace.exists():
            del_flag = input(f"{dir_to_replace} exists, do you want to delete? (Y/N)")

            if del_flag.lower() in ["y", "yes"]:
                shutil.rmtree(dir_to_replace)
            else:
                print("Exiting function.")
                return 0
        shutil.copytree(dir_to_move, dir_to_replace)


if __name__ == "__main__":
    move_configs(
        app=,
        machine=,
        update=False,
    )
