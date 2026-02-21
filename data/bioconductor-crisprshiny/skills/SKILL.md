---
name: bioconductor-crisprshiny
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprShiny.html
---

# bioconductor-crisprshiny

name: bioconductor-crisprshiny
description: Interactive visualization and exploration of CRISPR guide RNAs (gRNAs) using Shiny. Use this skill to create self-contained Shiny apps or integrate CRISPR exploration modules into larger R/Shiny applications for GuideSet objects created via the crisprVerse ecosystem.

## Overview

The `crisprShiny` package provides a graphical interface for interacting with `GuideSet` objects (from the `crisprDesign` package). It allows researchers to filter, visualize, and inspect gRNA annotations—including on-target scores, off-target alignments, genomic context, and isoform specificity—without writing complex custom plotting code.

## Core Workflow

### 1. Launching a Self-Contained App
The simplest way to explore a `GuideSet` is to pass it directly to the `crisprShiny` function.

```r
library(crisprShiny)
library(shiny)

# Assuming 'gs' is a GuideSet object from crisprDesign
app <- crisprShiny(gs)

# To include gene model visualization (requires a GRangesList)
app <- crisprShiny(gs, geneModel = txdb_kras)

# Run the app
runApp(app)
```

### 2. Using Shiny Modules
For integration into existing dashboards, use the `crisprUI` and `crisprServer` modules.

**UI Side:**
```r
ui <- fluidPage(
    crisprUI("my_id")
)
```

**Server Side:**
```r
server <- function(input, output, session) {
    crisprServer("my_id", guideSet = gs_reactive())
}
```

## Key Features and Components

### On-Targets Table
* Displays all non-list `mcols` from the `GuideSet`.
* **Scores:** Automatically renders blue bars for `crisprScore` columns.
* **Flags:** Highlights `TRUE/FALSE` columns (e.g., `inRepeats`, `polyT`) for quick quality control.
* **Filtering:** Accessible via the "Filter on-targets" button.

### gRNA Filters
The app dynamically generates filters based on available annotations:
* **Nucleotide content:** GC content, polyT sequences, and PAM validity.
* **Off-target count:** Limits based on mismatch counts (n0, n1, etc.) and genomic context (CDS/Promoter).
* **Scores:** Thresholds for on-target and off-target scoring metrics.
* **Genomic Features:** Overlaps with SNPs, repeats, or Pfam domains.

### Visualization
* Select up to 20 gRNAs from the table to visualize their genomic coordinates.
* Requires `gene_symbol` or `gene_id` in the `GuideSet` metadata.
* Uses `crisprViz` logic to render tracks.

### Detailed Annotation Tabs
When a specific gRNA is selected, the bottom panel provides:
* **Alignments:** Detailed table of on- and off-target locations with mismatch positions.
* **Gene/TSS/SNP/Restriction Enzyme:** Tabular views of specific genomic overlaps.

## Usage Tips
* **Data Preparation:** Ensure your `GuideSet` is fully annotated using `crisprDesign` (e.g., `addSpacerAlignments`, `addOnTargetScores`) before passing it to `crisprShiny` to enable all filtering features.
* **Custom Columns:** You can add custom metadata to `mcols(gs)`. These will appear in the main table automatically, provided they are not list-columns.
* **Interactive Selection:** In the alignments tab, selecting a row in the off-target table will update the visualization to show that specific off-target site.

## Reference documentation

- [Introduction to crisprShiny](./references/intro.md)
- [Introduction to crisprShiny (RMarkdown)](./references/intro.Rmd)