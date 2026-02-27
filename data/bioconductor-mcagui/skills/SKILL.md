---
name: bioconductor-mcagui
description: This tool provides a graphical user interface for microbial community analysis and statistical simulations in R. Use when user asks to launch the microbial community analysis GUI, extend the interface with custom widgets, or perform repeated simulation trials for ecological data.
homepage: https://bioconductor.org/packages/3.9/bioc/html/mcaGUI.html
---


# bioconductor-mcagui

name: bioconductor-mcagui
description: Microbial Community Analysis GUI (mcaGUI) for R. Use this skill to launch the graphical user interface for microbial community analysis, extend the GUI with custom widgets or menu items, and perform repeated simulation trials for statistical analysis in microbial ecology.

## Overview

The `mcaGUI` package provides a graphical user interface (GUI) for microbial community analysis, built upon the `gWidgets` and `RGtk2` frameworks. It simplifies complex workflows involving OTU (Operational Taxonomic Unit) data, diversity analysis, and visualization. While primarily a GUI-driven tool, it provides programmatic functions to launch the interface, evaluate commands within the GUI environment, and perform simulation-based tasks.

## Core Workflows

### Launching the GUI

The primary entry point is the `mcaGUI()` function.

```r
library(mcaGUI)

# Launch with default settings (RGtk2 toolkit)
mcaGUI()

# Launch with specific dimensions and output redirection
mcaGUI(cliType = "GUI", width = 1000, height = 750)
```

- `cliType`: Set to "console" to see output in the R terminal, or "GUI" to redirect output to a widget within the application.
- `guiToolkit`: Defaults to "RGtk2".

### Extending the Interface

You can programmatically add custom functionality to the active GUI session:

- **Add a Widget**: Use `pmg.add(widget, label)` to add a gWidgets object to the main notebook.
- **Add a Function Dialog**: Use `pmg.gw(lst, label)` to add a `ggenericwidget` (auto-generated from function formals).
- **Add Menu Items**: Define a list `pmg.user.menu` before startup or use `pmg.addMenubar(menulist)` to add top-level menu entries.
- **Evaluate Commands**: Use `pmg.eval("command_string")` to execute code in the global environment from the GUI context.

### Dynamic Exploration

The package includes "dynamic" widgets that update immediately upon data changes or drag-and-drop actions.

```r
# Launch the Lattice Explorer for dynamic visualization
dLatticeExplorer()
```
- This allows for rapid exploration of univariate (~x) and bivariate (x ~ y) relationships using lattice graphics.

### Simulation and Repeated Trials

For microbial ecology simulations (e.g., null model testing or power analysis), use `pmgRepeatTrials`. This is a wrapper around `sapply` designed for easy repetition of R expressions.

```r
# Repeat a simple random generation 100 times
results <- pmgRepeatTrials(rnorm(1), n = 100)

# Complex simulation: Linear model coefficients for community data
# Example: testing relationship between kids and parents
g <- data.frame(
  father = c(78.5, 78.5, 77.5, 76.0, 75.5),
  nkids = c(4, 1, 2, 4, 5)
)
sim_results <- pmgRepeatTrials(coef(lm(father ~ sample(nkids), data = g)), n = 100)
```

## Implementation Tips

- **Dependencies**: Ensure `RGtk2` and `gWidgetsRGtk2` are properly configured in the R environment, as the GUI will fail to launch without a valid X11/GTK+ display.
- **Global Environment**: `pmg.eval` and the GUI's internal command area operate on the Global Environment. Be cautious of variable name collisions.
- **Data Input**: The GUI supports drag-and-drop for variables. If a column from an `idf` instance is dropped into a dynamic widget, the widget will update automatically if that column is edited.

## Reference documentation

- [Microbial Community Analysis GUI Manual](./references/reference_manual.md)