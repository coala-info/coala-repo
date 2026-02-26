---
name: methplotlib
description: "methplotlib creates interactive or static visualizations of DNA methylation data across specific genomic regions. Use when user asks to plot methylation calls, compare modification patterns across multiple samples, visualize phased methylation, or align methylation data with gene models."
homepage: https://github.com/wdecoster/methplotlib
---


# methplotlib

## Overview
methplotlib is a command-line utility designed to create interactive or static visualizations of DNA methylation data. It transforms raw methylation calls or frequency data into a browser-like view, allowing researchers to see modification patterns across specific genomic regions. It is highly effective for comparing multiple samples, visualizing phased (haplotype-specific) methylation, and aligning modification data with gene models from GTF or BED files.

## Installation
Install via bioconda or pip:
```bash
conda install bioconda::methplotlib
# OR
pip install methplotlib
```

## Common CLI Patterns

### Basic Visualization
To plot a specific genomic region from a nanopolish methylation file:
```bash
methplotlib -m methylation_calls.tsv -n SampleName -w chr1:10,000-20,000
```

### Comparing Multiple Samples
You can overlay multiple datasets by providing a list of files and corresponding names:
```bash
methplotlib -m sample1.tsv sample2.tsv -n Control Treatment -w chrX:5,000,000-5,010,000
```

### Adding Annotations
To include gene structures or specific regions of interest:
- Use `-g` for GTF files (gene models).
- Use `-b` for BED files (custom regions).
- Use `--simplify` to show gene-level tracks instead of individual transcripts.

```bash
methplotlib -m data.tsv -n MySample -w chr1:100-500 -g annotation.gtf --simplify
```

### Working with CRAM/BAM
For modern ONT data containing MM/ML tags:
```bash
methplotlib -m aligned_reads.cram -n ONT_Data -w chr2:150,000-160,000
```

### Output Customization
- **Static Images**: Use `--static filename.png` to generate a non-interactive image instead of the default HTML.
- **Smoothing**: Use `--smooth [int]` (e.g., `--smooth 50`) to apply a rolling window average to frequency data, which is helpful for noisy datasets.
- **Splitting Tracks**: Use `--split` to show datasets in separate vertical panels rather than overlaying them in one plot.

## Expert Tips
- **Window Shorthand**: When naming output files with `-o`, you can use the `{region}` placeholder to automatically include the coordinates in the filename: `-o methylation_{region}.html`.
- **Large Windows**: If your `--window` covers an entire chromosome or contig, you must provide the reference FASTA file using `-f`.
- **Phasing**: methplotlib supports phased data. Use the companion scripts in the `scripts/` directory of the source repository (like `annotate_calls_by_phase.py`) to prepare data for haplotype-specific visualization.
- **Binary Mode**: For nanopolish data, use `--binary` to ignore log-likelihood nuances and treat calls as strictly methylated or unmethylated.

## Reference documentation
- [methplotlib GitHub Repository](./references/github_com_wdecoster_methplotlib.md)
- [Bioconda methplotlib Overview](./references/anaconda_org_channels_bioconda_packages_methplotlib_overview.md)