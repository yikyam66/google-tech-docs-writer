# devdoc 技能上手指南

本指南面向想在 Claude Code 或 ZCode 中安装并使用 devdoc 技能的开发者。devdoc 技能指 `google-tech-docs-writer` 项目中的三个技能：`devdoc-review`、`devdoc-fix` 和 `devdoc-draft`。本指南涵盖安装、三个技能的日常使用，以及如何更新风格规则；不讲解风格规则本身的内容。

## 概述

`google-tech-docs-writer` 项目从 [Google 开发者文档风格指南](https://developers.google.com/style)中精选出一个子集，封装成可复用的技能。完整指南约 70 页，其中大部分规则只适用于很窄的文档类型；本项目提取的是对日常技术写作影响最大的规则。

项目提供三个技能，每个技能文件夹都是自包含的：

- `/devdoc-review`：对照风格规则检查文档，并以结构化清单的形式报告发现的问题，不做任何修改。
- `/devdoc-fix`：执行同样的检查，先提出 diff，经你确认后才会应用更改。
- `/devdoc-draft`：从零起草新文档，在写作过程中直接应用规则。

这些规则专为英文技术写作设计。如果请求的文档是其他语言，技能会直接拒绝，而不是把英文规则强行套上去。

## 安装技能

最快的安装方式是用 skills CLI 一次装齐三个技能（已在 Claude Code 上验证）：

```
npx skills add yikyam66/google-tech-docs-writer
```

如果想手动安装，先克隆本仓库。Claude Code 和 ZCode 在不同目录中发现技能，每个宿主都需要一条各自指向同一技能文件夹的符号链接。我们用符号链接而不是复制文件，这样在仓库里改一条规则，所有宿主都能同步生效。

Claude Code 只有在 `~/.claude/skills/<name>/` 目录下**直接**包含 `SKILL.md` 文件时才会发现技能，其中 `<name>` 是技能文件夹名，例如 `devdoc-review`。在仓库根目录下为每个技能创建一条符号链接：

```
ln -s "$(pwd)/devdoc-review" ~/.claude/skills/devdoc-review
ln -s "$(pwd)/devdoc-fix" ~/.claude/skills/devdoc-fix
ln -s "$(pwd)/devdoc-draft" ~/.claude/skills/devdoc-draft
```

ZCode 不会扫描 `~/.claude/skills/`，所以只装给 Claude Code 的话，ZCode 看不见这些技能。这里的命令使用用户级 `~/.agents/skills/` 目录，请创建一组对应的符号链接：

```
ln -s "$(pwd)/devdoc-review" ~/.agents/skills/devdoc-review
ln -s "$(pwd)/devdoc-fix" ~/.agents/skills/devdoc-fix
ln -s "$(pwd)/devdoc-draft" ~/.agents/skills/devdoc-draft
```

安装完成后请新开一个会话；新安装的技能只有在新会话中才会出现在可用技能列表里。

## 审查或修复现有文档

想拿到问题报告时用 `/devdoc-review`；想要现成的修改建议时用 `/devdoc-fix`。

review 技能会读取文档、对照风格规则逐条检查，并为每个发现标注位置、违反的规则和建议改法，全程不做任何修改。报告会引用规则名（例如 "Active voice"），方便你到参考文件中查阅原始规则。

fix 技能执行同样的检查，然后给出 diff，只有经你确认后才会应用更改。

## 起草新文档

用 `/devdoc-draft` 按本项目风格从零起草一篇新文档。告诉它文档的用途和读者，并让它访问目标仓库。

技能按以下步骤工作：

1. 从你的描述和目标仓库中收集事实。
2. 提出大纲，等你确认。
3. 起草文档，边写边应用规则。
4. 用同一套规则自检草稿，并修正发现的问题。
5. 经你确认目标路径后才写入文件。

凡是技能无法核实的内容，都会在草稿中写成明确的 `TODO:` 占位符——它从不编造事实、数字或引文。

规则只适用于英文文档。如果你请求的文档是其他语言，技能会在读取任何规则文件之前直接拒绝，而不是把英文规则强行套在你的文档上。

## 更新风格规则

只编辑顶层 `references/` 文件夹中的规则文件。这个文件夹保存四个文件的权威母本：`core-rules.md`、`word-list.md`、`code-and-commands.md` 和 `error-messages.md`。

每个技能文件夹都带有这些文件各自的副本。原因在于：有些宿主解析相对路径时依据的是符号链接的表面位置而非真实目标，技能一旦用 `../` 越出自己的文件夹就会读取失败；自带副本消除了这个依赖。

修改规则后，在 `google-tech-docs-writer` 目录下运行同步脚本，然后再测试或提交：

```
./scripts/sync-references.sh
```

脚本会把四个参考文件复制进每个技能文件夹。不要手改这些副本——同步脚本会覆盖它们。

## 移植到其他工具

项目在 `adapters/` 下记录了两种移植方案：`codex-notes.md`（面向 Codex CLI）和 `trae-notes.md`（面向 Trae IDE，后者没有确认的导入机制，需要手动内联）。两个适配器都尚未在真实安装环境中验证过。

无论移植到哪个工具，都不要手工复制规则内容：修改 `references/` 中的文件，然后重新运行同步脚本。
