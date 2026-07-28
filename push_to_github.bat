@echo off
chcp 65001 >nul
setlocal

REM ============================================================
REM   GitHub Pages 静态图床 - 一键 push 脚本
REM   用途:把 static-hosting/ 目录下的所有图推送到 GitHub
REM   首次运行需要输入 GitHub 用户名 + Personal Access Token
REM ============================================================

cd /d "%~dp0"

REM 检查 git 是否安装
where git >nul 2>&1
if errorlevel 1 (
    echo [错误] 没找到 git,请先安装 Git for Windows
    echo 下载: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM 第一次运行:检查是否已初始化
if not exist ".git" (
    echo [第一次] 初始化 git 仓库...
    git init
    git checkout -b main 2>nul
    git config user.name "runtang"
    git config user.email "runtang@users.noreply.github.com"
)

REM 第一次运行:配置 remote + 凭证
if not exist ".git-token" (
    echo.
    echo ========================================
    echo   首次部署 - 配置 GitHub 连接
    echo ========================================
    echo.
    set /p GH_USER="请输入 GitHub 用户名(例如 runtang): "
    set /p GH_REPO="请输入 repo 名(例如 runtang-taiwu-imgs): "

    REM 写入 token 文件(PAT 在下一步输入)
    echo %GH_USER% > .git-user
    echo %GH_REPO% > .git-repo

    echo.
    echo 请到 https://github.com/settings/tokens 生成 Personal Access Token
    echo 勾选 repo 权限即可
    echo.
    set /p GH_TOKEN="请粘贴你的 GitHub PAT: "

    REM 把 token 写入 .git-credentials(用 https 方式,GitHub 会自动 base64)
    echo https://%GH_USER%:%GH_TOKEN%@github.com > .git-credentials
    git config credential.helper "store --file=.git-credentials"

    REM 配置 remote
    git remote remove origin 2>nul
    git remote add origin "https://github.com/%GH_USER%/%GH_REPO%.git"
)

REM 显示当前要推送的内容
echo.
echo [预览] 以下文件会被提交:
git add -A
git status --short
echo.

REM 询问确认
set /p CONFIRM="确认提交并推送? (Y/N): "
if /i not "%CONFIRM%"=="Y" (
    echo 已取消
    pause
    exit /b 0
)

REM 提交
git commit -m "Update images: %date% %time%"

REM 推送
echo.
echo [推送] 上传到 GitHub...
git push -u origin main

if errorlevel 1 (
    echo.
    echo [失败] push 失败,可能原因:
    echo   1. repo 没在 GitHub 上创建(先到 https://github.com/new 创建)
    echo   2. PAT 权限不足(需要勾选 repo)
    echo   3. 网络问题(可能需要代理)
    pause
    exit /b 1
)

echo.
echo ========================================
echo   推送成功!
echo ========================================
echo.
echo 接下来:
echo   1. 打开 https://github.com/%GH_USER%/%GH_REPO%/settings/pages
echo   2. Source 选 main 分支 / root 目录
echo   3. 点 Save,等 1-2 分钟
echo   4. GitHub 会显示访问 URL 类似:
echo      https://%GH_USER%.github.io/%GH_REPO%/
echo.
echo 然后在 Steam Workshop 描述里用:
echo   [img]https://%GH_USER%.github.io/%GH_REPO%/v1.0.0.5/主图/Mod展示图_small.jpg[/img]
echo.
pause