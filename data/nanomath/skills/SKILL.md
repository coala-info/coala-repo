---
name: nanomath
description: nanomath provides mathematical and statistical functions specifically designed for processing Oxford Nanopore Technologies sequencing data. Use when user asks to calculate N50, compute average Phred quality scores, remove length outliers, or generate read statistics reports.
homepage: https://github.com/wdecoster/nanomath
metadata:
  docker_image: "quay.io/biocontainers/nanomath:1.4.0--pyhdfd78af_0"
---

# nanomath

## Overview

nanomath is a specialized utility library providing mathematical and statistical functions tailored for Oxford Nanopore Technologies (ONT) sequencing data. It simplifies common bioinformatics tasks such as N50 calculation, Phred quality averaging, and outlier removal. While the project was archived in June 2024 and its functionality integrated into the larger NanoPlot package, nanomath remains a lightweight dependency for standalone scripts requiring these specific ONT metrics.

## Installation

Install via bioconda or pip:

```bash
conda install -c bioconda nanomath
# OR
pip install nanomath
```

## Core Python API Usage

nanomath is primarily used as a Python module within other Nanopore processing scripts.

### Statistical Calculations
- **Calculate N50**: Use `get_N50(readlengths)` where `readlengths` is a list or array of integers.
- **Calculate Average Quality**: Use `ave_qual(qualscores)` to compute the average Phred quality of a read. 
    - *Expert Tip*: As of v1.3.0, this function converts Phred scores to error rates, averages them, and converts back to Phred. This is more mathematically accurate for sequencing data than a simple arithmetic mean of Phred scores.
- **Generate Full Statistics**: Use `calc_read_stats(dataframe)` to return a dictionary containing a comprehensive suite of read metrics.

### Data Cleaning and Reporting
- **Outlier Removal**: Use `remove_length_outliers(dataframe, "column_name")` to strip extreme length outliers from a pandas DataFrame.
- **Exporting Reports**: Use `write_stats(dataframe, "output_name")` to write a formatted statistics report to a file.

## CLI Patterns

While primarily a library, some versions support basic CLI reporting:

- **TSV Output**: When using tools that wrap nanomath for statistics, use the `--tsv` flag (available in v1.2.0+) to generate machine-readable tab-separated values instead of formatted text reports.

## Best Practices

- **Deprecation Awareness**: Since nanomath is deprecated as of June 20, 2024, new projects should ideally use the integrated functions within `NanoPlot`. Use nanomath only for maintaining legacy pipelines or when a minimal footprint is required.
- **Data Structures**: Most functions expect either lists of integers (for lengths/scores) or pandas DataFrames. Ensure your data is pre-processed into these formats.
- **Quality Thresholds**: When calculating statistics for "Megabases above quality cutoffs," ensure your input dataframe contains a quality column, otherwise these specific metrics may return "NA" or be omitted.

## Reference documentation
- [nanomath GitHub README](./references/github_com_wdecoster_nanomath.md)
- [Bioconda nanomath Overview](./references/anaconda_org_channels_bioconda_packages_nanomath_overview.md)