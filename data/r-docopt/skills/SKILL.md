---
name: r-docopt
description: The r-docopt tool creates command-line interfaces for R scripts by parsing a standardized help message. Use when user asks to define command-line arguments, parse usage patterns, or generate help messages for R scripts.
homepage: https://cloud.r-project.org/web/packages/docopt/index.html
---


# r-docopt

## Overview
`docopt` for R allows you to define a command-line interface by simply writing a help message in a specific format. It automatically generates a parser that ensures program invocations match the defined usage patterns, handling options, arguments, and commands.

## Installation
```R
install.packages("docopt")
library(docopt)
```

## Core Workflow
1. **Define the Docstring**: Create a character string containing the "Usage" and "Options" sections.
2. **Call docopt()**: Pass the docstring to the `docopt()` function.
3. **Access Arguments**: Use the returned named list to access parameters in your R script.

### Example Implementation
```R
'Usage:
  my_script.R ship <name> move <x> <y> [--speed=<kn>]
  my_script.R mine (set|remove) <x> <y> [--moored | --drifting]
  my_script.R (-h | --help)

Options:
  -h --help     Show this screen.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Moored (anchored) mine.
' -> doc

library(docopt)
# version is optional; if provided, --version is handled automatically
args <- docopt(doc, version = 'Naval Fate 1.0')

# Accessing values
if (args$ship) {
  cat(paste("Moving ship", args$name, "to", args$x, args$y, "at speed", args$speed))
}
```

## Syntax Rules
- **Usage**: Must start with `Usage:` (case-insensitive).
- **Arguments**: Indicated by `<angular_brackets>` or `UPPERCASE`.
- **Options**: Indicated by dashes (`-o`, `--option`). Use `[default: value]` in the description to specify defaults.
- **Commands**: Words that do not follow the dash convention (e.g., `ship`, `new`).
- **Patterns**:
  - `[]`: Optional elements.
  - `()`: Required elements.
  - `|`: Mutual exclusivity.
  - `...`: Repeatable elements.

## Execution
To run an R script using `docopt` from the terminal:
```bash
Rscript my_script.R ship "Black Pearl" move 10 20 --speed=15
```

## Tips
- **List Access**: `docopt` returns a list where keys are both the full flag (e.g., `args$"--speed"`) and the simplified name (e.g., `args$speed`).
- **Type Conversion**: By default, `docopt` returns strings or logicals. Manual conversion (e.g., `as.numeric(args$x)`) is required for math.
- **Error Handling**: If the user provides arguments that don't match the `Usage` section, `docopt` will automatically print the help message and terminate the script.

## Reference documentation
- [docopt: Command-Line Interface Specification Language](./references/README.md)