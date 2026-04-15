---
name: gasic
description: Gas Town is a workspace management system that provides persistent identity and state for scaling AI coding operations through agent orchestration. Use when user asks to initialize a workspace, manage agent rigs, delegate tasks via convoys and beads, or monitor the status of persistent AI-driven modifications.
homepage: https://github.com/steveyegge/gastown
metadata:
  docker_image: "biocontainers/gasic:v0.0.r19-4-deb_cv1"
---

# gasic

## Overview
Gas Town is a workspace management system designed to scale AI coding operations by providing persistent identity and state for agents. Unlike standard stateless sessions, Gas Town uses git-backed "Hooks" and a "Beads" ledger to ensure that work survives restarts and crashes. This skill enables the coordination of a central "Mayor" agent to delegate tasks to specialized "Polecat" workers, maintaining a clear audit trail of all AI-driven modifications.

## Core CLI Patterns

### Workspace Initialization
Set up the environment before adding projects:
```bash
# Initialize the town directory
gt install ~/gt --git
cd ~/gt

# Add a project (Rig)
gt rig add <project-name> <git-repo-url>

# Create your personal workspace within a rig
gt crew add <your-name> --rig <project-name>
```

### Orchestration Workflow
The standard path for complex feature development:
1. **Attach to the Mayor**: `gt mayor attach` (This is your primary command center).
2. **Define Work**: Create a convoy to bundle specific issue IDs (beads).
   ```bash
   gt convoy create "Feature Description" gt-abc12 gt-def34 --notify
   ```
3. **Delegate**: "Sling" a bead to a specific rig to spawn a worker agent.
   ```bash
   gt sling gt-abc12 <project-name>
   ```
4. **Monitor**: Check the status of all active convoys and agents.
   ```bash
   gt convoy list
   gt agents
   gt peek  # View live agent output
   ```

### Maintenance and Recovery
Use these commands when agents hang or state becomes desynchronized:
- **gt doctor**: Runs health checks on the workspace, stale hooks, and bead databases.
- **gt mayor attach**: Re-attaches to the coordinator session (survives tmux detachment).
- **gt config agent list**: Verifies available agent runtimes (Claude Code, Codex, etc.).

## Expert Tips
- **Bead IDs**: Always use the prefix + 5-character alphanumeric format (e.g., `gt-x7k2m`). These are the source of truth for work state.
- **Persistence**: Work state is stored in `.beads/` directories. If an agent crashes, the next agent assigned to that bead can resume because the worktree is preserved in a Hook.
- **Minimal Mode**: If you prefer not to use the Mayor's auto-orchestration, you can manually run `gt sling` and then use `claude --resume` inside the generated agent directory to perform the work.
- **Identity Resolution**: Agents identify themselves via `.gt-agent` files in their directories. Ensure these aren't deleted during manual cleanup.

## Reference documentation
- [Gas Town Overview](./references/github_com_steveyegge_gastown.md)
- [Security and Isolation](./references/github_com_steveyegge_gastown_security.md)