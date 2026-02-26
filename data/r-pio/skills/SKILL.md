---
name: r-pio
description: The r-pio tool generates formatted, colored, and structured console output in R to improve the readability of scripts and packages. Use when user asks to print headers, display status messages, report warnings or errors, and create pretty object summaries in the R console.
homepage: https://cran.r-project.org/web/packages/pio/index.html
---


# r-pio

name: r-pio
description: Use when Claude needs to generate formatted, colored, or "pretty" console output in R. This skill provides functions for creating headers, informational messages, warnings, and errors designed for better readability in the R console.

# r-pio

## Overview
The `pio` package (Pretty I/O) is designed to enhance the visual quality of R console output. It provides a set of standardized functions to print headers, messages, and object summaries with consistent formatting and color-coding, making it ideal for complex scripts, pipelines, or package development where user feedback is essential.

## Installation
To install the package from CRAN:
```R
install.packages("pio")
```

## Core Functions

### Headers and Titles
Use these to define sections in your console output.
* `pioHdr(string)`: Prints a prominent header for a new section.
* `pioSubHdr(string)`: Prints a sub-header for nested sections.

### Status Messages
Use these to report progress or state.
* `pioMsg(string)`: Prints a standard message.
* `pioInfo(string)`: Prints an informational message (usually prefixed with a blue symbol).
* `pioWarn(string)`: Prints a warning message (usually yellow).
* `pioErr(string)`: Prints an error message (usually red).

### Object Display
* `pioDisp(x, ...)`: A generic function to display objects in a "pretty" format. It is often used to show summaries of complex S3/S4 objects.
* `pioStr(string)`: Returns a formatted string without printing it immediately, useful for inline formatting.

## Workflows

### Standard Reporting Workflow
When building a script that processes data, use `pio` to keep the user informed:

```R
library(pio)

pioHdr("Starting Data Processing Pipeline")

pioInfo("Loading dataset...")
# load data logic
pioMsg("Dataset contains 1000 rows.")

if (data_quality_issue) {
  pioWarn("Missing values detected in column 'Age'.")
}

pioSubHdr("Normalization Step")
# processing logic
pioInfo("Normalization complete.")

pioHdr("Process Finished Successfully")
```

### Customizing Output
Most functions support `crayon`-like coloring if the terminal supports it. You can combine `pio` with standard R logic to create conditional alerts.

## Tips for AI Agents
- **Consistency**: Always use `pioHdr` for the start of a major task and `pioSubHdr` for steps within that task.
- **Error Handling**: Use `pioErr` inside `tryCatch` blocks to provide clear, visible feedback when a process fails.
- **Readability**: Use `pioDisp` instead of `print` or `summary` when working with objects that have `pio` methods defined, as it provides a more concise and readable output.

## Reference documentation
- [README.Rmd.md](./references/README.Rmd.md)
- [README.html.md](./references/README.html.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)