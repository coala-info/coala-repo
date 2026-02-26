---
name: multiqc
description: MultiQC aggregates log files and output data from multiple bioinformatics tools into a single interactive HTML report and structured data tables. Use when user asks to summarize analysis results, generate a quality control report, identify batch effects, or visualize metrics across multiple samples.
homepage: https://multiqc.info/
---


# multiqc

## Overview
MultiQC is a reporting tool that searches a given directory for log files and output data from supported bioinformatics software. It parses these disparate formats to create a unified, interactive HTML report and a directory of "clean" data tables. It is the industry standard for identifying batch effects, outliers, and general sample quality across large-scale sequencing projects without manually inspecting individual log files.

## Core CLI Usage
The most common way to run MultiQC is to point it at a directory containing your analysis results:

```bash
# Run in the current directory
multiqc .

# Run on a specific analysis folder with a custom report name
multiqc /path/to/data/ --filename project_abc_report.html

# Aggregate results from multiple specific directories
multiqc data/dir1/ data/dir2/ results/fastqc/
```

## Expert Tips and Best Practices

### 1. Handling Large Datasets
If you are working with thousands of samples, the HTML report can become sluggish. Use these flags to optimize:
- `--flat`: Use flat plots (non-interactive) to reduce file size and browser memory usage.
- `--export`: Ensure data tables are exported to `multiqc_data/` for programmatic access even if the HTML is too large to view comfortably.

### 2. Sample Name Cleaning
MultiQC often picks up file extensions or directory prefixes in sample names. Clean them using:
- `--ignore`: Skip specific files or directories (e.g., `--ignore "tmp/*"`).
- Use a configuration file (see below) to define `sample_names_rename_buttons` or `extra_fn_clean_exts` to strip unwanted strings like `.sorted.bam`.

### 3. Custom Content
You can include your own data (e.g., metadata or custom metrics) by providing a simple TSV/CSV file:
- Ensure the file has a header.
- MultiQC will automatically detect and plot it if it follows the "Custom Content" formatting (typically a `.txt` or `.tsv` file with a specific header string).

### 4. Organizing Output
By default, MultiQC creates a folder called `multiqc_data`. You can change this behavior:
- `-o /path/to/output/`: Specify where the report and data folder should be saved.
- `-f`: Force overwrite of existing reports in the output directory.
- `-z`: Compress the `multiqc_data` output into a zip file.

### 5. Search Patterns
If MultiQC is missing files you expect it to find:
- Use `-v` (verbose) to see which files are being inspected and why they might be skipped.
- Ensure your upstream tools are producing the standard log/stdout files that MultiQC recognizes (e.g., `.fastqc.zip` for FastQC or `Log.final.out` for STAR).

## Reference documentation
- [MultiQC Overview](./references/seqera_io_multiqc.md)