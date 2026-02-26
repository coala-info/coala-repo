---
name: tabview
description: tabview is a terminal-based spreadsheet viewer for interactively exploring and inspecting tabular data. Use when user asks to view CSV or TSV files in the terminal, navigate large datasets with Vim-like keybindings, or visualize Python data structures in a grid.
homepage: https://github.com/firecat53/tabview
---


# tabview

## Overview

`tabview` is a lightweight, curses-based terminal spreadsheet viewer designed for rapid data inspection. It transforms flat text files or Python data structures into an interactive grid, allowing you to scroll, search, and sort data without the overhead of a full spreadsheet application. It is particularly useful for exploring large datasets, verifying CSV exports, or acting as a pager for database query results.

## Command Line Usage

### Basic Invocation
Open a CSV file with default settings:
```bash
tabview data.csv
```

### Navigation and Positioning
Open a file and jump directly to a specific row and column (e.g., row 6, column 5):
```bash
tabview data.csv +6:5
```

### Handling Different Formats
Specify delimiters (e.g., for TSV files) or file encoding:
```bash
tabview data.tsv -d '\t'
tabview data.csv --encoding iso8859-1
```

### Using as a Pager
You can use `tabview` to view the output of database queries or other CLI tools. For MySQL, add this to your `~.my.cnf`:
```ini
pager=tabview -d '\t' --quoting QUOTE_NONE --silent
```

## Essential Keybindings

`tabview` uses Vim-inspired navigation. Press `?` or `F1` inside the app to see the full list.

### Navigation
- **h, j, k, l**: Move left, down, up, right.
- **g / G**: Jump to the top / bottom of the current column.
- **[num]G**: Jump to a specific line number.
- **H / L**: Page left or right.
- **Ctrl-a / Ctrl-e**: Move to the start or end of the current line.

### Data Inspection
- **Enter**: Open a pop-up window to view the full contents of the selected cell.
- **t**: Toggle the first row as a persistent header.
- **/**: Search for text. Use **n** for the next result and **p** for the previous.
- **y**: Yank (copy) cell contents to the clipboard (requires `xsel` or `xclip`).

### Sorting
- **s / S**: Sort the table by the current column (Ascending / Descending).
- **a / A**: Natural sort (better for mixed alphanumeric data).
- **# / @**: Numeric sort.

### Column Management
- **< / >**: Decrease or increase the width of all columns.
- **, / .**: Decrease or increase the width of the current column only.
- **- / +**: Decrease or increase the gap between columns.

## Python Integration

You can use `tabview` to visualize data structures during debugging or within scripts:

```python
import tabview as t

# View a list of lists
data = [["Header1", "Header2"], ["Value1", "Value2"]]
t.view(data)

# View a file with a specific starting position
t.view("large_data.csv", start_pos=(100, 10))
```

## Reference documentation
- [tabview GitHub Repository](./references/github_com_TabViewer_tabview.md)