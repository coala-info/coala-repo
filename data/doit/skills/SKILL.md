---
name: doit
description: The `doitlive` tool (referred to here as `doit`) is a specialized utility for terminal-based presentations.
homepage: https://github.com/sloria/doitlive
---

# doit

## Overview
The `doitlive` tool (referred to here as `doit`) is a specialized utility for terminal-based presentations. It allows you to take a standard shell script and "play" it back in a fake terminal session. As you type random characters on your keyboard, the tool renders the actual commands from your script, making it appear as though you are typing perfectly at a high speed. This is particularly useful for live coding sessions where the environment is unpredictable or where complex commands might lead to embarrassing typos.

## Installation and Setup
Install the tool using either Homebrew or pip:

- **Homebrew**: `brew install doitlive`
- **pip**: `pip install doitlive`

## Core Workflows

### Creating a Session
A session is simply a text file (usually `.sh`) containing the shell commands you wish to demonstrate.

```bash
# example_session.sh
echo "Starting the demo..."
ls -la
git status
```

### Playing a Session
To start the presentation, use the `play` command. Once the session starts, you can type any keys to advance the text.

```bash
doitlive play example_session.sh
```

### Recording a Session
If you prefer to capture a real session to replay later, use the `record` command. This creates a session file based on your actual terminal input.

```bash
doitlive record my_demo.sh
```

## Expert Tips and Best Practices

### Visual Customization
Use themes to make the terminal prompt look professional or to match a specific shell environment (like zsh or powerline).
- **List themes**: `doitlive themes`
- **Apply a theme**: `doitlive play session.sh -t sorin`

### Handling Execution
- **Instant Playback**: If you want to skip the "fake typing" for a specific command and just run it, you can often configure the tool or use specific session markers.
- **Comments**: You can include comments in your session file. By default, these are not "typed" out unless configured otherwise, allowing you to keep notes for yourself within the script.
- **Exiting**: Use the `Esc` key to exit a running session prematurely.

### Command Line Options
- `--shell`: Specify which shell to use (e.g., `/bin/zsh`).
- `--speed`: Adjust the typing speed simulation.
- `--completions`: Generate shell completion scripts for `doitlive` itself.

### Managing Multi-line Commands
When writing session files, ensure multi-line commands use the standard shell backslash (`\`) continuation. Note that some versions may require careful placement of the backslash to ensure the "fake typing" renders the newline correctly.

## Reference documentation
- [doitlive README](./references/github_com_sloria_doitlive.md)
- [doitlive Issues and Known Behaviors](./references/github_com_sloria_doitlive_issues.md)