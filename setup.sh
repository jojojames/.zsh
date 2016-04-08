#!/bin/bash

if [ ! -f $HOME/.z ];
then
    echo "creating $HOME/.z file"
    touch $HOME/.z
fi

if [ -f $HOME/.zshrc ];
then
    echo "moving $HOME/.zshrc to $HOME/.zshrc_backup"
    mv $HOME/.zshrc $HOME/.zshrc_backup
fi

if [ -f $HOME/.zshenv ];
then
    echo "moving $HOME/.zshenv to $HOME/.zshenv_backup"
    mv $HOME/.zshenv $HOME/.zshenv_backup
fi

echo "linking $HOME/.zsh/zshrc to $HOME/.zshrc"
ln -s $HOME/.zsh/.zshrc $HOME/.zshrc
echo "linking $HOME/.zsh/zshenv to $HOME/.zshenv"
ln -s $HOME/.zsh/.zshenv $HOME/.zshenv
