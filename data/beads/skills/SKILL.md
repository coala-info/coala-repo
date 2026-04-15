---
name: beads
description: Beads provides a persistent, graph-based memory system that tracks task dependencies and project states directly within a repository. Use when user asks to initialize a task tracking system, create or update tasks, manage dependencies between items, or view ready-to-work tasks in a structured graph format.
homepage: https://github.com/steveyegge/beads
metadata:
  docker_image: "biocontainers/beads:v1.1.18dfsg-3-deb_cv1"
---

# beads

## Overview
Beads (invoked via the `bd` CLI) provides a persistent, graph-based memory system for coding agents. Unlike flat markdown plans, Beads tracks dependencies and task states in a structured format stored directly in your repository. This allows agents to maintain a "source of truth" for project progress that is versioned, branchable, and optimized for LLM consumption. It effectively replaces messy "TODO" lists with a dependency-aware graph that identifies exactly what can be worked on next.

## Core Workflow
1. **Initialize**: Run `bd init` in the project root. 
   - Use `--stealth` if you want to keep task tracking local and avoid committing `.beads/` files to the main repository.
   - Use `--contributor` if working on a fork to route planning to a separate local directory.
2. **Plan**: Create tasks using `bd create "Task description"`. For high-priority items, use `-p 0`.
3. **Execute**:
   - Run `bd ready` to see tasks that have no open blockers.
   - Claim a task with `bd update <id> --claim` to set yourself as the assignee and mark it in-progress.
   - Once finished, close the task with `bd update <id> --status closed`.
4. **Link**: Use `bd dep add <child_id> <parent_id>` to create blockers. The child task will not appear in `bd ready` until the parent is closed.

## Advanced CLI Patterns
- **Hierarchical Tasks**: Create sub-tasks using hierarchical IDs (e.g., `bd-a3f8.1` for a sub-task of `bd-a3f8`). This is useful for breaking down large epics.
- **Task Inspection**: Use `bd show <id>` to see the full audit trail, including comments, metadata, and state changes.
- **Messaging**: Use the message issue type with threading for ephemeral notes: `bd create "Note" --type message --thread <id>`.
- **Relationship Mapping**: Beyond simple dependencies, use `relates_to`, `duplicates`, or `supersedes` to build a richer knowledge graph of the project's history.

## Best Practices
- **Atomic Claims**: Always use the `--claim` flag when starting work. This atomically sets the assignee and moves the status to `in_progress`, preventing duplicate effort in multi-agent environments.
- **Dependency Mapping**: Before starting a complex feature, map out the dependency graph. This forces a logical work order and prevents the agent from attempting tasks that lack necessary prerequisites.
- **Context Efficiency**: Beads is designed to be token-efficient. It uses "semantic memory decay" to summarize old closed tasks, keeping the context window focused on active and upcoming work.
- **Git Integration**: Since Beads stores issues as JSONL in `.beads/`, treat these files like code. Branch, commit, and merge them to keep your task list in sync with your feature branches.
- **Maintenance**: Periodically run `bd doctor` to check for sync freshness and runtime health.

## Reference documentation
- [Beads Main README](./references/github_com_steveyegge_beads.md)
- [Security and Best Practices](./references/github_com_steveyegge_beads_security.md)