# ARIS Kit

在一台实验室电脑上同时运行多个 [ARIS](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep/blob/main/README_CN.md)
研究项目的工具箱：Claude Code 是执行者，Codex MCP (GPT) 是审稿人，每个项目各有一个可从笔记本或手机远程控制的会话。

## 目录结构

```
~/aris_repo/            ARIS 本体（共用一份，setup_aris.sh 自动克隆）
~/aris-kit/             本仓库：脚本 + 项目模板
~/projects/
  fault-diagnosis/      每个项目一个文件夹，各自独立的 git 仓库
    CLAUDE.md           研究方向 + GPU 配置（Claude 每次都会读）
    code/ data/ records/ literature/ paper/ experiments/
    research-wiki/      ARIS 自动积累的知识库
  esu/
  ai-trustworthiness/
  tableting/
```

`data/`、`literature/`、`.claude/skills/`、`.aris/` 不进 git。

## 一次性准备（实验室电脑，WSL Ubuntu）

前提：已装好 conda（环境 `research`）、Node.js、Claude Code、Codex，并完成 `codex login`。

```bash
git clone https://github.com/pusunaz/claude.git ~/aris-kit
```

## 新建项目

```bash
bash ~/aris-kit/scripts/new_project.sh fault-diagnosis
```

然后编辑 `~/projects/fault-diagnosis/CLAUDE.md` 里的 Research Direction（也可以让 Claude 改）。

## 启动远程控制

```bash
bash ~/aris-kit/scripts/start_remote.sh            # 所有项目
bash ~/aris-kit/scripts/start_remote.sh esu        # 只启动某几个
```

每个项目在一个同名的 tmux 会话里运行 `claude remote-control`。之后在笔记本浏览器打开
claude.ai/code，或者在手机 Claude App 的 Code 页面里选择对应项目。

- 某个项目第一次启动时需要确认信任文件夹：`tmux attach -t 项目名`，回答后按 `Ctrl+B` 再按 `D`
- 查看：`tmux ls`；停止某个项目：`tmux attach -t 项目名` 后按 `Ctrl+C`
- 实验室电脑重启后：打开 Ubuntu，再运行一次 `start_remote.sh`
- 至少保持一个 Ubuntu 窗口开着（最小化即可），电脑不要睡眠

## 工作流

```
/research-wiki init                        # 每个项目第一次用时
/idea-discovery "具体的研究方向"            # W1：找 idea + 查新 + 精炼
/experiment-bridge                         # W1.5：实现 + 部署 + 收结果
/auto-review-loop "论文主题"                # W2：审稿 -> 修复 -> 再审，过夜运行
/paper-writing "NARRATIVE_REPORT.md"       # W3：叙事 -> PDF
```

GPU（RTX 4080 16GB）是所有项目共用的：同一时间只跑一个大实验。

## 更新

```bash
cd ~/aris-kit && git pull                                        # 更新本工具箱
cd ~/projects/<项目> && ARIS_UPDATE=1 bash ~/aris-kit/scripts/setup_aris.sh   # 更新 ARIS
```

## 没有 Codex 时的审稿人替代

- `— reviewer: manual`：自己把审稿意见贴进来
- `llm-chat` MCP：任意 OpenAI 兼容 API，见 ARIS `docs/LLM_API_MIX_MATCH_GUIDE.md`
