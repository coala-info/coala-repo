---
name: grep
description: Grep searches input files for lines that match specific patterns using regular expressions. Use when user asks to search for text, filter log files, find patterns recursively in directories, or extract specific data from files.
homepage: https://www.gnu.org/software/grep/
metadata:
  docker_image: "ubuntu:latest"
---

# grep

## Overview
Grep (Global Regular Expression Print) is a fundamental command-line utility used to search one or more input files for lines that match a specific pattern. It is essential for log analysis, code auditing, and data extraction. This skill focuses on high-performance search patterns, recursive directory traversal, and leveraging different regex engines (Basic, Extended, and Perl-compatible) to efficiently filter text data.

## Core Usage Patterns

### Basic Searching
*   **Standard search**: `grep "pattern" file.txt`
*   **Case-insensitive**: `grep -i "pattern" file.txt`
*   **Invert match (exclude)**: `grep -v "pattern" file.txt`
*   **Count matches**: `grep -c "pattern" file.txt`
*   **Show line numbers**: `grep -n "pattern" file.txt`

### Recursive and Multi-file Search
*   **Recursive search**: `grep -r "pattern" .` (Follows symlinks: `grep -R`)
*   **List filenames only**: `grep -l "pattern" *.log`
*   **List files without matches**: `grep -L "pattern" *`
*   **Include/Exclude files**: `grep -r --include="*.py" "pattern" .` or `grep -r --exclude-dir={node_modules,dist} "pattern" .`

### Advanced Regex Engines
*   **Extended Regex (ERE)**: `grep -E "pattern1|pattern2"` (Equivalent to `egrep`)
*   **Fixed Strings**: `grep -F "plain_text_string"` (Faster for non-regex searches; equivalent to `fgrep`)
*   **Perl-compatible Regex (PCRE)**: `grep -P "\d+\.\d+\.\d+\.\d+"` (Useful for complex lookaheads and non-greedy matching)

### Context Control
*   **After match**: `grep -A 3 "pattern" file.txt` (Shows 3 lines after)
*   **Before match**: `grep -B 2 "pattern" file.txt` (Shows 2 lines before)
*   **Around match**: `grep -C 2 "pattern" file.txt` (Shows 2 lines before and after)

## Expert Tips
*   **Performance**: Use `LC_ALL=C grep` to significantly speed up searches in large files by using the "C" locale instead of UTF-8, provided you only need to match ASCII characters.
*   **Whole Words**: Use `-w` to match the pattern as a whole word only (e.g., `grep -w "is"` won't match "this").
*   **Exact Line Match**: Use `-x` to match only if the entire line matches the pattern exactly.
*   **Quiet Mode**: Use `-q` in scripts to suppress output; grep will exit with status 0 if a match is found and non-zero otherwise.
*   **Binary Files**: By default, grep may skip binary files or treat them as text. Use `--binary-files=without-match` to avoid binary output cluttering the terminal.

## Installation
Grep is typically pre-installed on Unix-like systems. For specific environments like Bioconda, it can be managed via:
`conda install bioconda::grep`

## Reference documentation
- [Grep - GNU Project](./references/www_gnu_org_software_grep.md)
- [bioconda | grep](./references/anaconda_org_channels_bioconda_packages_grep_overview.md)
- [GNU grep manual](./references/www_gnu_org_software_grep_manual.md)
- [Information for GNU grep developers](./references/www_gnu_org_software_grep_devel.html.md)