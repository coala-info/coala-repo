---
name: bioconductor-openprimer
description: This tool designs, analyzes, and compares multiplex PCR primers to maximize template coverage while ensuring physicochemical constraints. Use when user asks to design optimal primer sets, evaluate primer coverage, calculate melting temperatures and GC content, or compare primer sets for amplification fidelity.
homepage: https://bioconductor.org/packages/release/bioc/html/openPrimeR.html
---


# bioconductor-openprimer

name: bioconductor-openprimer
description: Designing, analyzing, and comparing multiplex PCR primers. Use this skill when you need to evaluate primer coverage, calculate physicochemical properties (Tm, GC content, secondary structures), design optimal primer sets for multiple templates, or compare different primer sets for amplification fidelity.

# bioconductor-openprimer

## Overview
The `openPrimeR` package provides a comprehensive framework for the rational design and evaluation of multiplex PCR primers. Its primary goal is to maximize "coverage"—the number of templates amplified by a primer set—while minimizing the number of primers and ensuring they meet strict physicochemical constraints. It integrates external tools (MELTING, ViennaRNA, etc.) to predict primer behavior and offers greedy or ILP-based optimization for primer selection.

## Core Workflow

### 1. Loading Templates and Settings
Templates are loaded into a `Templates` object (a specialized data frame). Settings define the constraints for design and evaluation.

```r
library(openPrimeR)

# Load templates with metadata
fasta.file <- "path/to/templates.fasta"
hdr.structure <- c("ACCESSION", "GROUP", "SPECIES")
tpl.df <- read_templates(fasta.file, hdr.structure, delim = "|", id.column = "GROUP")

# Load predefined settings (e.g., Taq PCR design)
settings.xml <- system.file("extdata", "settings", "A_Taq_PCR_design.xml", package = "openPrimeR")
settings <- read_settings(settings.xml)
```

### 2. Defining Binding Regions
You must specify where primers are allowed to bind.
- **Uniform:** `assign_binding_regions(tpl.df, fw = c(1, 50), rev = c(1, 40))` (relative to 5' for fw, 3' for rev).
- **Individual:** Provide a FASTA file containing specific target sequences (e.g., leader sequences).

### 3. Designing Primers
Use `design_primers` to generate optimal sets.
- `mode.directionality`: "fw", "rev", or "both".
- `init.algo`: "naive" (substrings) or "tree" (degenerate primers).
- `opti.algo`: "Greedy" (fast, approximate) or "ILP" (optimal, slower).

```r
optimal.results <- design_primers(tpl.df, settings = settings, mode.directionality = "fw")
best.primers <- optimal.results$opti
```

### 4. Analyzing Existing Primers
Evaluate a set of primers against templates to check constraint fulfillment and coverage.

```r
# Load primers
primer.df <- read_primers("primers.fasta", fw.id = "_fw")

# Check constraints
constraint.df <- check_constraints(primer.df, tpl.df, settings)

# Update template object with coverage info
tpl.df <- update_template_cvg(tpl.df, constraint.df)

# Get overall coverage ratio
cvg.ratio <- get_cvg_ratio(constraint.df, tpl.df)
```

### 5. Optimization and Filtering
- **Subsetting:** Find the smallest subset of primers that maintains maximum coverage using `subset_primer_set(constraint.df, tpl.df)`.
- **Filtering:** Remove primers that fail specific criteria using `filter_primers(constraint.df, tpl.df, settings, active.constraints = c("gc_clamp", "melting_temp_range"))`.

## Visualization and Reporting
- `plot_template_cvg(constraint.df, tpl.df)`: Visualize coverage per group.
- `plot_constraint_fulfillment(constraint.df, settings)`: Heatmap of passed/failed constraints.
- `plot_primer_binding_regions(constraint.df, tpl.df)`: Map where primers bind relative to targets.
- `create_report(constraint.df, tpl.df, "report.pdf", settings)`: Generate a comprehensive PDF summary.

## Tips for Success
- **External Dependencies:** Ensure `MELTING`, `ViennaRNA`, and `MAFFT` are in your system PATH for full functionality.
- **Constraint Customization:** Access and modify constraints via `constraints(settings)`, `PCR(settings)`, and `conOptions(settings)`.
- **Mismatches:** Control stringency by setting `conOptions(settings)$allowed_mismatches`.
- **Comparison:** To compare multiple sets, pass a list of primer data frames to `plot_constraint_fulfillment` or `plot_constraint`.

## Reference documentation
- [Designing and analyzing multiplex PCR primers with openPrimeR](./references/openPrimeR_vignette.md)