# Docker 镜像加速器配置指南

## 问题分析

您遇到的错误是因为无法从 Docker Hub 拉取镜像（连接超时），这在中国大陆很常见。

## 解决方案

### 方案一：配置 Docker 镜像加速器（推荐）

请执行以下命令（需要 sudo 权限）：

```bash
# 1. 创建 Docker 配置目录（如果不存在）
sudo mkdir -p /etc/docker

# 2. 创建或编辑 daemon.json 配置文件
sudo tee /etc/docker/daemon.json > /dev/null << 'EOF'
{
  "registry-mirrors": [
    "https://docker.m.daocloud.io",
    "https://docker.1panel.live",
    "https://docker.1ms.run",
    "https://dockerhub.icu"
  ],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}
EOF

# 3. 重启 Docker 服务
sudo systemctl daemon-reload
sudo systemctl restart docker

# 4. 验证配置
docker info
```

### 方案二：使用代理（如果有可用的代理）

如果您有 HTTP/HTTPS 代理，可以配置 Docker 使用代理：

```bash
# 创建 Docker 服务配置目录
sudo mkdir -p /etc/systemd/system/docker.service.d

# 创建代理配置文件
sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf > /dev/null << 'EOF'
[Service]
Environment="HTTP_PROXY=http://your-proxy:port"
Environment="HTTPS_PROXY=http://your-proxy:port"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF

# 重启 Docker
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### 方案三：使用已有的 .devcontainer 配置

由于您的项目已经有 .devcontainer 配置，也可以直接使用 VS Code Dev Containers 扩展来开发。

## 验证配置

配置完成后，运行以下命令验证：

```bash
# 检查 Docker 信息，应该能看到 Registry Mirrors
docker info | grep -A 10 "Registry Mirrors"

# 测试拉取一个简单镜像
docker pull hello-world
```

## 重新构建项目

配置完成后，重新运行：

```bash
docker compose up -d --build
```

## 常用国内镜像源

- DaoCloud: `https://docker.m.daocloud.io`
- 1Panel: `https://docker.1panel.live`
- 1ms: `https://docker.1ms.run`
- DockerHub.ICU: `https://dockerhub.icu`
- 阿里云（需注册）: `https://<your-code>.mirror.aliyuncs.com`
