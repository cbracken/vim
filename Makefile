# shells
install:
	ln -s src/cfg/vim ~/.vim

vundle:
	mkdir -p bundle
	git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
