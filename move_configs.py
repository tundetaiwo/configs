import os
import shutil
from os import PathLike
from pathlib import Path
import getpass


PROJECT_PATH = Path(__file__).parent


def _replace(
    being_replaced: PathLike,
    replacing_with: PathLike,
    folder: bool,
    update: bool,
) -> None:
    """
    Function that replaces a file/folder with another file/folder

    Parameters
    ----------
    `being_replaced (PathLike)`: file/folder we are replacing
    `replacing_wtih (PathLike)`: file/folder we are using to replace
    `folder (bool)`: Flag whether replacing a folder or a singular file
    `update (bool)`: whether to update config(s) stored in repository with config(s) on current machine

    Return
    ------
    `None`

    """
    being_replaced: Path = Path(being_replaced).expanduser()
    replacing_with: Path = Path(replacing_with).expanduser()

    if update:
        being_replaced, replacing_with = replacing_with, being_replaced

    if folder:
        replace_fn = shutil.copytree
        del_fn = shutil.rmtree
    else:
        replace_fn = shutil.copyfile
        del_fn = os.remove

    if being_replaced.exists():
        del_flag = input(f"{being_replaced} exists, do you want to delete? (Y/N)")

        if del_flag.lower() in ["y", "yes"]:
            del_fn(being_replaced)
        else:
            print("Exiting Function...")
            return 0

    replace_fn(replacing_with, being_replaced)


def move_configs(app: str, machine: str, update: bool = False):
    """
    Function to retrieve or place certain configs on a machine


    Parameters
    ----------
    `app (str)`: application we want configuration file for e.g. vs code, tmux, zsh etc.
    `machine (str)`: type of machine i.e. "Windows", "Mac", "Unix"
    `update (bool)`: whether to update config(s) stored in repository with config(s) on current machine

    Notes
    -----
    Configs Supported:
    * neovim/custom
    * zshrc/power10k
    * tmux
    * vs code
    * git
    """

    if app.lower() in [
        "zsh",
        "zshrc",
        "all",
        "tmux",
        "vs code",
        "code",
    ] and machine not in ["unix", "mac", "darwin"]:
        raise NotImplementedError(f"{machine} is not yet implemented.")

    if app.lower() in ["nvim", "neovim", "all"]:
        if machine in ["mac", "unix"]:
            being_replaced = "~/.config/nvim/lua/custom"
            replacing_with = f"{PROJECT_PATH}/custom"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=True,
                update=update,
            )

    if app.lower() in ["zsh", "zshrc", "all"]:
        if machine in ["mac", "unix", "darwin"]:
            being_replaced = "~/.zshrc"
            replacing_with = f"{PROJECT_PATH}/.zshrc"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )

    if app.lower() == "tmux":
        if machine.lower() == "mac":
            being_replaced = "~/.config/tmux/tmux.conf"
            replacing_with = f"{PROJECT_PATH}/tmux/tmux.conf"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )

    if app.lower() in ["vscode", "code", "all"]:
        if machine.lower() == "mac":
            being_replaced = "~/Library/Application Support/Code/User/keybindings.json"
            replacing_with = f"{PROJECT_PATH}/code/keybindings.json"

        _replace(
            being_replaced=being_replaced,
            replacing_with=replacing_with,
            folder=False,
            update=update,
        )

    if app.lower() in ["all", "git"]:
        if machine.lower() in ["unix", "mac", "darwin"]:
            being_replaced = "~/.gitconfig"
            replacing_with = f"{PROJECT_PATH}/.gitconfig"
        elif machine.lower() in ["windows"]:
            username = getpass.getuser()
            being_replaced = f"C:/Users/{username}/.gitconfig"
            replacing_with = f"{PROJECT_PATH}/.gitconfig"
        else:
            raise ValueError(f"{machine} is not supported.")

        _replace(
            being_replaced=being_replaced,
            replacing_with=replacing_with,
            folder=False,
            update=update,
        )


if __name__ == "__main__":
    move_configs(
        app="vscode",
        machine="mac",
        update=True,
    )
