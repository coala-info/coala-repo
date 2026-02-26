---
name: mawk
description: mawk is an interpreter for the AWK programming language that processes text files based on patterns and rules. Use when user asks to process text files, extract data, or reformat text based on patterns and rules.
homepage: https://www.gnu.org/software/gawk/
---


# mawk

mawk/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_mawk_overview.md
    └── www_gnu_org_software_gawk.md
```

mawk/SKILL.md:
```yaml
name: mawk
description: Interpreter for the AWK Programming Language. Use when Claude needs to process text files, extract data, or reformat text based on patterns and rules, especially for command-line data manipulation tasks.
```
## Overview
`mawk` is a powerful interpreter for the AWK programming language, designed for efficient text processing. It excels at tasks like searching for patterns within files, extracting specific data fields from lines, and reformatting text based on defined rules. It's particularly useful for command-line data manipulation where concise scripting is beneficial.

## Usage Instructions

`mawk` operates by reading input line by line and applying a script of pattern-action pairs.

### Basic Syntax

```bash
mawk 'pattern { action }' input_file(s)
```

-   **`pattern`**: A condition that, if true for the current line, triggers the associated action. If omitted, the action is applied to every line.
-   **`{ action }`**: The commands to execute when the pattern matches. If omitted, the default action is to print the entire line.
-   **`input_file(s)`**: One or more files to process. If no files are specified, `mawk` reads from standard input.

### Common Patterns and Actions

*   **Printing specific fields**: Fields are delimited by whitespace by default. `$1` refers to the first field, `$2` to the second, and so on. `$0` refers to the entire line.
    ```bash
    # Print the first and third fields of each line
    mawk '{ print $1, $3 }' data.txt
    ```
*   **Pattern matching**: Use regular expressions to match lines.
    ```bash
    # Print lines containing the word "error"
    mawk '/error/' logfile.txt

    # Print lines that start with "INFO:"
    mawk '/^INFO:/' logfile.txt
    ```
*   **Conditional execution**: Use `if` statements within actions.
    ```bash
    # Print lines where the second field is greater than 100
    mawk '$2 > 100 { print $0 }' data.txt
    ```
*   **Setting field separators**: Use the `-F` option.
    ```bash
    # Process a CSV file (comma-separated)
    mawk -F',' '{ print $1, $2 }' data.csv
    ```
*   **Built-in variables**:
    *   `NR`: Number of the current record (line number).
    *   `NF`: Number of fields in the current record.
    *   `FS`: Input field separator (default is space).
    *   `OFS`: Output field separator (default is space).
    *   `RS`: Input record separator (default is newline).
    *   `ORS`: Output record separator (default is newline).

### Expert Tips

*   **Chaining commands**: Pipe output from other commands into `mawk`.
    ```bash
    # Count lines containing "success" from a piped command
    some_command | mawk '/success/ { count++ } END { print count }'
    ```
*   **`BEGIN` and `END` blocks**: Execute code before processing any input (`BEGIN`) or after all input has been processed (`END`).
    ```bash
    # Print a header before processing and a total count at the end
    mawk 'BEGIN { print "--- Report Start ---" } { if ($3 > 50) print $1 } END { print "--- Report End ---" }' data.txt
    ```
*   **AWK scripts**: For complex logic, save your `mawk` commands in a `.awk` file and execute it using the `-f` option.
    ```bash
    # my_script.awk
    # BEGIN { print "Processing data..." }
    # { if (NF > 3) print $1 }
    # END { print "Done." }

    mawk -f my_script.awk data.txt
    ```

## Reference documentation
- [mawk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mawk_overview.md)
- [Gawk - GNU Project - Free Software Foundation (FSF)](./references/www_gnu_org_software_gawk.md)