sudo add-apt-repository ppa:deadsnakes/ppa  # repo for python
sudo apt update

# Install fundamentals
sudo apt install -y git 
sudo apt install -y vim-gtk
sudo apt install -y tmux
sudo apt install -y zsh
sudo apt install -y gcc
sudo apt install -y make 
sudo apt install -y ripgrep

# Install Python
sudo apt install -y python3.10 python3.11 python3.12
sudo apt install -y pipx
pipx install poetry==1.8.0

# Install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Create venvs
mkdir -p $HOME/.local/venvs
python3.12 -m venv $HOME/.local/venvs/ruff_venv/
$HOME/.local/venvs/ruff_venv/bin/python -m pip install ruff
$HOME/.local/venvs/ruff_venv/bin/python -m pip install pyperclip

python3.12 -m venv $HOME/.local/venvs/debugpy_venv/
$HOME/.local/venvs/debugpy_venv/bin/python -m pip install debugpy pytest 
