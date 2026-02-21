---
name: tabulate
description: The `tabulate` skill enables the transformation of raw data structures into formatted tables.
homepage: https://github.com/astanin/python-tabulate
---

# tabulate

## Overview
The `tabulate` skill enables the transformation of raw data structures into formatted tables. It provides a single, powerful function (or CLI utility) that handles column alignment, numeric formatting, and various output styles. Whether you are building a command-line interface that needs to present data clearly to a user or you are automating the generation of documentation, this skill ensures that tabular data is readable and professionally presented.

## Library Usage Patterns

The core functionality is accessed via the `tabulate` function.

### Basic Formatting
Pass a list of lists to get a default formatted table:
```python
from tabulate import tabulate

data = [["Alice", 24], ["Bob", 19]]
print(tabulate(data))
```

### Handling Headers
There are three primary ways to handle headers:
1. **Manual list**: `headers=["Name", "Age"]`
2. **First row of data**: `headers="firstrow"`
3. **Keys from data**: `headers="keys"` (best for dictionaries, DataFrames, or lists of dataclasses)

### Common Table Formats (`tablefmt`)
Choose the format based on your destination:
- `github`: Use for GitHub-flavored Markdown.
- `fancy_grid`: Use for high-quality terminal displays using box-drawing characters.
- `simple`: The default, clean format suitable for most text files.
- `pipe`: Standard Markdown table format.
- `html` / `latex`: For web or academic document generation.
- `plain`: Minimalist output with no borders.

### Working with Row Indices
To add or manage row numbering:
- **Auto-index**: `showindex="always"` adds a 0-based index column.
- **Custom index**: `showindex=[101, 102, 103]` allows passing a custom iterable of IDs.

## CLI Utility Patterns

When installed via pip, the `tabulate` command is available in the terminal. It is particularly useful for formatting CSV data or piped output.

- **Format a file**: `tabulate data.csv`
- **Specify format**: `tabulate data.csv -f github`
- **Use first row as header**: `tabulate data.csv --header`

## Expert Tips

- **Numeric Alignment**: `tabulate` automatically aligns numbers by the decimal point. You can control this behavior using the `numalign` and `stralign` arguments.
- **Missing Values**: Use the `missingval` parameter to define what should be displayed for `None` or empty entries (e.g., `missingval="N/A"`).
- **Data Types**: The tool is highly compatible with data science stacks. You can pass a `pandas.DataFrame` or a `NumPy` array directly into the function without manual conversion.
- **Performance**: For very large tables, consider that `tabulate` calculates column widths based on the entire dataset to ensure perfect alignment, which may have a memory overhead for massive inputs.

## Reference documentation
- [python-tabulate README](./references/github_com_astanin_python-tabulate.md)