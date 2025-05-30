sudo add-apt-repository ppa:deadsnakes/ppa  # repo for python
sudo apt update

# Install fundamentals
sudo apt install -y git 
sudo apt install -y vim-gtk  # won't work for wsh
sudo apt install -y tmux
sudo apt install -y zsh
sudo apt install -y gcc
sudo apt install -y make 
sudo apt install -y ripgrep
sudo apt install -y fd-find
sudo apt install -y p7zip-full p7zip-rar

# Install Python
sudo apt install -y python3.10 python3.11 python3.12
sudo apt install -y python3.10-venv python3.11-venv python3.12-venv

# Install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# Lua Language Server
curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.13.6/lua-language-server-3.13.6-linux-x64.tar.gz
mkdir $HOME/.local/share/lua-language-server/
tar -C $HOME/.local/share/lua-language-server/ -xzf lua-language-server-3.13.6-linux-x64.tar.gz
rm lua-language-server-3.13.6-linux-x64.tar.gz

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -LO lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz
rm lazygit

# Create venvs
mkdir -p $HOME/.local/venvs
python3.12 -m venv $HOME/.local/venvs/misc_venv/
$HOME/.local/venvs/misc_venv/bin/python -m pip install ruff pyperclip

python3.12 -m venv $HOME/.local/venvs/debugpy_venv/
$HOME/.local/venvs/debugpy_venv/bin/python -m pip install debugpy pytest 


# Install npv and subsequently npm & pyright
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
sudo npm install -g pyright

$HOME/.local/venvs/misc_venv/bin/python $HOME/Documents/Misc/configs/clone_nvim_extensions.py
make -C $HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim/
$HOME/.local/venvs/misc_venv/bin/python $HOME/Documents/Misc/configs/treesitter_install.py


# Media Installation
sudo apt install -y mpv
sudo apt install -y fuse3
$HOME/.local/venvs/misc_venv/bin/python -m pip install yt-dlp
sudo -v ; curl https://rclone.org/install.sh | sudo bash

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# power10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
