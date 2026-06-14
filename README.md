# Dotfiles Navigation

A quick index for finding the configuration files in this repository.

## Top Level

| Path | Purpose |
| --- | --- |
| `AGENTS.md` | Repository-wide instructions for coding agents. |
| `README.md` | Navigation guide for this dotfiles repository. |

## Neovim

| Path | Purpose |
| --- | --- |
| `.nvim/init.lua` | Main Neovim configuration. Bootstraps `lazy.nvim`, configures plugins, LSP, completion, theme, Telescope, lualine, and diagnostics. |
| `.nvim/lazy-lock.json` | Locked plugin versions for `lazy.nvim`. |

Useful Neovim keybindings from `.nvim/init.lua`:

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files with Telescope. |
| `<leader>fg` | Search text with Telescope live grep. |
| `<leader>fb` | Find open buffers. |
| `<leader>fh` | Search help tags. |
| `<leader>e` | Show diagnostic for the current line. |
| `<leader>q` | Open file diagnostics in the location list. |
| `[d` | Go to previous diagnostic. |
| `]d` | Go to next diagnostic. |

## Zed

| Path | Purpose |
| --- | --- |
| `.zed/settings-for-deno.json` | Folder-specific Zed settings for TypeScript projects that use Deno. |

## Pi Coding Agent

| Path | Purpose |
| --- | --- |
| `.pi/extensions/non-destructive-bash.ts` | Pi extension that adds permission checks for potentially destructive bash commands. |

## Agent Skills

| Path | Purpose |
| --- | --- |
| `.agents/skills/commit-code/SKILL.md` | Workflow for planning, formatting, staging, and committing code. |
| `.agents/skills/create-pr/SKILL.md` | Workflow for drafting and creating Pull Requests with GitHub CLI. |
| `.agents/skills/review-changes/SKILL.md` | Workflow for reviewing committed and uncommitted repository changes. |
