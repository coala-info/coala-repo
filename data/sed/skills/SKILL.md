---
name: sed
description: `sed` (stream editor) is a powerful utility used to parse and transform text in a functional, line-oriented manner.
homepage: https://www.gnu.org/software/sed/
---

# sed

## Overview

`sed` (stream editor) is a powerful utility used to parse and transform text in a functional, line-oriented manner. Unlike interactive editors, it accepts commands, applies them to input streams (files or piped data), and outputs the result. It is the standard tool for programmatic text manipulation in Unix-like environments.

## Core Usage Patterns

### Substitution
The most common use case is replacing text using the `s` command.
- **Basic replace**: `sed 's/old/new/' file.txt` (replaces first occurrence per line)
- **Global replace**: `sed 's/old/new/g' file.txt` (replaces all occurrences)
- **Specific lines**: `sed '10,20s/old/new/g' file.txt` (only lines 10 through 20)
- **Case-insensitive**: `sed 's/old/new/gI' file.txt`

### Line Deletion
- **Delete specific line**: `sed '4d' file.txt`
- **Delete range**: `sed '1,5d' file.txt`
- **Delete matching pattern**: `sed '/pattern/d' file.txt`
- **Delete empty lines**: `sed '/^$/d' file.txt`

### Text Extraction and Printing
Use the `-n` flag to suppress default output and `p` to print specific matches.
- **Print specific lines**: `sed -n '5,10p' file.txt`
- **Print only matching patterns**: `sed -n '/pattern/p' file.txt`

### In-place Editing
Modify files directly rather than streaming to stdout.
- **Overwrite file**: `sed -i 's/find/replace/g' file.txt`
- **With backup**: `sed -i.bak 's/find/replace/g' file.txt`

## Expert Tips

- **Change Delimiters**: If the pattern contains slashes (like paths), use a different delimiter to improve readability: `sed 's|/usr/bin|/usr/local/bin|'`.
- **Extended Regex**: Use the `-E` flag to support modern regular expressions (e.g., `+`, `?`, `|`, and grouping `()`) without backslash escaping.
- **Multiple Commands**: Use `-e` to chain operations: `sed -e 's/a/b/' -e 's/c/d/' file.txt`.
- **Address Matching**: Commands can be prefixed with a pattern to limit scope: `/CRITICAL/s/error/warning/` only replaces "error" on lines containing "CRITICAL".
- **Back-references**: Use `\1`, `\2`, etc., to refer to captured groups in the replacement string: `sed -E 's/([0-9]+) units/\1 items/'`.

## Reference documentation

- [GNU sed Overview](./references/www_gnu_org_software_sed.md)
- [GNU sed Manual](./references/www_gnu_org_software_sed_manual.md)