---
name: pyinotify
description: Pyinotify provides a Python interface to the Linux kernel's inotify mechanism for monitoring filesystem events. Use when user asks to monitor directories or files for changes, receive real-time notifications of file system events, or replace polling-based file monitoring with event-driven scripts.
homepage: https://github.com/seb-m/pyinotify
metadata:
  docker_image: "quay.io/biocontainers/pyinotify:0.9.6--py36_0"
---

# pyinotify

## Overview

Pyinotify is a Python-based interface to the Linux kernel's inotify mechanism. It allows applications to watch directories or files and receive asynchronous notifications when specific events occur. This skill provides the essential patterns for using the pyinotify command-line interface and implementing basic monitoring scripts to replace polling-based solutions with efficient, event-driven workflows.

## Quick Start CLI

The simplest way to use pyinotify is via its built-in module execution to monitor a path directly from the shell.

```bash
# Monitor a directory with verbose output
python -m pyinotify -v /path/to/watch

# Monitor multiple paths
python -m pyinotify /tmp /var/log
```

## Core Monitoring Pattern

To use pyinotify in a script, follow the standard "WatchManager -> ProcessEvent -> Notifier" workflow.

```python
import pyinotify

# 1. Define what to do when an event occurs
class EventHandler(pyinotify.ProcessEvent):
    def process_IN_CREATE(self, event):
        print(f"Created: {event.pathname}")

    def process_IN_DELETE(self, event):
        print(f"Deleted: {event.pathname}")

    def process_IN_MODIFY(self, event):
        print(f"Modified: {event.pathname}")

# 2. Initialize the Watch Manager
wm = pyinotify.WatchManager()

# 3. Set the mask (events to watch)
mask = pyinotify.IN_DELETE | pyinotify.IN_CREATE | pyinotify.IN_MODIFY

# 4. Setup the Notifier and add the watch
handler = EventHandler()
notifier = pyinotify.Notifier(wm, handler)
wm.add_watch('/tmp', mask, rec=True) # rec=True for recursive monitoring

# 5. Start the loop
notifier.loop()
```

## Common Event Masks

| Mask | Description |
| :--- | :--- |
| `IN_ACCESS` | File was accessed (read) |
| `IN_MODIFY` | File was modified |
| `IN_ATTRIB` | Metadata changed (permissions, timestamps) |
| `IN_CLOSE_WRITE` | File closed after being opened for writing |
| `IN_OPEN` | File was opened |
| `IN_MOVED_FROM` | Item moved out of watched directory |
| `IN_MOVED_TO` | Item moved into watched directory |
| `IN_CREATE` | Sub-file/directory created |
| `IN_DELETE` | Sub-file/directory deleted |

## Expert Tips

- **Recursive Watching**: Use `rec=True` in `add_watch` to monitor subdirectories. Note that for very large directory trees, you may need to increase the system's `fs.inotify.max_user_watches` sysctl limit.
- **Auto-Add**: When monitoring a directory recursively, pyinotify automatically adds new subdirectories to the watch list as they are created.
- **Async Support**: For integration with event loops, pyinotify provides `AsyncioNotifier`, `TornadoAsyncNotifier`, and `ThreadedNotifier`.
- **Filtering**: Use `ExcludeFilter` to ignore specific patterns (like `.git` or temporary files) to reduce event noise and resource consumption.
- **Event Attributes**: The `event` object passed to handlers contains useful metadata: `event.name` (filename), `event.path` (directory), `event.pathname` (full path), and `event.maskname` (string representation of the event).

## Reference documentation

- [Pyinotify Home](./references/github_com_seb-m_pyinotify.md)
- [Pyinotify Wiki](./references/github_com_seb-m_pyinotify_wiki.md)