---
name: moreutils
description: The moreutils package provides a collection of specialized Unix utilities designed to handle complex data streams, file atomicity, and pipeline logic. Use when user asks to soak input before writing to the same file, edit data mid-pipe, run commands only if input is not empty, add timestamps to streams, or perform set operations on files.
homepage: https://github.com/madx/moreutils
---


# moreutils

## Overview

The `moreutils` package provides a set of "missing" Unix utilities designed to solve common shell scripting challenges that standard coreutils do not address. It is particularly effective for managing data streams, handling file atomicity in pipelines, and providing better control over command output and execution logic.

## Core Utilities and Usage Patterns

### Atomic File Writing with `sponge`
Standard redirection (`>`) truncates a file before the pipe starts reading it. `sponge` soaks up all standard input before writing it to the target file, allowing you to read from and write to the same file in a single pipeline.

- **Overwrite a file safely**: `sed 's/foo/bar/g' file.txt | sponge file.txt`
- **Append with a soak**: `grep "error" log.txt | sponge -a summary.txt`

### Interactive Pipeline Editing with `vipe` and `vidir`
These tools bridge the gap between CLI streams and text editors.

- **Edit data mid-pipe**: `curl https://api.example.com/data | vipe | jq .` (Opens `$EDITOR` to let you manually tweak the JSON before it hits `jq`).
- **Bulk rename/delete files**: Run `vidir` in a directory. It opens a list of files with ID numbers. Edit the filenames or delete lines to rename or remove files upon saving and exiting the editor.

### Stream Logic and Control
- **Conditional execution (`ifne`)**: Run a command only if the input pipe is not empty.
  - `find . -name "*.tmp" | ifne xargs rm` (Prevents `rm` from being called with no arguments).
- **Quiet execution (`chronic`)**: Runs a command and hides its output (stdout/stderr) unless the command fails (non-zero exit code).
  - Useful for cron jobs: `chronic backup_script.sh`
- **Exit status preservation (`mispipe`)**: Pipes two commands but returns the exit status of the first command instead of the last.
  - `mispipe "command_that_might_fail" "logger"`

### Logging and Timestamps
- **Timestamping (`ts`)**: Adds a timestamp to the beginning of every line in a stream.
  - **Standard**: `tail -f access.log | ts`
  - **Custom format**: `tail -f access.log | ts '[%Y-%m-%d %H:%M:%S]'`
  - **Incremental**: `command | ts -i` (Shows time elapsed since the last line).

### Advanced Piping and Combining
- **Tee to pipes (`pee`)**: Similar to `tee`, but sends stdin to multiple commands instead of files.
  - `cat data.csv | pee "gzip > data.gz" "stats_script.py" "logger"`
- **Set operations (`combine`)**: Performs boolean operations (and, or, not, xor) on lines in two files.
  - `combine file1 and file2` (Lines in both).
  - `combine file1 not file2` (Lines in file1 but not in file2).

## Expert Tips
- **Network Info**: Use `ifdata -pa eth0` to get the IP address of an interface without parsing `ifconfig` or `ip addr` output.
- **Error Lookup**: Use `errno <code_or_name>` (e.g., `errno ENOENT`) to quickly find the description of a system error.
- **Parallelization**: While `GNU Parallel` is more famous, the `moreutils` version of `parallel` is a lightweight alternative for running multiple jobs simultaneously: `parallel sh -c "echo processing {}" -- file1 file2 file3`.



## Subcommands

| Command | Description |
|---------|-------------|
| chronic | Runs a command and hides its standard output and standard error unless the command fails (exits non-zero or crashes). |
| combine | Combine the lines in two files using boolean operations (and, or, not, xor). |
| ifne | Run a command if the standard input is not empty (or empty with -n). |
| mispipe | Pipe two commands together and return the exit status of the first command. |
| pee | Pipes standard input to the specified commands. It is similar to tee, but for pipes. |
| sponge | Soak up standard input and write to a file. Unlike a shell redirect, sponge soaks up all its input before opening the output file, allowing for reading from and writing to the same file in a pipeline. |

## Reference documentation
- [moreutils - joeyh.name](./references/joeyh_name_code_moreutils.md)
- [moreutils discussion and tool suggestions](./references/joeyh_name_code_moreutils_discussion.md)
- [moreutils GitHub README](./references/github_com_madx_moreutils.md)