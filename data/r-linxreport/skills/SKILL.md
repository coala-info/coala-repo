---
name: r-linxreport
description: R package linxreport (documentation from project home).
homepage: https://cran.r-project.org/web/packages/linxreport/index.html
---

# r-linxreport

name: r-linxreport
description: Generate HTML reports and parse results from the LINX structural variant tool. Use this skill when you need to visualize LINX structural variant outputs, create summary reports for genomic samples, or programmatically access LINX data tables in R.

# r-linxreport

## Overview
`linxreport` is an R package designed to generate comprehensive HTML reports from the outputs of the LINX structural variant tool (Hartwig Medical Foundation). It parses LINX data tables and integrates plots into a navigable, tabbed interface. It is primarily a reporting and parsing tool; it does not perform the structural variant analysis itself.

## Installation
Install the package from GitHub using `remotes`:

```r
# install.packages("remotes")
remotes::install_github("umccr/linxreport")
```

## Core Workflow
The primary function is `linx_rmd()`, which automates the creation of the HTML report.

### Generating a Report
To create a report, you must provide the sample name and the directories containing the LINX output files.

```r
library(linxreport)

# Define paths to LINX outputs
sample_id <- "subject_a.tumor"
tables_path <- "path/to/linx/tables"
plots_path <- "path/to/linx/plots"

# Generate the HTML report
linxreport::linx_rmd(
  sample = sample_id,
  table_dir = tables_path,
  plot_dir = plots_path,
  out_file = "sample_report.html",
  quiet = TRUE
)
```

### Key Parameters for `linx_rmd()`
- `sample`: The file prefix/sample name used by LINX.
- `table_dir`: Directory containing `.tsv` files (e.g., clusters, drivers, links).
- `plot_dir`: Directory containing LINX-generated `.png` or `.svg` plots.
- `out_file`: The destination path for the generated HTML.

## Usage Tips
- **File Size Warning**: The resulting HTML file embeds all plots. If a sample has hundreds of structural variant plots, the HTML file can exceed 200MB.
- **Data Parsing**: Beyond reporting, the package contains internal functions to parse LINX tables. These are useful for downstream genomic analysis where you need to load LINX results into R data frames.
- **No Analysis**: Remember that `linxreport` is a visualization layer. It expects the LINX pipeline to have already completed successfully.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)