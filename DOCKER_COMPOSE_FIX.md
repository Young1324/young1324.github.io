# Docker Compose 问题解决方案

## 问题原因

在较新的 Docker 版本中，Docker Compose 已经从独立的 `docker-compose` 命令迁移为 Docker CLI 的插件，使用 `docker compose` 命令（注意中间是空格，不是连字符）。

## 解决方案

### 方法一：直接使用新命令（推荐）

将所有 `docker-compose` 命令替换为 `docker compose`：

```bash
# 旧命令（不再工作）
docker-compose up -d --build

# 新命令（推荐使用）
docker compose up -d --build
```

### 方法二：创建永久命令别名

我已经为您在以下配置文件中添加了别名：

- `~/.bashrc` - Bash shell
- `~/.zshrc` - Zsh shell

要使别名在当前终端生效，请运行：

```bash
# 如果使用 Bash
source ~/.bashrc

# 如果使用 Zsh
source ~/.zshrc
```

然后就可以继续使用 `docker-compose` 命令了：

```bash
docker-compose up -d --build
```

## 验证 Docker Compose 是否正常工作

```bash
# 检查版本
docker compose version

# 或使用别名
docker-compose version
```

## 常用命令对照表

| 旧命令 | 新命令 |
|--------|--------|
| `docker-compose up -d` | `docker compose up -d` |
| `docker-compose down` | `docker compose down` |
| `docker-compose logs -f` | `docker compose logs -f` |
| `docker-compose build` | `docker compose build` |
| `docker-compose ps` | `docker compose ps` |
