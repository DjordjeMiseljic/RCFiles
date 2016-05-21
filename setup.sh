#!/bin/bash

echo "Setup started"
#COPY GIT FILES
if [ -a ./.git-completion.bash ]
then
	echo "git-completion copied to home"
	cp .git-completion.bash ~
else
	echo "git-completion copy_error"
fi
if [ -a ./.gitconfig ]
then
	echo "gitconfig copied to home"
	cp .gitconfig ~
else
	echo "gitconfig copy_error"
fi

#DOWNLOAD VIM8
echo "Installing VIM8"
add-apt-repository ppa:jonathonf/vim
apt update
apt install vim

#COPY VIMRC
if [ -a ~/.vimrc ]
then
	echo ".vimrc already in home"
else
	cp .vimrc ~
	echo "vimrc copied to home"
fi

#MAKE VIM DIRECTORY
if [ -d ~/.vim ]
then
	echo "~/.vim dir already in home"
else
	mkdir ~/.vim
	echo "~/.vim dir created"
fi

#MAKE COLORS DIRECTORY
if [ -d ~/.vim/colors ]
then
	echo "~/.vim/colors dir already in home"
else
	mkdir ~/.vim/colors
	echo "~/.vim/colors dir created"
fi

#COPY COSTUM COLOR
if [ -a ./oceanblack256.vim ]
then
	cp oceanblack256.vim ~/.vim/colors
	echo "costum color added"
else
	echo "color file copy error"
fi


#MAKE COLORS DIRECTORY
if [ -d ~/.vim/bundle ]
then
	echo "~/.vim/bundle dir already in home"
else
	mkdir ~/.vim/bundle
	echo "~/.vim/bundle dir created"
fi

export GIT_SSL_NO_VERIFY=1
git config --global http.sslverify false
#CLONE VUNDLE
if [ -d ~/.vim/bundle/Vundle.vim ]
then
	echo "Vundle already exists"
else
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	echo "Vundle cloned"
fi

#OPEN VIM
echo "Install other plugins"
vim -c PluginInstall
vim -c q!
