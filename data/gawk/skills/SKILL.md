---
name: gawk
description: Gawk is a text processing tool used for pattern matching, data extraction, and sophisticated file reformatting. Use when user asks to filter records by field values, calculate column sums, manipulate delimited text files, or perform complex string transformations.
homepage: https://www.gnu.org/software/gawk/
metadata:
  docker_image: "quay.io/biocontainers/gawk:5.3.1"
---

# gawk

## Overview
Gawk is the GNU Project's implementation of the AWK programming language, designed for powerful text manipulation and data extraction. It allows for complex data-reformatting and analysis using concise scripts that match patterns and execute actions. Beyond standard AWK functionality, gawk provides advanced features for networking and persistent storage, making it a versatile tool for both quick command-line one-liners and sophisticated data processing pipelines.

## Core CLI Patterns

### Basic Execution
- **One-liners**: `gawk 'pattern { action }' input_file`
- **Running scripts**: `gawk -f script.awk input_file`
- **Field Separator**: Use `-F` to define delimiters (e.g., `-F,` for CSV or `-F'\t'` for TSV).

### Common Variables
- `$0`: The entire current record.
- `$1, $2, ... $N`: Specific fields in the record.
- `NF`: Number of fields in the current record.
- `NR`: Number of records processed so far.
- `FS`: Input field separator (default is whitespace).
- `OFS`: Output field separator.

## Expert Tips and Best Practices

### Efficient Data Extraction
- **Filtering by field**: `gawk '$3 > 100' file.txt` (Prints lines where the third field is greater than 100).
- **Pattern matching**: `gawk '/error/ { print $1, $NF }' logs.txt` (Prints the first and last fields of lines containing "error").
- **Summing a column**: `gawk '{ sum += $1 } END { print sum }' data.txt`

### Advanced Features
- **TCP/IP Networking**: Gawk can communicate over TCP/IP. Use the `gawkinet` manual for syntax regarding the `/inet/` special files.
- **Persistent Memory**: For tasks requiring data to persist across multiple gawk executions, utilize the persistent memory features described in the `gawkpm` manual.
- **Built-in Functions**: Leverage `length()`, `substr()`, `split()`, and `gsub()` for string manipulation without external tools.

### Performance
- For very large files, avoid unnecessary string concatenations in the main loop.
- Use `BEGIN` blocks to initialize variables and `END` blocks for final reporting to minimize per-line overhead.

## Reference documentation
- [Gawk - GNU Project](./references/www_gnu_org_software_gawk.md)