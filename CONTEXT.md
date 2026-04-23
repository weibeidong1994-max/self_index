# Self Index — 开发上下文备忘

> 由 Kimi Code 生成于 2026-04-21，2026-04-23 更新 GitHub 部署信息。下次打开项目时，先读此文件恢复上下文。

---

## 1. 项目概况

- **名称**：个人主页（Self Index）
- **路径**：`/Users/weibeidongm2/Documents/vibecoding/self_index`
- **定位**：商业化产品经理 & AI-native 产品从业者的个人品牌展示站点
- **技术栈**：Astro 5.x + Tailwind CSS v4 + TypeScript（无 React/Vue）

---

## 2. 一键命令

```bash
cd /Users/weibeidongm2/Documents/vibecoding/self_index

# 开发模式（热重载）
npm run dev           # http://localhost:4321

# 生产构建
npm run build         # 输出到 dist/

# 独立后台服务（关闭终端仍可访问）
./serve.sh start      # http://localhost:6789
./serve.sh stop       # 停止服务
./serve.sh status     # 查看状态
./serve.sh restart    # 重启服务
```

---

## 3. 项目结构速查

```
├── public/
│   ├── favicon.svg
│   ├── images/avatar.svg                    ← 头像占位图
│   └── images/projects/{paos,hermes,multi-agent}-cover.svg
├── src/
│   ├── content/
│   │   ├── config.ts                        ← 3 个集合 Schema
│   │   ├── projects/                        ← 作品 Markdown（3 个）
│   │   ├── articles/                        ← 文章 Markdown（2 个）
│   │   └── roadmap/                         ← 迭代计划 Markdown（3 个）
│   ├── layouts/
│   │   ├── BaseLayout.astro                 ← 全局布局（Header + Footer + 暗色模式脚本）
│   │   └── MarkdownLayout.astro             ← 详情页布局（prose 排版）
│   ├── components/
│   │   ├── Header.astro                     ← 响应式导航栏（含汉堡菜单）
│   │   ├── Footer.astro
│   │   ├── HeroSection.astro                ← 个人简介区
│   │   ├── ProjectCard.astro
│   │   ├── ArticleList.astro
│   │   ├── RoadmapCard.astro
│   │   └── ThemeToggle.astro                ← 暗色/亮色切换（localStorage）
│   ├── pages/
│   │   ├── index.astro                      ← 首页，getCollection() 聚合 4 个板块
│   │   ├── projects/[...slug].astro         ← 作品详情动态路由
│   │   ├── articles/[...slug].astro         ← 文章详情动态路由
│   │   └── roadmap/[...slug].astro          ← 迭代计划详情动态路由
│   └── styles/global.css                    ← Tailwind v4 入口 + dark 变体定义
├── serve.sh                                 ← 独立进程托管脚本（nohup + python3）
├── astro.config.mjs                         ← Astro 配置（base 已设为 /self_index 适配 GitHub Pages）
├── package.json
└── tsconfig.json
```

---

## 4. 当前运行状态

- **本地后台服务**：✅ 运行中（PID: 15394）
- **本地访问地址**：http://localhost:6789/
- **GitHub 仓库**：https://github.com/weibeidong1994-max/self_index
- **GitHub Pages 线上地址**：https://weibeidong1994-max.github.io/self_index/
- **部署方式**：`gh-pages` 分支纯静态托管（无 GitHub Actions，本地构建后推送）

---

## 5. GitHub 部署指南

### 部署原理

1. 源码保存在 `main` 分支（包含 Astro 源码、Markdown 内容、配置等）
2. 执行 `npm run build` 生成 `dist/` 目录（纯静态 HTML/CSS/JS）
3. 将 `dist/` 目录内容推送到 `gh-pages` 分支
4. GitHub Pages 从 `gh-pages` 分支读取并托管
5. `dist/` 根目录已放置 `.nojekyll` 文件，防止 Jekyll 过滤 `_astro/` 目录

### 更新流程（对我说一声即可）

你修改了网页项目代码或 `src/content/` 下的 Markdown 文档后，告诉我，我会执行以下步骤同步到 GitHub：

```bash
# 1. 进入项目目录
cd /Users/weibeidongm2/Documents/vibecoding/self_index

# 2. 重新构建（生成最新 dist/）
npm run build

# 3. 提交源码到 main 分支
git add .
git commit -m "更新内容描述"
git push origin main

# 4. 推送构建产物到 gh-pages 分支
cd dist
git init
git add .
git commit -m "Deploy"
git push git@github.com:weibeidong1994-max/self_index.git HEAD:gh-pages --force
```

### 我也可以自行更新吗？

可以。如果你本地有 Kimi CLI，直接说"把 self_index 最新修改推送到 GitHub"即可。如果你有终端权限，也可以手动执行上面的命令。

---

## 6. 内容维护方式（零代码更新）

所有动态内容均来自 `src/content/` 下的 Markdown 文件，新增/修改 `.md` 文件后重新构建即可上线。

### 新增一篇作品

```bash
# 1. 创建文件（Frontmatter 必须符合 config.ts Schema）
cat > src/content/projects/my-new-project.md << 'EOF'
---
title: "新项目"
description: "一句话简介"
cover: "/images/projects/my-new-project-cover.svg"
order: 4
date: 2026-05-01
tags: ["AI"]
---

## 项目概述

正文内容...
EOF

# 2. 重新构建并同步到 GitHub（告诉我即可）
```

### 新增一篇文章

```bash
cat > src/content/articles/my-new-article.md << 'EOF'
---
title: "新文章标题"
date: 2026-05-01
tags: ["AI", "设计"]
summary: "文章摘要..."
---

正文内容...
EOF

# 重新构建并同步到 GitHub（告诉我即可）
```

### 新增一个迭代计划

```bash
cat > src/content/roadmap/my-new-plan.md << 'EOF'
---
title: "v3.0 计划"
description: "计划简介"
status: "规划中"          # 规划中 | 进行中 | 已完成
date: 2026-05-01
related_project: "paos"   # 可选，关联作品 slug
---

正文内容...
EOF

# 重新构建并同步到 GitHub（告诉我即可）
```

**重要**：修改 Markdown 或代码后，务必告诉我推送到 GitHub，仅本地 `npm run build` 不会更新线上网站。

---

## 7. 已实现的关键功能

| 功能 | 状态 |
|---|---|
| 首页 4 大板块（简介/作品/文章/迭代计划） | ✅ |
| Content Collections + Markdown 驱动 | ✅ |
| 动态路由详情页（getStaticPaths + [...slug]） | ✅ |
| 暗色模式（class 策略 + localStorage） | ✅ |
| 移动端响应式（汉堡菜单 + 1→2→3 列网格） | ✅ |
| 独立后台进程（serve.sh） | ✅ |
| SVG 占位图（头像 + 3 作品头图） | ✅ |
| GitHub Pages 线上部署 | ✅ |

---

## 8. 注意事项

- **Tailwind v4** 使用 CSS-first 配置（`@import "tailwindcss"` + `@theme`），不再依赖 `tailwind.config.mjs`
- 暗色模式默认开启（`html class="dark"`），但 inline script 会根据 `localStorage.theme` 或系统偏好自动修正
- `npm run dev` 与 `./serve.sh start` 是两套独立服务，开发时用前者，预览/长期托管用后者
- 修改代码后若 `./serve.sh` 未自动更新，需手动 `npm run build && ./serve.sh restart`
- **GitHub Pages 路径**：`astro.config.mjs` 中 `base: '/self_index'` 已配置，组件中使用 `import.meta.env.BASE_URL` 拼接资源路径，确保图片/favicon/CSS 正确加载
- **`.nojekyll`**：gh-pages 分支根目录必须包含此空文件，否则 Jekyll 会忽略 `_astro/` 目录导致 CSS 404
