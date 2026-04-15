---
name: textinput
description: The textinput package provides an efficient interface for iterating over lines from multiple input streams or standard input. Use when user asks to iterate over file lines, perform in-place file editing, or create Unix-like text processing scripts.
homepage: http://www.ebi.ac.uk/~hoffman/software/textinput/
metadata:
  docker_image: "quay.io/biocontainers/textinput:0.2--py_0"
---

# textinput

## Overview
The `textinput` package provides a more efficient and simplified interface for iterating over lines from multiple input streams. It is designed as a drop-in improvement over the standard `fileinput` module, making it easier to write scripts that function like standard Unix text-processing utilities (such as `sed` or `awk`). It is particularly useful for handling large datasets where memory efficiency and streamlined file handling are priorities.

## Usage Guidelines

### Basic Iteration
Use `textinput` to loop through lines of all files provided as command-line arguments, or standard input if no arguments are provided:

```python
import textinput

for line in textinput.input():
    # Process each line
    print(line.strip())
```

### In-place Editing
To modify files in-place, use the `inplace=True` parameter. This redirects `sys.stdout` to the file currently being read:

```python
import textinput

for line in textinput.input(inplace=True):
    # Replace 'old' with 'new' in the file
    print(line.replace('old', 'new'), end='')
```

### Accessing Metadata
While iterating, you can retrieve information about the current state of the input stream:

- `textinput.filename()`: Returns the name of the file currently being read.
- `textinput.lineno()`: Returns the cumulative line number across all files.
- `textinput.filelineno()`: Returns the line number within the current file.
- `textinput.isfirstline()`: Returns True if the line is the first line of the current file.

### Best Practices
- **Resource Management**: Always ensure the input stream is closed after processing, or use it within a context manager if the version supports it.
- **Buffer Handling**: For large-scale bioinformatics files, `textinput` is preferred over reading entire files into memory.
- **CLI Integration**: Use `textinput` when building tools that need to support piping (`cat file.txt | python script.py`) and explicit file arguments (`python script.py file.txt`) simultaneously.

## Reference documentation
- [textinput Overview](./references/anaconda_org_channels_bioconda_packages_textinput_overview.md)