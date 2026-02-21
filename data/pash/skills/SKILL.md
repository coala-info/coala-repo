---
name: pash
description: PaSh is a specialized compiler and runtime system designed to automatically parallelize shell scripts.
homepage: https://github.com/binpash/pash
---

# pash

## Overview

PaSh is a specialized compiler and runtime system designed to automatically parallelize shell scripts. It works by analyzing shell pipelines, identifying data-parallel regions, and transforming them into parallel equivalents that execute across multiple cores. Use this skill to optimize existing shell workflows without manually rewriting them into complex parallel frameworks.

## CLI Usage and Patterns

### Basic Execution
To run a script with default parallelization settings:
```bash
pash script.sh
```

To execute a specific shell command string directly:
```bash
pash -c "cat large_file.txt | grep 'pattern' | sort > output.txt"
```

### Controlling Parallelism
The most important flag for performance tuning is the "width" or degree of parallelization:
```bash
pash -w 4 script.sh
```
*   **Tip**: Set `-w` to match the number of available physical cores or the desired number of parallel data chunks.

### Bash Compatibility
If your script uses Bash-specific syntax (extensions beyond POSIX), you must enable the beta Bash support flag:
```bash
pash --bash script.sh
```

## Best Practices and Expert Tips

### Identifying Parallelizable Regions
PaSh is most effective when scripts contain long pipelines of "stateless" or "data-parallel" commands. 
*   **Supported**: `grep`, `sed`, `awk`, `sort`, `uniq`, `cut`.
*   **Optimization**: If PaSh issues a warning that "no region was parallelized," check if your commands are quoted in a way that prevents the preprocessor from identifying the pipeline structure.

### Performance Tuning
*   **Compilation Overhead**: For very short-running scripts, the overhead of the PaSh compiler and JIT runtime might exceed the time saved by parallelization. Use PaSh primarily for scripts that process gigabytes of data or take several seconds/minutes to run.
*   **Local Annotations**: If you are developing custom commands, PaSh uses an annotation library to understand how to parallelize them. Ensure your environment is configured to point to your local annotations if you are extending the tool.

### Debugging
*   Use `pash --help` to see the full list of available runtime and compiler flags.
*   Monitor the output for stack traces or "erroneous stacktrace" messages which may indicate syntax that the preprocessor cannot yet handle.

## Reference documentation
- [PaSh: Light-touch Data-Parallel Shell Processing](./references/github_com_binpash_pash.md)