---
name: r-caroline
description: "The caroline R library contains dozens of functions useful  for: database migration (dbWriteTable2), database style joins &amp;  aggregation (nerge, groupBy, &amp; bestBy), data structure  conversion (nv, tab2df), legend table making (sstable &amp; leghead),  automatic legend positioning for scatter and box plots (),    plot annotation (labsegs &amp; mvlabs), data visualization   (pies, sparge, confound.grid &amp; raPlot), character string manipulation (m &amp; pad),  file I/O (write.delim), batch scripting, data exploration, and more.  The package's greatest contributions lie in the database style merge,   aggregation and interface functions as well as in it's extensive  use and propagation of row, column and vector names in most functions.</p>"
homepage: https://cloud.r-project.org/web/packages/caroline/index.html
---

# r-caroline

name: r-caroline
description: Expert guidance for the 'caroline' R package. Use this skill when performing database-style data manipulation (merging, grouping, best-hit selection), specialized data visualizations (RA plots, pie charts on maps, marginal plots), or utility tasks like string padding and delimited file I/O in R.

## Overview
The caroline R package provides a diverse collection of utilities designed to enhance data structure handling, database-style operations, and complex visualizations. Its primary strengths include the propagation of row and column names throughout transformations and providing robust tools for data aggregation and annotation.

## Installation
To install the package from CRAN:
install.packages("caroline")

## Main Functions and Workflows

### Data Manipulation and Database-Style Joins
The package excels at handling data frames with a focus on row names and grouping logic.

- nerge(): A "named merge" that joins data frames based on row names rather than explicit columns.
- groupBy(): Aggregates data frames based on a grouping variable, similar to SQL GROUP BY, but optimized for R data structures.
- bestBy(): Subsets a data frame by picking the "best" record within each group based on a specific sort order (e.g., highest score or lowest p-value).
- dbWriteTable2(): An enhanced version of database table writing, useful for migrations and ensuring schema consistency.

### Data Structure Conversion
- nv(): Quickly creates a named vector from a data frame or two vectors, where one provides the values and the other the names.
- tab2df(): Converts table objects into data frames while preserving dimensional information effectively.

### Visualization and Annotation
caroline provides unique plotting functions for multi-dimensional data.

- raPlot(): Generates Ratio-Average (RA) plots, commonly used in transcriptomics or comparison studies to visualize differences versus averages.
- pies(): Allows for the placement of pie charts at specific coordinates on an existing plot (e.g., over a map or scatter plot).
- sparge(): Creates scatter plots with marginal histograms or density plots to visualize distribution alongside correlation.
- mvlabs() and labsegs(): Tools for annotating plots where labels need to be moved or connected to points via segments to avoid overlap.
- confound.grid(): A visual tool for identifying potential confounding variables in a dataset.

### Utilities and File I/O
- write.delim(): A convenient wrapper for writing delimited files (defaulting to tabs) with sensible defaults for row names.
- pad(): Pads strings with characters (like leading zeros) to a specific length, useful for ID standardization.
- m(): A shorthand for regex matching and extraction.

## Tips for Effective Usage
- Row Name Consistency: Many caroline functions (like nerge) rely on row names. Ensure your data frames have unique and meaningful row names before using these utilities.
- Aggregation: Use groupBy() when you need to apply different aggregation functions to different columns simultaneously in a concise manner.
- Plotting: When using pies(), ensure your coordinate system is already established by a base plot (like a map or an empty plot() call).

## Reference documentation
- [caroline: Database, Data Structure, and Visualization Utilities](./references/home_page.md)