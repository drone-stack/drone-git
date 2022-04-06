# git使用指南

> ysicing/drone-plugin-git

## 参数

- PLUGIN_DEBUG
- PLUGIN_PROXY 为空不使用代理, 支持clash混合代理
- PLUGIN_DEPTH 默认1
- PLUGIN_DIR 默认.
- PLUGIN_URL 仓库地址
- PLUGIN_BRANCH 分支
- PLUGIN_SUBMODULE 是否更新子模块

## 测试

```bash
docker run -it --rm -e "PLUGIN_DEBUG=true" -e "PLUGIN_URL=git.local:ysicing/drone-plugins.git" ysicing/drone-plugin-git
```
