gitconfig:
  ./.justfile.d/gitconfig.sh

# shells: gitconfig
#   ./.justfile.d/SmartLink.py ./.justfile.d/shells.yaml

symlink:
   ./.justfile.d/SmartLink.py ./.justfile.d/smartlink.yaml

# termux: shells
#   ./.justfile.d/SmartLink.py ./.justfile.d/termux.yaml
#   ./.justfile.d/termux.sh

windows:
  ./.justfile.d/windows.ps1
  # @just shells
  ./.justfile.d/SmartLink.py ./.justfile.d/smartlink.yaml
  # ./.justfile.d/msys2.sh
  

# sync:
#   ./sync_repo.sh
#
# arch: linux
#   ./Setup/Linux/arch.sh
#
# wsl: linux
#   ./.justfile.d/wsl.sh
#
# smart:
#   ./.justfile.d/smart.sh

adnauseam:
  make -C ./Common/AdNauseam

[working-directory: 'Common/ddg-autoconsent']
ddg-autoconsent:
  npm install
  npm run prepublish

grub:
  ./Linux/grub-themes/Elegant-grub2-themes/install.sh

plymouth:
  sudo cp -r ./Linux/plymouth-themes/* /usr/share/plymouth/themes/
