# 小白 Skills

一套给 Codex / agent 新手用的 skills 装机包和整理工具。

它解决两个问题：

1. **新手不知道该装什么。**  
   小白 Skills 给出一套覆盖常见需求的优质默认组合，尽量做到一键安装、开箱能用。

2. **装多了以后互相抢触发。**  
   小白 Skills 会盘点已安装 skills，把同类冲突项做取舍：选一个放全局，没选上的放进备用目录。以后如果当前主力效果不理想，再从备用里恢复。

## 覆盖范围

默认组合覆盖：

- skills 发现和安装
- skills 创建和编辑
- 前端 UI / 视觉实现
- 图片生成和媒体处理
- URL 转 Markdown、翻译、发布、幻灯片等内容工作流
- TDD、诊断、triage、PRD、issues、review、handoff 等工程流程
- skills 图书馆整理、去重、备份和恢复

## 推荐默认组合

小白 Skills 默认建议全局保留：

- OpenAI 系统 skills：`imagegen`、`openai-docs`、`plugin-creator`、`skill-creator`、`skill-installer`
- `find-skills`
- `frontend-master`
- `baoyu-skills` 精简版
- `mattpocock-skills` 精简版
- `xiaobai-skills`

默认放入备用：

- `gstack`
- `superpowers`
- Matt Pocock skills 中 deprecated / personal / niche 的子技能
- Baoyu skills 中 danger / 重复触发的子技能

## 安装

把本仓库中的 `xiaobai-skills` 文件夹复制到：

```powershell
C:\Users\<你>\.codex\skills\xiaobai-skills
```

或者在仓库根目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\xiaobai-skills\scripts\install-xiaobai-skills.ps1
```

安装后重启 Codex。

## 一键安装默认技能

脚本会尽量使用 GitHub zip 下载，不要求本机一定有 `git`。

```powershell
powershell -ExecutionPolicy Bypass -File .\xiaobai-skills\scripts\install-xiaobai-skills.ps1 -InstallRecommended
```

可选参数：

```powershell
-InstallRecommended   安装推荐默认组合
-CurateExisting       整理已安装 skills，冲突项移入备用
-Force                覆盖已有同名目标
```

## 整理已安装 Skills

```powershell
powershell -ExecutionPolicy Bypass -File .\xiaobai-skills\scripts\install-xiaobai-skills.ps1 -CurateExisting
```

整理后会生成：

```text
SKILLS-GLOBAL-INVENTORY.md
~\.codex\skills-backup\xiaobai-YYYY-MM-DD\README.md
```

## 设计取舍

小白 Skills 的核心不是“装最多”，而是“让新手少踩坑”。

因此它会：

- 保留窄触发、具体能力强的 skills。
- 避免多个大流程框架同时全局启用。
- 把没选中的放进备用目录，而不是删除。
- 给未来恢复留下清楚的说明。

## 致谢

小白 Skills 的默认推荐组合参考并使用了这些优秀项目：

- OpenAI Codex system skills
- [`vercel-labs/skills`](https://github.com/vercel-labs/skills)
- [`mineru98/llm-proxy-skills`](https://github.com/mineru98/llm-proxy-skills)
- [`JimLiu/baoyu-skills`](https://github.com/JimLiu/baoyu-skills)
- [`mattpocock/skills`](https://github.com/mattpocock/skills)
- [`garrytan/gstack`](https://github.com/garrytan/gstack)
- [`obra/superpowers`](https://github.com/obra/superpowers)

请遵守各上游项目的许可证和使用说明。

## License

MIT. 具体以上游依赖和引用项目的 license 为准。

