
# we want to install everything in home, want this to work irrespective of perms

bkp_path=$HOME/config_install_backup

mkdir -p $HOME/local/bin
mkdir -p $HOME/.config
mkdir -p $bkp_path

# 
#wget https://github.com/neovim/neovim/releases/stable/downloads/nvim.appimage -P/local/bin
#chmod +x $HOME/local/bin/nvim.appimage

# todo: ensure releveant dirs do or do not exist, want to reaplce these files.
# buut do a backup first. 

if [ -f "$HOME/.tmux.conf" ]; then
	mv $HOME/.tmux.conf $bkp_path/
fi
if [ -f "$HOME/.bashrc.conf" ]; then
	mv $HOME/.bashrc $bkp_path/
fi

if [ -e "$HOME/.config/nvim" ]
then
	mv $HOME/.config/nvim $bkp_path/
else
	mkdir -p $HOME/.config
fi

ln -s $PWD/.tmux.conf $HOME/.tmux.conf
ln -s $PWD/.bashrc $HOME/.bashrc 
ln -s $PWD/nvim $HOME/.config/nvim 

source $HOME/.bashrc



# needed packages on whatever sys
#
# https://github.com/sharkdp/fd
# https://github.com/BurntSushi/ripgrep



# install packer 
# todo: handle this in lua isntead 
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

