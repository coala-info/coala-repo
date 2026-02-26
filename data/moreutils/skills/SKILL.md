---
name: moreutils
description: The moreutils collection provides a set of specialized Unix utilities designed to fill gaps in standard coreutils for more efficient shell pipelines. Use when user asks to soak up input before writing to the same file, edit data mid-pipeline, run commands only if input is not empty, perform set operations on files, or add timestamps to output.
homepage: https://github.com/madx/moreutils
---


# moreutils

## Overview

The `moreutils` collection provides a set of specialized tools that fill gaps in the traditional Unix/GNU coreutils. These utilities are designed to solve common pipeline frustrations, such as the "read-and-write-to-same-file" problem, the need to inject a text editor into a data stream, or the requirement to perform set operations on text files. Use this skill to implement more robust, readable, and efficient shell workflows.

## High-Utility Patterns and Best Practices

### Safe File Overwriting with `sponge`
Standard redirection (`>`) truncates a file before the command reading it can finish. Use `sponge` to "soak up" all input before writing it to the destination.
- **Pattern**: `grep "pattern" file.txt | sort | sponge file.txt`
- **Benefit**: Allows reading from and writing to the same file in a single pipeline without data loss or the need for manual temporary files.

### Interactive Pipeline Editing with `vipe`
When a pipeline requires manual intervention or inspection of intermediate data, use `vipe`.
- **Pattern**: `command1 | vipe | command2`
- **Usage**: It opens the data in your default `$EDITOR`. Saving and quitting the editor passes the (potentially modified) text to the next command.

### Conditional Execution with `ifne` and `chronic`
These tools are essential for clean automation and cron jobs.
- **ifne**: Runs a command *only if* standard input is not empty.
  - `find /tmp -name "*.err" | ifne mail -s "Errors found" admin@example.com`
- **chronic**: Runs a command quietly, suppressing all output *unless* the command fails (exits non-zero).
  - `chronic backup_script.sh` (Keeps cron logs clean by only reporting errors).

### Bulk Renaming with `vidir`
Edit a directory's contents as if it were a text file.
- **Usage**: Run `vidir` in a directory. It opens a list of files with numeric IDs.
- **Best Practice**: Use your editor's search-and-replace (e.g., `:%s/old/new/g` in Vim) to rename files. Deleting a line in the editor deletes the corresponding file on disk.

### Advanced Piping: `pee` and `mispipe`
- **pee**: Similar to `tee`, but sends input to multiple *commands* instead of files.
  - `cat data.csv | pee "gzip > data.gz" "stats_script.py"`
- **mispipe**: Pipes two commands together but returns the exit status of the *first* command in the pipe, rather than the last. This is useful when the first command's success is the critical metric.

### Set Operations with `combine`
Perform boolean operations on the lines of two files.
- **Intersection**: `combine file1 and file2`
- **Union**: `combine file1 or file2`
- **Difference**: `combine file1 not file2`
- **Symmetric Difference**: `combine file1 xor file2`

### Timestamping with `ts`
Add timestamps to every line of standard input.
- **Pattern**: `long_running_proc | ts '[%Y-%m-%d %H:%M:%S]'`
- **Tip**: Use `ts -incremental` to see the time elapsed between lines of output, which is excellent for profiling slow-running scripts.

## Reference documentation
- [moreutils README](./references/github_com_madx_moreutils.md)