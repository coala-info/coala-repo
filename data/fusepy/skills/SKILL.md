---
name: fusepy
description: `fusepy` is a lightweight, single-file Python module that provides ctypes bindings for FUSE.
homepage: http://github.com/terencehonles/fusepy
---

# fusepy

## Overview
`fusepy` is a lightweight, single-file Python module that provides ctypes bindings for FUSE. It allows developers to create fully functional filesystems in user space by mapping standard system calls—such as reading, writing, and directory listing—to Python methods. This skill provides the procedural knowledge required to implement the `Operations` interface and mount virtual drives.

## Installation
The package can be installed via conda or pip:
```bash
conda install bioconda::fusepy
# OR
pip install fusepy
```
**Requirement**: FUSE 2.6 or later must be installed on the host system (e.g., `libfuse-dev` on Linux or MacFUSE on macOS).

## Core Implementation Pattern
To create a filesystem, you must subclass `fuse.Operations` and pass it to the `fuse.FUSE` constructor.

### 1. Define Operations
Implement the methods corresponding to the filesystem calls you wish to support.
```python
from fuse import Operations, LoggingMixIn

class MyFS(LoggingMixIn, Operations):
    def getattr(self, path, fh=None):
        # Return a dictionary of stat attributes (st_mode, st_nlink, etc.)
        pass

    def readdir(self, path, fh):
        # Yield directory entries
        return ['.', '..', 'file1.txt']

    def read(self, path, size, offset, fh):
        # Return a string/bytes buffer of data
        pass
```

### 2. Mount the Filesystem
```python
from fuse import FUSE
import sys

if __name__ == '__main__':
    # Usage: python script.py /path/to/mountpoint
    FUSE(MyFS(), sys.argv[1], foreground=True, nothreads=True)
```

## Common CLI and Runtime Patterns
- **Foreground Execution**: Use `foreground=True` in the `FUSE` constructor to keep the process in the terminal and see `print()` or logging output.
- **Single Threading**: Use `nothreads=True` if your Python logic is not thread-safe or to simplify debugging.
- **Unmounting**: Use the standard system command to unmount if the Python process is killed:
  - Linux: `fusermount -u /path/to/mount`
  - macOS: `umount /path/to/mount`

## Expert Tips
- **Error Handling**: To signal filesystem errors (like "File Not Found"), import `errno` and raise `fuse.FuseOSError`.
  ```python
  import errno
  raise FuseOSError(errno.ENOENT)
  ```
- **Context Awareness**: Use `fuse.fuse_get_context()` inside your methods to retrieve the `uid`, `gid`, and `pid` of the process calling the filesystem. This is essential for implementing permissions.
- **Attribute Dictionary**: The `getattr` method expects keys like `st_mode`, `st_nlink`, `st_size`, `st_ctime`, `st_mtime`, and `st_atime`.
- **Binary Data**: In Python 3, ensure the `read` method returns `bytes` and `write` handles `bytes` objects.

## Reference documentation
- [github_com_terencehonles_fusepy.md](./references/github_com_terencehonles_fusepy.md)
- [anaconda_org_channels_bioconda_packages_fusepy_overview.md](./references/anaconda_org_channels_bioconda_packages_fusepy_overview.md)
- [github_com_terencehonles_fusepy_tree_master_examples.md](./references/github_com_terencehonles_fusepy_tree_master_examples.md)