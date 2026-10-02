# ARIS 研究项目

基于 [ARIS (Auto-claude-code-research-in-sleep)](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep/blob/main/README_CN.md)
的研究项目骨架：Claude Code 作为执行者，Codex MCP (GPT) 作为跨模型审稿人。

## 一次性配置（在你自己的电脑上）

```bash
# 0. 前置工具
claude --version                 # Claude Code
codex --version && codex login   # Codex CLI + 一次性 ChatGPT 登录（审稿人需要）
# 可选，写论文用：brew install --cask mactex && brew install poppler

# 1. 克隆本仓库并一键安装
git clone https://github.com/pusunaz/claude.git && cd claude
bash scripts/setup_aris.sh
#  - 把 ARIS 克隆到 ~/aris_repo（可用 ARIS_REPO=/path 覆盖）
#  - 把全部 skill 软链接到 .claude/skills/（只装部分：ARIS_GROUPS=lit-search,ideation,review-loop）
#  - 检测到 codex 时自动执行 claude mcp add codex -s user ...

# 2. 重启 Claude Code，然后验证
claude mcp list | grep codex     # 应显示 ✓ Connected
```

然后编辑 `CLAUDE.md`：填写 **Research Direction** 和 **Remote Server**
（GPU 服务器需先 `ssh-copy-id username@server` 配好免密登录）。

更新 ARIS：`ARIS_UPDATE=1 bash scripts/setup_aris.sh`

## 首次运行

在本目录启动 `claude`：

```
/research-wiki init                              # 初始化知识库
用 codex MCP 问一下 GPT：1+1 等于几                 # 验证跨模型通信
/alphaxiv https://arxiv.org/abs/1706.03762       # 验证 skill 可用
```

## 工作流

```
/idea-discovery "具体的研究方向"            # W1：找 idea + 查新 + 精炼
/experiment-bridge                         # W1.5：实现 + 部署 + 收结果
/auto-review-loop "论文主题"                # W2：审稿 -> 修复 -> 再审，过夜运行
/paper-writing "NARRATIVE_REPORT.md"       # W3：叙事 -> PDF
/research-pipeline "具体的研究方向"         # 全流程，默认停在 NARRATIVE_REPORT.md
```

## 过夜运行免确认（可选）

在 `.claude/settings.local.json`（已 gitignore）中加入：

```json
{
  "permissions": {
    "allow": ["mcp__codex__codex", "mcp__codex__codex-reply", "Write", "Edit", "Skill(auto-review-loop)"]
  }
}
```

## 没有 OpenAI / Codex 时的审稿人替代

- `— reviewer: manual`：自己贴审稿意见（不能无人值守）
- `llm-chat` MCP：任意 OpenAI 兼容 API（DeepSeek、Kimi、OpenRouter 等），见 ARIS `docs/LLM_API_MIX_MATCH_GUIDE.md`
- 更多组合见 ARIS `docs/MODEL_COMBINATIONS_CN.md`
