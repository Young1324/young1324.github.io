# Docker 开发环境快速上手

## 前置要求

- Docker 20.10+
- Docker Compose 2.0+

## 快速开始

### 1. 启动开发环境

```bash
docker-compose up -d --build
```

### 2. 访问网站

打开浏览器访问：http://localhost:4000

### 3. 查看日志

```bash
docker-compose logs -f
```

### 4. 停止容器

```bash
docker-compose down
```

## 开发体验

- **实时同步**：在宿主机编辑代码，容器内会自动检测变化
- **热重载**：使用 `--livereload` 配置，保存文件后浏览器自动刷新
- **增量构建**：使用 `--incremental` 加快构建速度

## 常用命令

### 进入容器终端

```bash
docker-compose exec jekyll bash
```

### 重新构建镜像

```bash
docker-compose build --no-cache
```

### 清理所有资源

```bash
docker-compose down -v --rmi all
```

## 端口说明

- `4000`：Jekyll 开发服务器
- `35729`：LiveReload 服务

## 卷挂载配置

- `.` → `/app`：代码实时同步
- `/app/node_modules`：避免 node_modules 被宿主机覆盖
- `/app/vendor/bundle`：Ruby gems 缓存
- `/app/_site`：构建输出目录
