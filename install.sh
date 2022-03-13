#!/bin/bash

echo "> 脚本加载中..."

# 安装 ZSH
if hash zsh 2>/dev/null; then
  echo "> ZSH 已存在"
else
  echo "> 开始安装 ZSH..."
  # 可能会遇到报错：curl: (35) LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to raw.githubusercontent.com:443，推荐使用 gitee 的
  # sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
  # ZSH 国内
  sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)" "" --unattended
fi

# 安装 NVM
if [ -f "${HOME}/.nvm/nvm.sh" ]; then
  echo "> NVM 已存在"
else
  # 备份全局的 npm 包
  if hash npm 2>/dev/null; then
    echo "> 开始备份全局的 NPM 包..."
    packInfo=$(npm ls -g --depth=0)
    index=0
    npmPackages=()
    for name in ${packInfo}
      do
        if (echo ${name} | grep -q "@"); then
          npmPackages[$index]=${name}
          let index++
        fi
      done
    echo "  删除全局 node_modules 目录"
    rm -rf /usr/local/lib/node_modules
    echo "  删除 Node.js"
    rm /usr/local/bin/node
    echo "  删除 Node.js 模块注册的软链"
    cd  /usr/local/bin && ls -l | grep "../lib/node_modules/" | awk '{print $9}'| xargs rm
  fi

  echo "> 开始安装 NVM..."
  curl -o- https://gitee.com/mirrors/nvm/raw/master/install.sh | bash
  echo "  配置 NVM"
  echo "" >> ~/.zshrc
  echo "# NVM" >> ~/.zshrc
  echo "export NVM_DIR=\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"" >> ~/.zshrc
  echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"" >> ~/.zshrc

  source ~/.nvm/nvm.sh
  echo "  安装 Node.js 16.10.0"
  nvm install 16.10.0
  echo "  使用 Node.js 16.10.0"
  nvm use 16.10.0
  echo "  将 16.10.0 设置成默认版本"
  nvm alias default v16.10.0
fi

# 安装 NRM
if hash nrm 2>/dev/null; then
  echo "> NRM 已存在"
else
  echo "> 开始安装 NRM..."
  npm i nrm -g
fi

# 安装 Yarn
if hash yarn 2>/dev/null; then
  echo "> Yarn 已存在"
else
  echo "> 开始安装 Yarn..."
  npm i yarn -g
fi

# 安装之前已有的全局 Node.js 包
if [ ${#npmPackages[*]} -gt 0 ]; then
  echo "> 正在安装之前已有的全局 Node.js 包..."
  eval "npm i ${npmPackages[*]} -g"
fi

echo "> 环境初始化完成~"
