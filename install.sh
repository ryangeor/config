# we want to install everything in home, want this to work irrespective of perms
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

bkp_path=$HOME/config_install_backup

mkdir -p $HOME/local/bin
mkdir -p $HOME/.config
mkdir -p $bkp_path
 
#wget https://github.com/neovim/neovim/releases/stable/downloads/nvim.appimage -P/local/bin
#chmod +x $HOME/local/bin/nvim.appimage
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

ln -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -s $SCRIPT_DIR/.bashrc $HOME/.bashrc 
ln -s $SCRIPT_DIR/nvim $HOME/.config/nvim 
# todo: script dir
ln -s $SCRIPT_DIR/zellij $HOME/.config/zellij 

source $HOME/.bashrc

# needed packages on whatever sys
# https://github.com/sharkdp/fd
# https://github.com/BurntSushi/ripgrep
