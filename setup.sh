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
rm lazygit.tar.gz
rm lazygit

# Create venvs
mkdir -p $HOME/.local/venvs
python3.12 -m venv $HOME/.local/venvs/ruff_venv/
python3.12 -m venv $HOME/.local/venvs/misc_venv/
$HOME/.local/venvs/ruff_venv/bin/python -m pip install ruff
$HOME/.local/venvs/misc_venv/bin/python -m pip install pyperclip

python3.12 -m venv $HOME/.local/venvs/debugpy_venv/
$HOME/.local/venvs/debugpy_venv/bin/python -m pip install debugpy pytest 

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# set default zsh
chsh -s $(which zsh)

# power10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# npm and pyright
sudo apt install -y npm
npm install -g pyright

$HOME/.local/venvs/misc_venv/bin/python $HOME/Documents/Misc/configs/clone_nvim_extensions.py
$HOME/.local/venvs/misc_venv/bin/python $HOME/Documents/Misc/configs/treesitter_install.py

# Media Installation
sudo apt install -y mpv
sudo apt install -y yt-dlp
sudo -v ; curl https://rclone.org/install.sh | sudo bash
