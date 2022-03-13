# Web env install

Web 前端开发环境安装脚本。[文章地址](https://wytxer.github.io/2022/03/12/web-env-install/)

> 注意，该脚本仅适配了 Mac 系统，且适用于重装环境或第一次安装，其他场景下执行可能会有报错~


## 目录说明

```bash
.
├── README.md
├── install.sh      # 环境安装脚本
├── restore.sh      # 恢复 uninstall.sh 的内容
└── uninstall.sh    # 卸载已有的环境依赖
```


## 使用

```bash
# 卸载已有依赖
sh ./uninstall.sh

# 安装依赖
sh ./install.sh

# 恢复
sh ./restore.sh
```
