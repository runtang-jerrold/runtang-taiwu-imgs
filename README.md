# 太吾绘卷 Mod 静态图床 (GitHub Pages)

**用途**: 给 Steam Workshop 描述提供永久 HTTPS + ASCII 图片 URL(避开中文 URL 解析坑)

---

## URL 结构(版本化路径 · 永久不变)

```
https://runtang.github.io/runtang-taiwu-imgs/v<版本号>/<分类>/<文件名>.jpg
```

**当前已部署示例**:

| 图 | URL |
|---|---|
| v1.0.0.5 主图(三栏) | `https://runtang.github.io/runtang-taiwu-imgs/v1.0.0.5/主图/Mod展示图_small.jpg` |
| v1.0.0.5 祛除玄灰主图 | `https://runtang.github.io/runtang-taiwu-imgs/v1.0.0.5/主图/祛除玄灰主图_small.jpg` |
| v1.0.0.5 详情页 | `https://runtang.github.io/runtang-taiwu-imgs/v1.0.0.5/详情页/详情页_small.jpg` |
| v0.0.3.0 入魔值主图(本次新增) | `https://runtang.github.io/runtang-taiwu-imgs/v0.0.3.0/主图/入魔值主图-v0.0.3.0_small.jpg` |

**永久性保障**:
- 每个 Mod 版本用独立子目录 `v<版本号>/`,旧 URL 永不变
- 新版本用新子目录,绝不覆盖旧的
- Steam 描述里引用的 URL 即使图被换掉,只要文件名不变,玩家看到的还是当时那张

---

## 当前内容

```
v1.0.0.5/
├── 主图/
│   ├── Mod展示图_small.jpg         (三栏横版 1920×1080,身龄/生育/强制服食)
│   └── 祛除玄灰主图_small.jpg      (单功能横版 1920×1080,伏虞断柄瑶光)
└── 详情页/
    └── 详情页_small.jpg            (超长竖版 6 段,我的无敌返老还童丹大人呀)

v0.0.3.0/                             ← 2026-07-29 新增
└── 主图/
    └── 入魔值主图-v0.0.3.0_small.jpg  (入魔值功能宣传图,427 KB,贴纸风)
```

---

## 一次性部署步骤

### 1. 在 GitHub 建仓库
- 打开 https://github.com/new
- **Repository name**: `runtang-taiwu-imgs`(ASCII 短名,以后改不动)
- **Public**(必须,GitHub Pages 公共仓库才免费)
- 不要勾 "Initialize with README"(我们本地有了)
- 点 Create repository

### 2. 准备 Personal Access Token(用于 push)
- 打开 https://github.com/settings/tokens
- Generate new token (classic)
- 勾选 `repo` 权限
- 生成后**复制 token 字符串**(只显示一次)

### 3. 跑一键 push 脚本
- 双击 `push_to_github.bat`
- 第一次会要求输入 GitHub 用户名 + token(用户名已默认 `runtang`,回车即可)
- 后续 push 自动跳过认证(token 缓存)
- 完成后打开 https://github.com/runtang/runtang-taiwu-imgs/settings/pages
- Source 选 `main` 分支 / `/ (root)` → Save
- 等 1-2 分钟,GitHub Pages 上线,会显示访问 URL

### 4. 验证
- 浏览器打开首页 URL,看到图片即部署成功
- 在 Steam 描述里用 `[img]<完整 URL>[/img]`,Workshop 会渲染

---

## 后续工作流(新版本)

```
每出一个新 Mod 版本:
  1. 创建 static-hosting\v<新版本号>\ 子目录
  2. 把新图拷贝进去(按 主图/详情页/ 分类)
  3. 双击 push_to_github.bat
  4. 新版本 URL 立刻可用,旧版本 URL 永久保留
```

**重要规则**:
- ❌ 不要修改已发布版本的文件(URL 永久不变)
- ❌ 不要删除已发布版本的子目录(历史版本追溯)
- ✅ 新版本永远新建子目录,绝不覆盖

---

## 故障排查

| 问题 | 解决 |
|---|---|
| GitHub Pages 404 | 检查 repo 是否 Public;等 5 分钟(GH Pages 部署延迟) |
| 图片不显示 | 检查 URL 是否有中文(必须是纯 ASCII) |
| push 失败认证 | token 过期,重新生成 PAT |
| 想要自定义域名 | repo Settings → Pages → Custom domain |