# 性能优化

## 模型选择策略

当前世代为 **Claude 5 系列**。在代理 frontmatter（`model:`）和 CLI 参数中使用
以下模型 ID：

| 层级 | 模型 ID | 适用场景 |
|------|---------|----------|
| Haiku | `claude-haiku-4-5-20251001` | 频繁调用的轻量级代理、多代理系统中的工作者代理、大批量简单任务 |
| Sonnet | `claude-sonnet-5` | 主要开发工作、编排多代理工作流、大多数编码任务 |
| Opus | `claude-opus-5` | 复杂架构决策、最深度推理、研究与分析。100 万 token 上下文窗口 |

**Fable 5**（`claude-fable-5`）是 Claude Code 中能力最强的模型，适合超出单次
会话规模的任务 — 长时间自主会话、根因调查、故障排查、架构决策。它**不是**
默认模型；使用 `/model fable` 选择。使用时：

- 描述目标结果而非步骤 — 让它自行规划路径
- 交给它模糊的问题；额外的调查在这类场景下最有价值
- 无需提醒验证 — 它会自行验证工作，无需过多提示
- 放大任务规模：把你通常会拆分的工作整体交给它

成本随能力提升而增加 — 默认选择能可靠完成任务的最低成本层级，仅在确实
需要推理深度或更大上下文窗口时才使用 Opus/Fable。

### 别名 vs 固定 ID

优先在代理 frontmatter 中使用别名，以便自动跟随推荐版本；仅在需要特定版本时
才固定完整 ID。

| 别名 | 解析为（Anthropic API） |
|------|------------------------|
| `haiku` | 最新 Haiku — 简单任务 |
| `sonnet` | Sonnet 5 — 日常编码 |
| `opus` | Opus 5 — 复杂推理 |
| `fable` | Fable 5 — 最难、耗时最长的任务 |
| `best` | 有权限时用 Fable 5，否则用最新 Opus |
| `opusplan` | 规划模式用 Opus，执行时切换到 Sonnet |
| `default` | 清除覆盖设置，恢复账户/组织默认值 |

在 Bedrock、Google Cloud 和 Microsoft Foundry 上别名解析结果不同 — 若不在
Anthropic API 上，请查阅 `/docs/en/model-config`。

构建 AI 应用时，默认使用最新、能力最强的 Claude 模型，而非固定使用旧版本。

### 快速模式（Fast Mode）

快速模式以成本换取更低延迟，使用 Claude Opus 并加快输出速度 — 它**不会**
降级到更小的模型。

- 使用 `/fast` 切换
- 支持 Opus 5、4.8 和 4.7
- 适用于以实际耗时为主要瓶颈的交互式迭代场景

## 上下文窗口管理

Fable 5、Sonnet 5、Opus 4.6+ 和 Sonnet 4.6 支持 **100 万 token 上下文窗口**。
在 Anthropic API 上，Fable 5、Sonnet 5 和 Opus 4.7+ 始终启用该窗口。在
Max/Team/Enterprise 计划中 Opus 会自动升级到 1M；Sonnet 4.6 的 1M 窗口在所有
计划中均需消耗使用额度。可通过 `CLAUDE_CODE_DISABLE_1M_CONTEXT=1` 完全禁用。
超过 20 万 token 的部分无价格溢价。

避免在上下文窗口的最后 20% 进行以下操作：
- 大规模重构
- 跨多个文件的功能实现
- 调试复杂交互

上下文敏感度较低的任务：
- 单文件编辑
- 独立工具创建
- 文档更新
- 简单 bug 修复

## 努力级别（Effort Level，主要推理控制）

在支持自适应推理的模型上，**努力级别是主要杠杆** — 而非思考 token 预算。
模型会根据任务复杂度自行决定每一步是否思考以及思考多少。

| 级别 | 适用场景 |
|------|----------|
| `low` | 短小、范围明确、对延迟敏感且对智能水平不敏感的任务 |
| `medium` | 可牺牲部分智能水平的成本敏感型工作 |
| `high` | 平衡。**默认值**（Opus 4.7 除外） |
| `xhigh` | 更深度推理，token 开销更高。Opus 4.7 的默认值 |
| `max` | 最深度推理。仅当前会话有效（通过环境变量设置时除外） |

Fable 5、Opus 5、Sonnet 5、Opus 4.8 和 Opus 4.7 支持全部五个级别。
Opus 4.6 和 Sonnet 4.6 支持 `low`、`medium`、`high`、`max`。设置不支持的
级别时，会回退到不高于该级别的最高受支持级别。

设置方式：
- 交互式会话中使用 `/effort <级别>`（持久保存，`max` 除外）
- 启动时使用 `claude --effort <级别>`
- `CLAUDE_CODE_EFFORT_LEVEL` 环境变量，或设置中的 `effortLevel`

**`ultracode`** 是 Claude Code 的设置项而非模型努力级别：它发送 `xhigh`，
**并且**让 Claude 为实质性任务编排动态工作流。仅当前会话有效。通过
`/effort ultracode` 或 `claude --effort ultracode` 启用。

## 扩展思考 + 规划模式

扩展思考是 Claude 在回应前输出的推理过程。在自适应推理模型上，由上述努力
级别决定思考量；以下控制项仅负责开关和显示方式。

| 控制项 | 方式 |
|--------|------|
| 切换当前会话 | `Option+T`（macOS）/ `Alt+T`（Windows/Linux） |
| 全局默认值 | `/config` → 思考模式，保存为 `alwaysThinkingEnabled` |
| 无视努力级别强制关闭 | 在 `env` 中设置 `MAX_THINKING_TOKENS=0` |
| 内联显示推理过程 | `Ctrl+O` 开启详细模式 |
| 显示完整摘要而非脱敏内容 | 设置中 `showThinkingSummaries: true` |

注意事项：
- **Fable 5 无法关闭思考** — 切换键、`alwaysThinkingEnabled` 和
  `MAX_THINKING_TOKENS=0` 对其均无效
- 所有思考 token 均会计费，即使被折叠或脱敏
- `MAX_THINKING_TOKENS` 的非 `0` 取值仅在固定思考预算下生效，自适应推理下无效

对于需要深度推理的复杂任务：
1. 提高努力级别，而非手动调整 token 预算
2. 启用**规划模式**进行结构化方法
3. 使用多轮审查进行彻底分析
4. 使用分角色子代理获得多样化视角

## 构建排查

如果构建失败：
1. 使用 **build-error-resolver** 代理
2. 分析错误消息
3. 增量修复
4. 每次修复后验证
