---
name: watchdog
description: Watchdog observes and reacts to filesystem changes. Use when user asks to log file activity, run commands on file changes, auto-run tests, or refresh builds.
homepage: https://github.com/gorakhargosh/watchdog
---


# watchdog

## Overview
Watchdog is a cross-platform toolset designed to observe and react to filesystem changes. It abstracts complex, platform-specific monitoring APIs (like Linux's inotify, macOS's FSEvents, and Windows' ReadDirectoryChangesW) into a consistent interface. This skill focuses on using the `watchmedo` command-line utility to automate development workflows, such as auto-running tests, refreshing builds, or logging file activity for auditing.

## CLI Usage Patterns
The `watchmedo` utility is the primary interface for shell-based automation.

### Logging Events
To monitor and log all activity for specific file types in the current directory and its subdirectories:
`watchmedo log --patterns="*.py;*.txt" --recursive --verbose .`

### Executing Commands on Change
To trigger a specific shell command whenever a file is modified:
`watchmedo shell-command --patterns="*.py" --recursive --command='pytest ${watch_src_path}' .`

**Useful Command Variables:**
- `${watch_src_path}`: The absolute path to the file that triggered the event.
- `${watch_event_type}`: The type of event (created, modified, deleted, moved).
- `${watch_object}`: Indicates if the target was a 'file' or 'directory'.

### Filtering Events
To reduce noise and improve performance, use exclusion flags:
- `--ignore-directories`: Skip events related to directory creation/deletion.
- `--ignore-patterns`: Exclude specific files or folders (e.g., `--ignore-patterns="*/.git/*;*/__pycache__/*"`).

## Expert Tips and Best Practices

### Handling "Atomic" Saves (Vim/IntelliJ)
Many modern editors do not write directly to a file. Instead, they create a temporary file and swap it with the original. This can cause `on_modified` events to be missed or trigger `on_moved` events instead.
- **Tip**: If your automation isn't triggering, check if your editor uses "safe write" or "backup files" and monitor for `created` or `moved` events in addition to `modified`.

### Monitoring Network Shares (CIFS/SMB)
Native OS event notifications often do not propagate correctly over network mounts.
- **Tip**: If changes on a network drive are not being detected, you must use a polling mechanism. In Python code, use `watchdog.observers.polling.PollingObserver`.

### macOS/BSD File Descriptor Limits
On systems using `kqueue` (macOS and FreeBSD), watchdog requires a file descriptor for every file being monitored.
- **Tip**: For large projects, you may hit the system limit. Increase it using `ulimit -n 4096` in your shell profile to prevent "Too many open files" errors.

### Performance in Deep Directories
Recursive monitoring of very large directory trees can be resource-intensive.
- **Tip**: Always use specific `--patterns` to limit the scope of the observer to only the files that actually require a response.

## Reference documentation
- [Watchdog README](./references/github_com_gorakhargosh_watchdog.md)