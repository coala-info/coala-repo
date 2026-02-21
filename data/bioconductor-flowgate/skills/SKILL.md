---
name: bioconductor-flowgate
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowGate.html
---

# bioconductor-flowgate

name: bioconductor-flowgate
description: Interactive manual gating for flow cytometry data in R using the flowGate package. Use this skill when you need to perform GUI-based gating within an R environment, create GatingSets from FCS files, apply biexponential transformations, or execute a multi-step gating strategy on cytometry data.

## Overview
The `flowGate` package bridges the gap between manual, GUI-based gating (common in software like FlowJo) and the R/Bioconductor ecosystem. It provides a Shiny-based interactive interface to draw gates (polygons, rectangles, spans, and quadrants) directly on R objects. It integrates seamlessly with `flowCore`, `flowWorkspace`, and `ggcyto`.

## Typical Workflow

### 1. Data Preparation
Load FCS files into a `flowSet`, then convert to a `GatingSet` for analysis.

```r
library(flowGate)
library(flowCore)
library(flowWorkspace)

# Load FCS files
path_to_fcs <- "./data/"
fs <- read.flowSet(path = path_to_fcs, pattern = ".FCS$", full.names = TRUE)

# Convert to GatingSet
gs <- GatingSet(fs)

# Apply compensation (example using acquisition-defined spillover)
comp_matrix <- spillover(fs[[1]])$SPILL
gs <- compensate(gs, compensation(comp_matrix))
```

### 2. Interactive Gating
Use `gs_gate_interactive` to open the Shiny UI. Select the gate type in the UI **before** drawing.

```r
# Gate Leukocytes on FSC/SSC
gs_gate_interactive(gs, 
                    filterId = "Leukocytes", 
                    dims = list("FSC-H", "SSC-H"))

# Gate a subset (e.g., CD45+ cells within Leukocytes)
gs_gate_interactive(gs, 
                    filterId = "CD45", 
                    dims = "CD45", 
                    subset = "Leukocytes")
```

**Gate Types:**
- **Polygon:** Click multiple points to trace; click "Done" to close.
- **Rectangle/Span:** Click and drag. Span only considers the x-axis.
- **Quadrant:** Click once at the center point. Note: This creates four child populations automatically named based on markers.

### 3. Applying a Gating Strategy
For reproducible workflows, define a strategy in a tibble and apply it across samples.

```r
strategy <- tibble::tribble(
  ~filterId,    ~dims,                  ~subset,
  "Leukocytes", list("FSC-H", "SSC-H"), "root",
  "CD45",       list("CD45"),           "Leukocytes",
  "CD33_CD15",  list("CD33", "CD15"),   "CD45"
)

gs_apply_gating_strategy(gs, gating_strategy = strategy)
```

### 4. Visualization and Scaling
`flowGate` allows on-the-fly biexponential scaling in the UI. To replicate these plots in `ggcyto`, use the parameters returned by the gating function.

```r
library(ggcyto)
ggcyto(gs[[1]], aes("CD33", "CD15")) +
  geom_hex(bins = 128) +
  scale_x_flowjo_biexp(maxValue = 250000, widthBasis = -10) +
  scale_y_flowjo_biexp(maxValue = 250000, widthBasis = -10) +
  geom_gate(gs_get_pop_paths(gs)[4:7]) + # Quadrant gates
  geom_stats()
```

### 5. Exporting Results
Extract population statistics or save the entire analysis state.

```r
# Get percentages
stats <- gs_pop_get_stats(gs, type = "percent")

# Get MFI
mfi <- gs_pop_get_stats(gs, type = pop.MFI)

# Save GatingSet (use save_gs, not saveRDS)
save_gs(gs, "my_analysis.gs")
```

## Tips and Best Practices
- **UI Sequence:** Always select the radio button for the gate type (Polygon, Rectangle, etc.) in the Shiny app before clicking on the plot.
- **Large Data:** If the UI is sluggish or gates "drift," apply transformations (e.g., `estimateLogicle`) to the `GatingSet` before calling `gs_gate_interactive`.
- **Quadrant Names:** Quadrant gates ignore the `filterId` and generate names like `Marker1-Marker2+`. Use `gs_get_pop_paths(gs)` to find the exact strings for plotting.
- **Windows Paths:** When loading a saved GatingSet on Windows, wrap the path in `file.path()` to avoid directory errors: `load_gs(file.path("path/to/gs"))`.

## Reference documentation
- [flowGate](./references/flowGate.md)