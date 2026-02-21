---
name: counterr
description: The `counterr` tool is a lightweight command-line utility designed for bioinformatics workflows that require detailed error profiling of sequencing data.
homepage: https://github.com/dayzerodx/counterr
---

# counterr

## Overview
The `counterr` tool is a lightweight command-line utility designed for bioinformatics workflows that require detailed error profiling of sequencing data. It maps reads against a reference to calculate both context-independent and context-dependent error rates. This is essential for uncovering systematic biases in specific sequencing technologies (like homopolymer errors in Nanopore) or validating the accuracy of a specific run. The tool produces a comprehensive PDF report containing density histograms, scatter plots of Phred scores, and error distribution tables.

## Core CLI Usage

### Basic Execution
To run a standard analysis, provide the alignment file, the reference genome, and a target directory for the results:
```bash
counterr -bam input.bam -genome reference.fasta -output_dir results_folder -verbose
```

### Testing and Sampling
For large datasets, use the `-lim` flag to process a random subset of reads. This is highly recommended for verifying parameters before committing to a full run:
```bash
# Process only 100 randomly selected reads
counterr -bam input.bam -genome reference.fasta -output_dir test_results -lim 100
```

### Working with CRAM Files
If your alignments are in CRAM format, use the `-cram` flag. Ensure your reference genome matches the one used to generate the CRAM:
```bash
counterr -bam input.cram -genome reference.fasta -output_dir results -cram
```

## Expert Tips and Best Practices

### Filtering for High-Quality Statistics
By default, `counterr` uses specific thresholds for read length and mapping quality. Adjust these to match your library prep (e.g., lower thresholds for short-read Illumina vs. higher for long-read Nanopore):
*   **Map Quality**: Use `-mapq_thres` (default 40) to exclude multi-mapped or low-confidence reads.
*   **Alignment Length**: Use `-len_min_aln` (default 1000) to ensure the error rate is calculated over a significant portion of the read.
*   **Read Length**: Use `-len_min_read` (default 1500) to filter out short fragments.

### Technology-Specific Optimization
*   **Illumina Data**: Always include the `-illumina` flag when processing short-read data to adjust plot scales and visualization parameters for better readability.
*   **Homopolymer Analysis**: Adjust `-len_min_hp` and `-len_max_hp` to focus on specific homopolymer lengths known to be problematic in your sequencing chemistry.

### Output Management
*   **Report Naming**: Use `-report_name custom_report.pdf` to prevent overwriting existing reports in the same directory.
*   **Image Formats**: If you need to embed figures into web dashboards or presentations, use `-only_png` to save individual plots as PNG files instead of just the bundled PDF.
*   **Headless Environments**: If running on a server without a display, use `-no_figures` to generate only the raw statistics (found in the `stats/` subdirectory) without attempting to render plots.

## Reference documentation
- [GitHub Repository and README](./references/github_com_dayzerodx_counterr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_counterr_overview.md)