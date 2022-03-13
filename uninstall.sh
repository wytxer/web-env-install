#!/bin/bash

# 建一个备份目录
cd ~ && mkdir wy-backup

# 备份配置文件
cd ~ && cp .bash_profile .zshrc ~/wy-backup
echo "配置文件已备份到 ~/wy-backup 目录下"

# 卸载
cd ~ && rm -rf .nvm .bash_profile .zshrc .oh-my-zsh

echo "卸载成功"
