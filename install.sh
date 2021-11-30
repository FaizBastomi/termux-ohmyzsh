#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage

RED='\033[0;31m'
GRN='\033[0;32m'
CY='\033[0;36m'
NC='\033[0m'

apt update
apt install -y git zsh neofetch

echo -e "${GRN}Cloning ${CY}termux-ohmyzsh${NC}"
git clone https://github.com/Cabbagec/termux-ohmyzsh.git "$HOME/termux-ohmyzsh" --depth 1 --quiet

echo -e "${GRN}Backup ${CY}.termux${GRN} folder${NC}"
mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
echo -e "${GRN}Copy ${CY}termux${GRN} folder from termux-ohmyzsh${NC}"
cp -R "$HOME/termux-ohmyzsh/.termux" "$HOME/.termux"
echo -e "${RED}Deleting motd...${NC}"
rm $HOME/../usr/etc/motd

echo -e "${GRN}Cloning ${CY}oh-my-zsh${GRN} repository${NC}"
git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1 --quiet
mv "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"
sed -i '/^ZSH_THEME/d' "$HOME/.zshrc"
sed -i '1iZSH_THEME="agnoster"' "$HOME/.zshrc"

echo -e "${GRN}Adding alias...${NC}"
echo "alias chcolor='$HOME/.termux/colors.sh'" >> "$HOME/.zshrc"
echo "alias chfont='$HOME/.termux/fonts.sh'" >> "$HOME/.zshrc"
echo "alias pkgin='pkg install'" >> "$HOME/.zshrc"
echo "alias pkgrm='pkg uninstall'" >> "$HOME/.zshrc"
echo "alias pkgcc='pkg clean'" >> "$HOME/.zshrc"
echo "alias pkgup='pkg update -y'" >> "$HOME/.zshrc"
echo "neofetch --ascii_distro 'Gentoo'" >> "$HOME/.zshrc"

echo -e "${GRN}Cloning ${CY}zsh-syntax-highlighting${NC}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

chsh -s zsh

echo -e "${GRN}oh-my-zsh${NC} install complete!\nChoose your color scheme now~"
$HOME/.termux/colors.sh

echo "Choose your font now~"
$HOME/.termux/fonts.sh

echo "Please restart Termux app..."

exit
