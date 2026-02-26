---
name: r-writexls
description: This tool exports R data frames to Excel XLS or XLSX files using a Perl-based backend. Use when user asks to export data frames to Excel workbooks, save multiple datasets as named worksheets, or apply Excel formatting like frozen panes and auto-filters.
homepage: https://cloud.r-project.org/web/packages/WriteXLS/index.html
---


# r-writexls

name: r-writexls
description: Create Excel 2003 (XLS) and Excel 2007 (XLSX) files from R data frames. Use this skill when you need to export one or more data frames to a single Excel workbook with multiple named worksheets, especially when cross-platform compatibility (via Perl) is required or when specific Excel features like cell comments (from R comment attributes), frozen panes, or auto-filters are needed.

## Overview

The `WriteXLS` package provides a cross-platform solution for writing R data frames to Excel files. It uses Perl as a backend to ensure that Excel files can be created without requiring Excel to be installed on the system. Each data frame is written to a separate worksheet within the workbook.

## Installation

```R
install.packages("WriteXLS")
# Verify Perl and required modules are available
library(WriteXLS)
testPerl()
```

## Core Functions

### testPerl()
Checks if Perl and the necessary Perl modules (e.g., `Excel::Writer::XLSX`) are installed and accessible.
- `testPerl(perl = "perl", verbose = TRUE)`

### WriteXLS()
The primary function for exporting data.
- **Input**: A character vector of data frame names, a list of data frames, or a single data frame.
- **Output**: An `.xls` or `.xlsx` file.

## Common Workflows

### Basic Export
```R
# Export a single data frame
WriteXLS("iris", "iris_data.xlsx")

# Export multiple data frames to separate sheets
WriteXLS(c("mtcars", "iris"), "combined_data.xlsx")

# Export a list of data frames (list names become sheet names)
my_list <- list(Sheet1 = head(iris), Sheet2 = tail(iris))
WriteXLS(my_list, "list_export.xlsx")
```

### Formatting and Sheet Customization
```R
WriteXLS("iris", "formatted_iris.xlsx",
         SheetNames = "Iris Data",
         BoldHeaderRow = TRUE,
         AdjWidth = TRUE,        # Auto-adjust column widths
         AutoFilter = TRUE,      # Add Excel filters to headers
         FreezeRow = 1)          # Freeze the header row
```

### Adding Cell Comments
`WriteXLS` converts R `comment()` attributes into Excel cell comments in the header row.
```R
comment(iris$Sepal.Length) <- "Length of the sepals in cm"
WriteXLS("iris", "comments.xlsx", BoldHeaderRow = TRUE)
```

## Tips and Best Practices

- **Sheet Names**: Must be unique and $\le 31$ characters. Invalid characters: `[]:*?/\`.
- **Data Types**: `WriteXLS` uses `as.character` for coercion. For specific formatting (dates, currency), pre-format the columns as character strings in R before exporting.
- **Missing Values**: Use the `na` argument to specify how `NA` values appear (default is `""`).
- **Encoding**: If dealing with non-ASCII characters, use `Encoding = "UTF-8"`.
- **Overwriting**: `WriteXLS` will overwrite existing files without warning. Ensure the file is not open in Excel during the process, or the function will fail.
- **AllText**: Set `AllText = TRUE` to force all data (including numbers) to be written as text, preserving leading zeros (e.g., for ZIP codes or IDs).

## Reference documentation

- [WriteXLS Reference Manual](./references/reference_manual.md)