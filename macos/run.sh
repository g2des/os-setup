
brew install k9s wget

# Setup Vim
mkdir -p ~/.vim/pack/themes/start
wget https://raw.githubusercontent.com/g2des/os-setup/main/macos/.vimrc  -P ~
cd ~/.vim/pack/themes/start
git clone https://github.com/tomasiser/vim-code-dark

