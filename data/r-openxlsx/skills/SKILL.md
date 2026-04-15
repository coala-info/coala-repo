---
name: r-openxlsx
description: The openxlsx package provides a high-level interface for creating, styling, and manipulating Excel .xlsx files in R without requiring Java. Use when user asks to write data frames to Excel files, create multi-sheet workbooks, apply conditional formatting, or insert plots and styles into spreadsheets.
homepage: https://cloud.r-project.org/web/packages/openxlsx/index.html
---

# r-openxlsx

## Overview
The `openxlsx` package provides a high-level interface for the creation and manipulation of .xlsx files. Unlike the `xlsx` package, it uses `Rcpp` for high performance and does not require Java. It allows for fine-grained control over worksheet appearance, including conditional formatting, data validation, and styling.

## Installation
To install the package from CRAN:
```R
install.packages("openxlsx")
library(openxlsx)
```

## Core Workflows

### 1. Simple Writing
For quick exports, use `write.xlsx()`. It can handle single data frames or lists of data frames (where list names become sheet names).
```R
# Single sheet
write.xlsx(iris, file = "data.xlsx")

# Multiple sheets
l <- list("Iris_Data" = iris, "Mtcars_Data" = mtcars)
write.xlsx(l, file = "multisheet.xlsx", asTable = TRUE)
```

### 2. Workbook Object Workflow
For complex tasks (styling, plots, multiple data regions), use the Workbook object approach:
```R
wb <- createWorkbook()
addWorksheet(wb, "Summary")

# Write data
writeData(wb, "Summary", x = iris, startCol = 2, startRow = 3)

# Save
saveWorkbook(wb, "complex_output.xlsx", overwrite = TRUE)
```

### 3. Styling and Formatting
Styles are created with `createStyle()` and applied with `addStyle()`.
```R
# Create a style
headerStyle <- createStyle(
  fontSize = 12, fontColour = "#FFFFFF", fgFill = "#4F81BD",
  halign = "center", textDecoration = "bold", border = "Bottom"
)

# Apply to specific cells
addStyle(wb, sheet = 1, style = headerStyle, rows = 1, cols = 1:5, gridExpand = TRUE)

# Set column widths
setColWidths(wb, sheet = 1, cols = 1:5, widths = "auto")
```

### 4. Conditional Formatting
Apply rules to highlight data based on values.
```R
negStyle <- createStyle(fontColour = "#9C0006", bgFill = "#FFC7CE")
posStyle <- createStyle(fontColour = "#006100", bgFill = "#C6EFCE")

# Rule-based formatting
conditionalFormatting(wb, "Sheet1", cols = 1, rows = 1:10, rule = "<0", style = negStyle)
conditionalFormatting(wb, "Sheet1", cols = 1, rows = 1:10, rule = ">0", style = posStyle)

# Specialized types: duplicates, contains, colourScale, databar
conditionalFormatting(wb, "Sheet1", cols = 2, rows = 1:10, type = "duplicates")
```

### 5. Inserting Plots
You can insert the current active R plot into a worksheet.
```R
plot(iris$Sepal.Length, iris$Sepal.Width)
insertPlot(wb, "Summary", width = 6, height = 4, startCol = "G", startRow = 2)
```

## Tips and Best Practices
- **Global Options**: Set default borders or date formats using `options("openxlsx.borderStyle" = "thin")` or `options("openxlsx.dateFormat" = "yyyy-mm-dd")`.
- **Class-based Formatting**: Assign classes like "currency", "accounting", "percentage", or "scientific" to data frame columns before using `write.xlsx` to trigger automatic Excel formatting.
- **Freeze Panes**: Use `freezePane(wb, sheet, firstRow = TRUE)` to keep headers visible.
- **Performance**: For very large datasets, `writeDataTable` is often more efficient than `writeData` for Excel's internal processing.

## Reference documentation
- [Formatting with openxlsx](./references/Formatting.Rmd)
- [Introduction to openxlsx](./references/Introduction.Rmd)