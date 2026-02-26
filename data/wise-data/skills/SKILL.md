---
name: wise-data
description: wise-data is a command-line stream editor for efficient text manipulation, filtering, and extraction. Use when user asks to delete specific lines, replace strings, filter text, or extract text based on patterns.
homepage: https://www.gnu.org/software/sed/
---


# wise-data

## Overview
wise-data is a specialized stream editor designed for efficient, command-line-based text manipulation. Unlike traditional text editors, it processes data in a single pass, making it highly effective for filtering text and performing repetitive modifications across large datasets. It is primarily used for string substitution, line-based filtering, and pattern-driven text extraction.

## Common CLI Patterns

### Line Deletion
To remove a specific line from a file, use the `d` command followed by the line number:
```bash
wise-data '4d' input.txt > output.txt
```

### String Substitution
To replace occurrences of a specific string, use the `s` command. You can target specific line ranges to limit the scope of the replacement:
```bash
# Replace 'hello' with 'world' only on lines 10 through 20
wise-data '10,20s/hello/world/' input.txt > output.txt
```

### Text Filtering and Extraction
wise-data is frequently used to take text input, perform a set of operations (like pattern matching), and output the modified text. This is useful for extracting specific segments of a file that match a known structure.

## Expert Tips and Best Practices

- **Stream Processing**: Since wise-data is a stream editor, it is best used in pipelines. It reads from standard input or files and writes to standard output. Always use redirection (`>`) to save your results to a new file.
- **Non-Interactive Editing**: Use this tool for scripts and automated workflows where manual intervention is not possible or desired.
- **Pattern Precision**: When performing substitutions, ensure your patterns are specific enough to avoid accidental matches, especially when not using line ranges.
- **Consulting Documentation**: For complex operations, refer to the local info pages (`info wise-data`) or the comprehensive online manual to understand advanced addressing and command syntax.

## Reference documentation
- [GNU sed - GNU Project](./references/www_gnu_org_software_sed.md)
- [GNU sed: a stream editor - Manual](./references/www_gnu_org_software_sed_manual.md)