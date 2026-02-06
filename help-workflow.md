# Claude Code + GLM 工作流速查

## 目录约定
- 全局目录：`/Users/tx/.claude`
- 关键文件：
  - `/Users/tx/.claude/CLAUDE.md`
  - `/Users/tx/.claude/settings.json`
  - `/Users/tx/.claude/rules/flow.md`
  - `/Users/tx/.claude/commands/manager.md`
  - `/Users/tx/.claude/commands/ship-step.md`
  - `/Users/tx/.claude/commands/manager-team.md`
  - `/Users/tx/.claude/agents/architect.md`
  - `/Users/tx/.claude/agents/implementer.md`
  - `/Users/tx/.claude/agents/reviewer.md`
  - `/Users/tx/.claude/agents/qa.md`

## 模式说明
- `plan`：只规划，不改代码。
- `acceptEdits`（或可编辑模式）：允许改文件并执行步骤。
- 快捷键：`Shift+Tab` 循环切换模式。

## 日常使用流程
1. 启动会话（默认建议在 `plan` 模式）。
2. 输入：`/manager 目标描述`
3. 查看输出的“下一步 step + 验证命令 + 风险点”。
4. 切到可编辑模式（`Shift+Tab`）。
5. 输入：`/ship-step`
6. 只执行一个 step，写入 `.ai/progress.md` 后停止。
7. 切回 `plan`，继续下一轮 `/manager`。

## 复杂任务（并行）
1. 输入：`/manager-team 复杂任务描述`
2. 先看拆分是否有同文件冲突。
3. 确认后再执行，避免并行改同一文件。

## 项目内状态文件
- `.ai/plan.md`：任务拆解与待办步骤。
- `.ai/progress.md`：每步执行日志、改动文件、验证结果、下一步。

## 推荐习惯
- 每次只做一个最小可验证 step。
- 先补测试/验证，再改实现。
- 每完成 3-6 步，执行一次 `/clear`，再继续。
- `settings.json` 修改前先备份，避免覆盖 GLM 路由配置。

## 常见问题
- 提示 `Not logged in`：
  - 执行 `/login`。
  - 若是覆盖了 `settings.json` 导致配置丢失，恢复模型路由后重启会话。
- 模式不对无法改代码：
  - 用 `Shift+Tab` 切换到可编辑模式后再执行 `/ship-step`。
- 改动超出预期：
  - 立即回到 `plan`，重新运行 `/manager` 缩小步骤范围。
