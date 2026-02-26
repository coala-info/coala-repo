---
name: r-lncpipereporter
description: The lncpipereporter package compiles lncRNA sequencing analysis results into interactive HTML reports and publication-quality figures. Use when user asks to generate a comprehensive lncRNA report, visualize differential expression results, or summarize alignment and expression statistics.
homepage: https://cran.r-project.org/web/packages/lncpipereporter/index.html
---


# r-lncpipereporter

## Overview
The `lncpipereporter` package is designed to streamline the final stages of lncRNA sequencing data analysis. It automatically scans directories for upstream tool outputs (alignment logs, expression matrices, and lncRNA features) and compiles them into a comprehensive HTML report featuring interactive Plotly charts and searchable DataTables. It supports multiple differential expression (DE) methods and provides publication-quality static figures (TIFF/PDF).

## Installation
To install the package from CRAN:
```R
install.packages("lncpipereporter")
```
Note: This package requires `pandoc` to be installed on the system to generate HTML reports.

## Core Workflow

### 1. Preparing Input Data
The package is designed to find files recursively. You do not need to specify file types, but sample names must be the first part of the filename (delimited by `.` or `_`). Supported files include:
- **Alignment Logs:** STAR (`Log.final.out`), HISAT2 (`.log`), or TopHat (`align_summary.txt`).
- **Expression:** RSEM or general expression matrices.
- **Features:** Basic lncRNA characteristics (length, type, coding potential).
- **Design:** An experimental design file for DE analysis.

### 2. Generating a Report
The primary function is `run_reporter()`.

**Default Run:**
Scans the current directory and outputs to `~/LncPipeReports`.
```R
library(LncPipeReporter)
run_reporter()
```

**Customized Run:**
```R
run_reporter(
  input = "path/to/results",
  output = "my_lncRNA_report.html",
  output_dir = "./final_results",
  de.method = "deseq2",      # Options: 'edger', 'deseq2', 'noiseq'
  theme = "npg",             # ggsci journal themes (e.g., 'npg', 'aaas', 'jco')
  max.lncrna.len = 10000,    # Filter for distribution plots
  ask = FALSE                # Set to TRUE for a GUI parameter selector
)
```

### 3. Understanding Outputs
The function creates a structured directory containing:
- `reporter.html`: The main interactive report.
- `figures/`: High-resolution (300 ppi) TIFF and PDF files for publication (PCA, Volcano, CDF, etc.).
- `tables/`: CSV files of analysis results (e.g., DE results, alignment statistics).
- `libs/`: JavaScript/CSS dependencies for the HTML report.

## Tips for Success
- **Sample Consistency:** Ensure sample names in your experimental design file match the column headers in your expression matrix.
- **Browser Choice:** Use Google Chrome to view the generated HTML reports for the best interactive experience.
- **Static Figures:** The interactive plots in the HTML report allow for scaling and filtering; once adjusted, you can find the corresponding publication-ready versions in the `figures/` subfolder.

## Reference documentation
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)