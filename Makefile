# shells
install:
	ln -s src/cfg/vim ~/.vim

vundle:
	mkdir -p bundle
	git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim

vim_plug:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
