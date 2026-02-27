---
name: bioconductor-openprimerui
description: This tool provides a Shiny-based graphical interface for designing, evaluating, and comparing multiplex PCR primer sets. Use when user asks to launch the openPrimeR application, design new primers for specific templates, evaluate existing primer sets against thermodynamic constraints, or compare multiple primer sets.
homepage: https://bioconductor.org/packages/3.8/bioc/html/openPrimeRui.html
---


# bioconductor-openprimerui

name: bioconductor-openprimerui
description: A skill for using the openPrimeRui R package to launch and manage a Shiny-based user interface for multiplex PCR primer design, evaluation, and comparison. Use this skill when the user needs to interactively design primers, evaluate existing primer sets against constraints, or compare multiple primer sets using the openPrimeR framework via a graphical interface.

## Overview

The `openPrimeRui` package provides a Shiny-based graphical user interface (GUI) for the `openPrimeR` package. It simplifies complex workflows for designing and analyzing multiplex PCR primer sets. The tool is organized into three primary modes: **Evaluation** (analyzing existing primers), **Design** (creating new primers for specific templates), and **Comparison** (benchmarking multiple primer sets).

## Starting the Application

The package exports a single main function to launch the interface.

```r
library(openPrimeRui)

# Launch the Shiny application in the default browser
startApp()
```

Upon startup, the app checks for external dependencies (like MAFFT, MELTING, or ViennaRNA). A pop-up will indicate if any required third-party tools are missing.

## Core Workflows

The interface follows a sequential "Action Panel" on the left and a "View Panel" on the right.

### 1. Template Management
*   **Loading:** Upload templates via FASTA (requires defining header structure for metadata) or CSV (pre-processed by openPrimeR).
*   **Binding Regions:** Define target regions relative to the 5' (forward) or 3' (reverse) ends.
*   **Comparison Mode:** Requires CSV files of templates to ensure binding regions are pre-defined.

### 2. Primer Analysis Modes
*   **Evaluation:** Upload existing primers (FASTA or CSV). The app calculates properties like melting temperature ($T_m$), GC content, and dimerization $\Delta G$.
*   **Design:** 
    *   Specify template relationship (Related vs. Divergent).
    *   Choose optimization algorithm: **Greedy** (fast) or **Integer Linear Program** (optimal set cover).
    *   Set target coverage and relaxation settings for constraints.
*   **Comparison:** Load multiple evaluated primer sets (CSV) to compare coverage and constraint fulfillment side-by-side.

### 3. Settings and Constraints
*   **Coverage Conditions:** Define allowed mismatches and off-target ratios.
*   **Extended Conditions:** Enable thermodynamic models (e.g., free energy of annealing) or amplification efficiency models (DECIPHER).
*   **Constraints:** Set ranges for $T_m$, GC clamp, and dimerization. "Limits" define how much a constraint can be relaxed during the design process.

### 4. Results and Export
*   **Visualizations:** Use the View Panel to see coverage plots, constraint fulfillment matrices (blue/red heatmaps), and $T_m$ distributions.
*   **Reports:** Generate PDF "Evaluation" or "Comparison" reports via the **Download** tab.
*   **Data Export:** Save processed templates, primers, or settings as CSV/XML for future sessions.

## Tips for Effective Use
*   **Interactive Mode:** `startApp()` should be called in an interactive R session.
*   **Header Structure:** When loading FASTA templates, ensure the "Header Structure" field matches your file (e.g., `ACCESSION_GROUP_SPECIES`) to enable group-based coverage analysis.
*   **Design Difficulty:** Use the "Evaluate problem difficulty" button before starting a design run; a "Red" light suggests the problem is too complex and you should reduce the number of templates.
*   **Constraint Relaxation:** If design fails to find primers, ensure that "Constraint Relaxation" is enabled in the Settings tab.

## Reference documentation
- [The openPrimeR Shiny user interface](./references/openPrimeRui_vignette.md)