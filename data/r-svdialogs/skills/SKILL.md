---
name: r-svdialogs
description: "Quickly construct standard dialog boxes for your GUI, including    message boxes, input boxes, list, file or directory selection, ... In case R   cannot display GUI dialog boxes, a simpler command line version of these   interactive elements is also provided as fallback solution.</p>"
homepage: https://cloud.r-project.org/web/packages/svDialogs/index.html
---

# r-svdialogs

name: r-svdialogs
description: Use this skill when creating interactive R scripts that require cross-platform GUI dialog boxes. It provides a consistent interface for message boxes, text input, list selection, and file/directory pickers across Windows, macOS, and Linux, including automatic fallback to command-line prompts in non-GUI environments.

# r-svdialogs

## Overview
The `svDialogs` package (part of the SciViews ecosystem) provides a simplified, cross-platform interface for modal dialog boxes in R. It ensures that scripts requiring user interaction work consistently whether run in RGui, RStudio, or a terminal (where it falls back to text-based prompts).

## Installation
Install the package from CRAN:
```r
install.packages("svDialogs")
```

## Core Functions
Most functions return a `gui` object. The user's input or selection is stored in the `$res` component of that object.

### Message Boxes
Display information, warnings, or questions.
```r
library(svDialogs)

# Simple info box
dlg_message("Operation completed successfully.")

# Question with Yes/No (returns "yes", "no", or "cancel")
user_choice <- dlg_message("Do you want to continue?", type = "yesno")$res
```

### Input Boxes
Capture text input from the user.
```r
# Get a string (default value provided)
user_name <- dlg_input("Enter your name:", "Guest")$res

# Note: returns NULL if the user cancels
if (!is.null(user_name)) {
  print(paste("Hello", user_name))
}
```

### List Selection
Select one or more items from a character vector.
```r
items <- c("Regression", "ANOVA", "Random Forest")
selection <- dlg_list(items, multiple = FALSE, title = "Select a method")$res
```

### File and Directory Dialogs
Standard system dialogs for file handling.
```r
# Open file
file_path <- dlg_open(title = "Select a CSV file", filters = dlg_filters["csv", ])$res

# Save file
save_path <- dlg_save(default = "report.pdf", title = "Save report as...")$res

# Select directory
data_dir <- dlg_dir(default = getwd())$res
```

## Workflow Patterns

### Handling Cancellations
Always check if the result is `NULL` or has length zero before proceeding with logic that depends on user input.
```r
res <- dlg_input("Enter value")$res
if (length(res) == 0) {
  stop("User cancelled the operation.")
}
```

### Chaining with Magrittr
The functions are designed to work well in pipes, though you must extract `$res` at the end.
```r
library(magrittr)
val <- dlg_input("Value")$res %>% as.numeric()
```

### Customizing GUI behavior
You can use the `.gui` object to change the default behavior or check the status of the GUI environment, though the default `.gui` object is usually sufficient for standard tasks.

## Reference documentation
- ['SciViews::R' - Standard Dialog Boxes for Windows, MacOS and Linuxes](./references/svDialogs.Rmd)