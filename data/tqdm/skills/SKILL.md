---
name: tqdm
description: The `tqdm` skill provides procedural knowledge for integrating fast, extensible progress meters into both code and shell environments.
homepage: https://github.com/tqdm/tqdm
---

# tqdm

## Overview

The `tqdm` skill provides procedural knowledge for integrating fast, extensible progress meters into both code and shell environments. It allows you to transform opaque loops into transparent processes by providing real-time statistics such as completion percentage, estimated time of arrival (ETA), and processing speed. This skill covers standard iterable wrapping, manual progress control, and advanced CLI piping techniques.

## Core Usage Patterns

### Python Integration

The most common way to use `tqdm` is by wrapping an existing iterable.

```python
from tqdm import tqdm
from time import sleep

# 1. Automatic iterable wrapping
for item in tqdm(range(1000)):
    sleep(0.01)

# 2. Optimized range shortcut
from tqdm import trange
for i in trange(100, desc="Processing"):
    sleep(0.1)

# 3. Manual control (useful for non-standard loops or streams)
with tqdm(total=100) as pbar:
    for i in range(10):
        # Do work...
        pbar.update(10)
```

### Command Line Interface (CLI)

`tqdm` can be used as a pipe element to monitor data flow without modifying the underlying logic of the commands.

- **Monitor line counts**:
  `find . -name '*.py' | tqdm | wc -l`
- **Monitor file transfers/backups (byte-based)**:
  `tar -zcf - my_folder/ | tqdm --bytes --total $(du -sb my_folder/ | cut -f1) > backup.tgz`
- **Multiple bars in a pipeline**:
  `cat data.txt | tqdm --desc "Reading" | gzip | tqdm --desc "Compressing" > data.gz`

## Expert Tips & Best Practices

- **Notebook Support**: When working in Jupyter or IPython, use `from tqdm.auto import tqdm` to automatically switch between text-based and widget-based progress bars depending on the environment.
- **Low Overhead**: `tqdm` adds only ~60ns per iteration. However, for extremely fast loops (millions of iterations per second), use `mininterval` (e.g., `tqdm(iterable, mininterval=1.0)`) to reduce the display update frequency and save CPU cycles.
- **Description Updates**: Use `pbar.set_description("Current Task")` or `pbar.set_postfix(loss=0.5)` to provide dynamic metadata alongside the progress bar.
- **Resource Management**: Always use the `with` statement or ensure `pbar.close()` is called to prevent terminal artifacts or memory leaks, especially when nesting bars.
- **Unit Scaling**: For data processing, use `--unit_scale` in the CLI to automatically convert large numbers into readable formats (K, M, G).

## Reference documentation

- [tqdm Main Documentation](./references/github_com_tqdm_tqdm.md)
- [tqdm Wiki and Advanced Usage](./references/github_com_tqdm_tqdm_wiki.md)