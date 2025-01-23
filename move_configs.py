import os
import shutil
from os import PathLike
from pathlib import Path
import getpass
import logging
from argparse import ArgumentParser

# --  Logger Config -- #
logger = logging.getLogger(__name__)
handler = logging.StreamHandler()
handler.setFormatter(
    logging.Formatter(
        "{asctime} - {levelname}: {message}",
        style="{",
        datefmt="%H:%M:%S",
    )
)
logger.addHandler(handler)

PROJECT_PATH = Path(__file__).parent
HOME_PATH = os.environ["HOME"]

parser = ArgumentParser()


parser.add_argument(
    "-a",
    "--app",
    required=True,
    help="application we want configuration file for, see notes section for all configs supported",
)
parser.add_argument(
    "-m",
    "--machine",
    required=True,
    help="type of machine i.e. 'Windows', 'Mac', 'Unix'",
)

cli_args = parser.parse_args()


def _replace(
    being_replaced: PathLike | str,
    replacing_with: PathLike | str,
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
    _being_replaced: Path = Path(being_replaced).expanduser()
    _replacing_with: Path = Path(replacing_with).expanduser()

    if update:
        _being_replaced, _replacing_with = _replacing_with, _being_replaced

    if folder:
        replace_fn = shutil.copytree
        del_fn = shutil.rmtree
    else:
        replace_fn = shutil.copyfile
        del_fn = os.remove

    if _being_replaced.exists():
        del_flag = input(f"{_being_replaced} exists, do you want to overwrite? (Y/N)")

        if del_flag.lower() in ["y", "yes"]:
            del_fn(_being_replaced)
        else:
            print("Exiting Function...")

    # create folders if they don't exist

    if not _being_replaced.parent.exists():
        os.makedirs(_being_replaced.parent)

    replace_fn(_replacing_with, _being_replaced)


def move_configs(app: str, machine: str, update: bool = False):
    """
    Function to retrieve or place certain configs on a machine


    Parameters
    ----------
    `app (str)`: application we want configuration file for, see notes section for all configs supported
    `machine (str)`: type of machine i.e. "Windows", "Mac", "Unix"
    `update (bool)`: whether to update config(s) stored in repository with config(s) on current machine

    Notes
    -----
    Configs Supported:
    * zshrc (with power10k)
    * bashrc
    * vimrc
    * nvim (tunvim)
    * tmux
    * code (keybindings)
    * gitconfig
    * windows terminal
    * iterm2
    """

    valid_apps = [
        "all",
        "zshrc",
        "bashrc",
        "vimrc",
        "nvim",
        "gitconfig",
        "tmux",
        "code",
        "gitconfig",
        "windows_terminal",
        "iterm2",
    ]
    valid_machines = ["unix", "mac", "wsl", "windows"]

    if app.lower() not in valid_apps:
        raise NotImplementedError(f"{app} is not yet implemented. Please choose from one of: \n{'\n'.join(valid_apps)}")

    if machine.lower() not in valid_machines:
        raise NotImplementedError(f"{machine} is not yet implemented. Please choose from one of: {valid_machines}")

    if app.lower() in ["nvim", "neovim", "all"]:
        being_replaced = f"{HOME_PATH}/.config/nvim/"
        replacing_with = f"{PROJECT_PATH}/nvim"

        _replace(
            being_replaced=being_replaced,
            replacing_with=replacing_with,
            folder=True,
            update=update,
        )

    if app.lower() in ["bash", "bashrc", "all"]:
        if machine in ["mac", "unix", "wsl"]:
            being_replaced = f"{HOME_PATH}/.bashrc"
            replacing_with = f"{PROJECT_PATH}/dotfiles/.bashrc"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )

    if app.lower() in ["zsh", "zshrc", "all"]:
        if machine in ["mac", "unix", "wsl"]:
            being_replaced = f"{HOME_PATH}/.zshrc"
            replacing_with = f"{PROJECT_PATH}/dotfiles/.zshrc"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )

    if app.lower() in ["vim", "vimrc", "all"]:
        if machine in ["mac", "unix", "wsl"]:
            being_replaced = f"{HOME_PATH}/.vimrc"
            replacing_with = f"{PROJECT_PATH}/dotfiles/.vimrc"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )

    if app.lower() in ["all", "tmux"]:
        if machine.lower() in ["wsl", "unix", "mac"]:
            being_replaced = f"{HOME_PATH}/.config/tmux/tmux.conf"
            replacing_with = f"{PROJECT_PATH}/tmux/tmux.conf"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )

    if app.lower() in ["vscode", "code", "all"]:
        if machine.lower() == "mac":
            being_replaced = (
                f"{HOME_PATH}/Library/Application Support/Code/User/keybindings.json"
            )
            replacing_with = f"{PROJECT_PATH}/code/keybindings.json"

            _replace(
                being_replaced=being_replaced,
                replacing_with=replacing_with,
                folder=False,
                update=update,
            )
        else:
            logger.warning("VS Code configs only implemented for mac os.")

    if app.lower() in ["all", "git"]:
        if machine.lower() in ["unix", "mac", "wsl"]:
            being_replaced = f"{HOME_PATH}/.gitconfig"
            replacing_with = f"{PROJECT_PATH}/dotfiles/.gitconfig"
        elif machine.lower() in ["windows"]:
            username = getpass.getuser()
            being_replaced = f"C:/Users/{username}/.gitconfig"
            replacing_with = f"{PROJECT_PATH}/dotfiles/.gitconfig"

        _replace(
            being_replaced=being_replaced,
            replacing_with=replacing_with,
            folder=False,
            update=update,
        )

    if app.lower() in ["all", "iterm2"]:
        if machine.lower() in ["mac"]:
            being_replaced = (
                f"{HOME_PATH}/Library/Preferences/com.googlecode.iterm2.plist"
            )
            replacing_with = f"{PROJECT_PATH}/iterm2.plist"
        else:
            logger.warning(f"{machine} is not supported for iterm2.")

    if app.lower() in ["app", "windows_terminal"]:
        if machine.lower() in [
            "mac",
        ]:
            logger.warning(f"{machine} is not supported for windows terminal.")
        else:
            user = getpass.getuser()
            being_replaced = f"C:/Users/{user}/AppData/Local/Microsoft/Windows Terminal/settings.json"
            replacing_with = f"windows_settings.json"


if __name__ == "__main__":
    move_configs(
        app=cli_args.app,
        machine=cli_args.machine,
        update=False,
    )
