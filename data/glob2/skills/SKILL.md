---
name: glob2
description: The glob2 tool provides enhanced file pattern matching with support for recursive globstar patterns and the ability to capture specific wildcard matches. Use when user asks to perform recursive file searches, capture metadata from file paths using wildcards, or implement custom globbing for non-standard filesystems.
homepage: https://github.com/miracle2k/python-glob2
metadata:
  docker_image: "quay.io/biocontainers/glob2:0.4.1--py35_0"
---

# glob2

## Overview
The `glob2` skill provides an enhanced version of Python's built-in `glob` module. It is designed for scenarios where standard globbing is insufficient, offering a reliable implementation of recursive "globstar" (`**`) matching and the unique ability to return captured pattern matches alongside filenames. This is particularly useful for batch processing files where metadata (like version numbers or IDs) is embedded in the file path.

## Usage Instructions

### Recursive Globbing
To search through all subdirectories, use the `**` pattern. Note that `**` must be its own directory component.

```python
import glob2

# Find all .h files in src and all subdirectories
headers = glob2.glob('src/**/*.h')

# Note: ** matches the current directory. 
# To find python files in subdirectories but NOT the current directory:
sub_py_files = glob2.glob('*/**/*.py')
```

### Capturing Matches
Use `with_matches=True` to retrieve the specific text that filled the wildcard patterns. This returns a generator yielding tuples of `(filename, matches)`.

```python
import glob2

# If files are named 'project-v1.zip', 'project-v2.zip', etc.
for filename, (version,) in glob2.iglob('./binaries/project-*.zip', with_matches=True):
    print(f"Found version {version} at {filename}")
```

### Custom Globbers
For non-standard filesystems (e.g., SFTP, zip files, or virtual storages), you can subclass the `Globber` class and provide your own filesystem hooks.

```python
from glob2 import Globber

class MyCustomGlobber(Globber):
    def __init__(self, backend):
        self.backend = backend
    
    def listdir(self, path):
        return self.backend.list_files(path)
        
    def exists(self, path):
        return self.backend.path_exists(path)

# Usage
custom_globber = MyCustomGlobber(my_backend)
files = custom_globber.glob('**/*.txt')
```

## Expert Tips and Best Practices
- **Memory Efficiency**: Always prefer `glob2.iglob()` over `glob2.glob()` when dealing with large directory trees, as it returns an iterator instead of loading all paths into memory at once.
- **Pattern Constraints**: Remember that `**h` is invalid for recursion; the double-asterisk must be isolated as a directory element (e.g., `**/h`).
- **Hidden Files**: By default, `glob2` follows standard glob behavior regarding hidden files. If the environment requires including hidden files, ensure the underlying filesystem `listdir` implementation supports it.
- **Symlinks**: When implementing a custom `Globber`, the `islink()` method determines if `**` will follow a directory. Return `False` to prevent infinite recursion in circular symlink structures.

## Reference documentation
- [python-glob2 README](./references/github_com_miracle2k_python-glob2.md)