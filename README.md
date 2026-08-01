# Dotfiles Navigation

A quick index for finding the configuration files in this repository.

## Top Level

| Path                     | Purpose                                         |
| ------------------------ | ----------------------------------------------- |
| [`AGENTS.md`](AGENTS.md) | Repository-wide instructions for coding agents. |
| [`README.md`](README.md) | Navigation guide for this dotfiles repository.  |

## Neovim

| Path                                           | Purpose                                                                                                                             |
| ---------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| [`.nvim/init.lua`](.nvim/init.lua)             | Main Neovim configuration. Bootstraps `lazy.nvim`, configures plugins, LSP, completion, theme, Telescope, lualine, and diagnostics. |
| [`.nvim/lazy-lock.json`](.nvim/lazy-lock.json) | Locked plugin versions for `lazy.nvim`.                                                                                             |

Useful Neovim keybindings from [`.nvim/init.lua`](.nvim/init.lua):

| Key          | Action                                      |
| ------------ | ------------------------------------------- |
| `<leader>ff` | Find files with Telescope.                  |
| `<leader>fg` | Search text with Telescope live grep.       |
| `<leader>fb` | Find open buffers.                          |
| `<leader>fh` | Search help tags.                           |
| `<leader>e`  | Show diagnostic for the current line.       |
| `<leader>q`  | Open file diagnostics in the location list. |
| `[d`         | Go to previous diagnostic.                  |
| `]d`         | Go to next diagnostic.                      |

## Zed

| Path                                                         | Purpose                                                             |
| ------------------------------------------------------------ | ------------------------------------------------------------------- |
| [`.zed/settings.json`](.zed/settings.json)                   | General Zed editor settings.                                        |
| [`.zed/settings-for-deno.json`](.zed/settings-for-deno.json) | Folder-specific Zed settings for TypeScript projects that use Deno. |

## Pi Coding Agent

| Path                                                                               | Purpose                                                                             |
| ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| [`.pi/extensions/non-destructive-bash.ts`](.pi/extensions/non-destructive-bash.ts) | Pi extension that adds permission checks for potentially destructive bash commands. |

## OpenCode

| Path                                                                   | Purpose                                                   |
| ---------------------------------------------------------------------- | --------------------------------------------------------- |
| [`.config/opencode/agents/guide.md`](.config/opencode/agents/guide.md) | Primary programming mentor for pseudocode-first guidance. |

## Agent Skills

| Path                                                                               | Purpose                                                              |
| ---------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| [`.agents/skills/catch-up/SKILL.md`](.agents/skills/catch-up/SKILL.md)             | Workflow for refreshing stale repository context.                    |
| [`.agents/skills/create-pr/SKILL.md`](.agents/skills/create-pr/SKILL.md)           | Workflow for drafting and creating Pull Requests with GitHub CLI.    |
| [`.agents/skills/research/SKILL.md`](.agents/skills/research/SKILL.md)             | Workflow for researching impact area of the specs.                   |
| [`.agents/skills/review-changes/SKILL.md`](.agents/skills/review-changes/SKILL.md) | Workflow for reviewing committed and uncommitted repository changes. |
