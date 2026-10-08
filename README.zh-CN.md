# google-tech-docs-writer

一个基于 Google 公开技术写作资源的可移植技能。主要来源是 [Google 开发者文档风格指南](https://developers.google.com/style)；Google [技术写作课程](https://developers.google.com/tech-writing)中直接服务于同一目标的针对性材料也一并纳入——例如错误消息写作与插图技巧。这套技能用于审查、修复和起草面向开发者的技术文档，覆盖语气、语法、标点、无障碍、包容性用语和格式。

> 英文原版：[README.md](README.md)。两版内容同步维护，如有出入以英文版为准。

## 它做什么

三个技能共享同一套规则，每个技能文件夹都完全自包含：

- `/devdoc-review` 对照风格规则检查文档，把发现的问题整理成结构化清单，绝不修改文件。
- `/devdoc-fix` 执行同样的检查，先给出 diff，经你确认后才会应用更改。
- `/devdoc-draft` 从零起草新文档，在写作过程中直接应用规则。

一条审查发现长这样（取自对本 README 的一次真实审查）：

> **", etc."** — 违反 *Word list：etc. → 列出实际例子*。建议改法：例子已经列全，列表写到 "and detailed HTML semantics" 为止。

那次审查还抓到了一个 55 词的超长开篇句、三处实质性括号插入语和 21 处带空格的 em dash。

## 环境要求

- 一个加载 `SKILL.md` 格式技能的宿主。Claude Code、ZCode 和 Codex CLI 均可——各工具的支持状态见[跨工具支持](#跨工具支持)。
- 英文文档。这套规则专为英文技术写作设计——如果文档是其他语言，技能会直接拒绝，而不是把英文规则强行套上去。

## 安装

技能文件夹放在 `skills/` 下，因为那是 skills CLI 自动发现的位置之一，三条技能一条命令即可装齐（已在 Claude Code 上验证）：

```
npx skills add yikyam66/google-tech-docs-writer
```

如果想手动安装，先克隆本仓库，然后为每个宿主的每个技能各建一条符号链接。Claude Code 只有在 `~/.claude/skills/<name>/` 目录下直接包含 `SKILL.md` 文件时才会发现技能，其中 `<name>` 是技能文件夹名，例如 `devdoc-review`。在本仓库根目录下运行：

```
ln -s "$(pwd)/skills/devdoc-review" ~/.claude/skills/devdoc-review
ln -s "$(pwd)/skills/devdoc-fix" ~/.claude/skills/devdoc-fix
ln -s "$(pwd)/skills/devdoc-draft" ~/.claude/skills/devdoc-draft
```

ZCode 不会扫描 `~/.claude/skills/`，所以只装给 Claude Code 的话 ZCode 看不见——每个宿主都需要一组自己的符号链接。在 `~/.agents/skills/` 下创建一组对应的链接：

```
ln -s "$(pwd)/skills/devdoc-review" ~/.agents/skills/devdoc-review
ln -s "$(pwd)/skills/devdoc-fix" ~/.agents/skills/devdoc-fix
ln -s "$(pwd)/skills/devdoc-draft" ~/.agents/skills/devdoc-draft
```

安装完成后请新开一个会话；新安装的技能只有在新会话中才会出现在可用技能列表里。

## 使用

分步操作指南见 [getting-started.zh-CN.md](getting-started.zh-CN.md)（英文版：[getting-started.md](getting-started.md)）。三个技能分别是：

- `/devdoc-review`——无破坏性。读取文档、对照风格规则逐条检查，把发现整理成结构化 Markdown 清单（位置、违反的规则、建议改法），不做任何修改。
- `/devdoc-fix`——执行同样的检查，然后给出 diff，经你确认后才会应用。
- `/devdoc-draft`——按本套风格从零起草新文档，面向你的目标项目：从你的描述和目标仓库收集事实（凡无法核实的内容都写成明确的 `TODO:` 占位符——绝不编造事实），先提出大纲等你确认，边起草边应用规则，用同一套规则自检，经你确认目标路径后才写入文件。

## 规则覆盖范围

完整的 Google 风格指南约 70 页，其中大部分规则对单篇文档很少用得上。本项目把其中影响最大的高频子集提炼为四个参考文件：

| 文件 | 覆盖内容 |
|---|---|
| `core-rules.md` | 语气、主动语态、人称、时态、包容性用语、无障碍、标题、列表、标点、数字与单位 |
| `word-list.md` | 约 100 条高频术语——推荐写法与避免写法对照，并注明原因 |
| `code-and-commands.md` | 行内代码、占位符、命令行语法、UI 标签 |
| `error-messages.md` | 错误消息写作；仅当文档包含错误消息文本、错误码表格或 UI 字符串时才加载 |

## 修改规则

只编辑 `references/` 中的权威母本——不要手改 `skills/devdoc-*/references/` 里的副本。改完规则后，在本仓库根目录运行同步脚本，然后再测试或提交：

```
./scripts/sync-references.sh
```

脚本会把四个参考文件复制进每个技能文件夹。副本是生成物，不要手改。每个技能文件夹完全自包含（路径从不越出自己的文件夹），这正是符号链接安装和 skills CLI 安装能成立的原因——这背后的设计沿革见 [DESIGN.md](DESIGN.md)。

## 跨工具支持

本项目面向以下工具：

| 工具 | 机制 | 状态 |
|---|---|---|
| Claude Code | `SKILL.md` + `references/*.md`，按需加载；符号链接到 `~/.claude/skills/<name>/` | 原生——本项目发源地 |
| ZCode | 同一技能格式；从 `<project>/.zcode/skills/`、`<project>/.agents/skills/`、`~/.zcode/skills/` 或 `~/.agents/skills/` 发现（不扫描 `~/.claude/skills/`） | 原生——符号链接到 `~/.agents/skills/<name>/` |
| Codex CLI | Agent Skills：`.agents/skills/<name>/SKILL.md` + `references/`，与 Claude Code 格式相同 | 即插即用——见 `adapters/codex-notes.md` |
| Trae IDE | `.trae/rules/`——单个自包含 Markdown 文件，无确认的导入机制 | 需手动内联或小的构建步骤——见 `adapters/trae-notes.md` |
| 其他工具 | — | 在 `adapters/` 下新增说明；不要手工复制规则内容——修改 `references/` 并重新运行同步脚本 |

## 延后规则（已知缺口——刻意未收录）

源材料中存在但尚未收进参考文件的规则领域：收录方式是复制进对应参考文件，一次一个小提交——这份清单的意义在于让"未收录"明确表示"考虑过并延后"，而不是"不知道"。

| 领域 | 来源 | 一行规则 |
|---|---|---|
| 日期与时间 | developers.google.com/style/dates-times | 12 小时制加 AM/PM；日期写出；数字格式用 YYYY-MM-DD；不用季节 |
| 省略号 | /style/ellipses | 引文之外避免使用；UI 标签中禁用 |
| 斜杠 | /style/slashes | 代码之外避免；不用 "and/or"，不用斜杠日期 |
| 所有格 | /style/possessives | 避免产品名/代码名的所有格——改写 |
| 引号 | /style/quotation-marks | 直双引号；句号在引号内（字面字符串除外）；单引号仅用于代码/嵌套 |
| 复数 | /style/pluralization | 缩写不加 's（APIs）；单位与数字连用时用单数；不用可选的 "(s)" |
| 大小写细节 | /style/capitalization | 全大写/驼峰仅用于官方名称和代码；避免无谓大写 |
| 破折号级别 | /style/dashes | Google 避免 en dash；优先用冒号/列表代替破折号式说明 |
| 介词 | /style/prepositions | 句尾介词可以；必要的写清楚，多余的省略 |
| 脚注 | /style/footnotes | 避免；改用交叉引用或注释 |
| 数学记号 | /style/mathematical-notation | 符号用 HTML 实体；变量用斜体；小数优于分数 |
| 电话号码 | /style/phone-numbers | 保留示例号段 800-555-01xx；国际格式加 "+国家代码" |
| 商标 | /style/trademarks | 遵循所有者规范；仅作修饰语与名词连用；不作动词或所有格 |
| HTML 语义 | /style/semantic-tagging | 元素用于语义而非外观；强调用 em/strong |
| 锚点目标 | /style/headings-targets | 稳定的小写连字符 ID；改名时保留旧锚点 |
| 插图技巧 | /tech-writing/two/illustrations | 图注先行（点明要点）；每张图承载一段信息；先整体后子系统 |

## 状态

最新一轮评测（2026-10-08；四个评测用例，带技能与不带技能各跑一次，模型 `claude-sonnet-5`）：带技能通过率 100%，不带技能 29%。第一轮为 96.4% 对 34.3%，其发现推动了技能描述收紧和两处断言修订。评测套件（提示词、fixture、带/不带技能的评分运行）维护在作者的工作区中。

审查/修复流程已在两份真实文档上演练过——一份外部项目文档和本 README——抓到了非包容用语、时间锚定表述、冗长构造、标点问题，以及本 README 自身结构清单里的一处遗漏。`devdoc-draft` 已完整起草过本项目的上手指南，语言门槛在内。触发评测目前是推理式的，尚未对真实 CLI 实测。Codex CLI 和 Trae IDE 适配器有文档但未对真实安装验证过。
