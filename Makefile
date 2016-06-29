# shells
install:
	ln -s src/cfg/vim ~/.vim

vundle:
	mkdir -p bundle
	git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
