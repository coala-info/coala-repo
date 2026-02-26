---
name: rename
description: The rename tool performs sophisticated batch renaming of files using Perl-based transformations and regular expressions. Use when user asks to change file cases, sanitize filenames, perform search-and-replace substitutions, manage file extensions, or dynamically reorganize files into directory structures.
homepage: http://plasmasturm.org/code/rename
---


# rename

## Overview
The `rename` tool is a powerful Perl-based utility designed for sophisticated batch renaming. Unlike simple `mv` commands, it allows for sequential transformations, regex-based substitutions, and automatic directory creation. Use this skill to automate the cleanup of messy filenames, standardize naming conventions across large datasets, or reorganize files into folder structures dynamically.

## Core Usage Patterns

### Basic Transformations
- **Change Case**: Use `-c` for lower-case or `-C` for upper-case.
- **Sanitize**: Use `-z` to remove whitespace, control characters, and shell meta-characters in one step.
- **Search and Replace**: 
  - Single instance: `rename -s "old" "new" *`
  - Global (all instances): `rename -S "old" "new" *`

### Advanced Perl Expressions (`-e`)
The `-e` flag allows you to modify the `$_` variable using Perl code.
- **Regex substitution**: `rename 's/\.jpeg$/\.jpg/' *`
- **Conditional logic**: `rename -e '$_ = "archived_$_" if -M $_ > 30' *` (Prefix files older than 30 days).

### Extension Management
The `-X` flag is a "secret weapon" that strips the extension, applies transformations, and then re-appends it.
- **Clean name but keep extension**: `rename -X -z --camelcase *`
- **Change extension**: `rename -x -a ".newext" *` (Strips old, appends new).

### Dynamic Directory Organization
Use `-p` (mkpath) to create directories on the fly.
- **Move files into folders by extension**: `rename -p -X -e '$_ = "$EXT/$_" if @EXT' *`
- **Organize by first letter**: `rename -p -e '$_ = substr($_, 0, 1) . "/$_"' *`

### Safety and Verification
- **Dry Run**: Always use `-n` first to see what *would* happen without making changes.
- **Verbose**: Use `-v` to see a log of successful renames.
- **Interactive**: Use `-i` to prompt for confirmation before each rename.
- **Counter**: Use `-N` to add incrementing numbers. Example: `rename -N 001 -a "_$N" *` (Adds _001, _002, etc.).

## Expert Tips
- **Order Matters**: Transforms are applied sequentially. `rename -s foo bar -s bar baz` will result in `foo` becoming `baz`.
- **Handling Conflicts**: Use `-k` (backwards/reverse order) when renaming a sequence (e.g., 1.txt -> 2.txt, 2.txt -> 3.txt) to prevent overwriting files before they are processed.
- **Piping**: If you have a complex list of files from another command, use `find . -type f -print0 | rename -0 --stdin [transforms]`.

## Reference documentation
- [rename - Perl-powered file rename script](./references/plasmasturm_org_code_rename.md)
- [bioconda rename overview](./references/anaconda_org_channels_bioconda_packages_rename_overview.md)