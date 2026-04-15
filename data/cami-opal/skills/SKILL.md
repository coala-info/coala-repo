---
name: cami-opal
description: cami-opal is a benchmarking utility that evaluates and compares the performance of taxonomic profilers in metagenomics against a gold standard. Use when user asks to assess taxonomic profiling accuracy, compare multiple metagenomic profilers, or generate performance metrics and spider plots for microbial community reconstruction.
homepage: https://github.com/CAMI-challenge/OPAL
metadata:
  docker_image: "quay.io/biocontainers/cami-opal:1.0.13--pyhdfd78af_0"
---

# cami-opal

## Overview
OPAL (Open-community Profiling Assessment tooL) is a benchmarking utility designed to standardize the evaluation of taxonomic profilers in metagenomics. It allows researchers to compare multiple profiling methods simultaneously by measuring how closely their predictions match a known gold standard. The tool produces both statistical metrics and visual reports (like spider plots and abundance plots) to identify strengths and weaknesses in microbial community reconstruction.

## Core CLI Usage

The primary interface for the tool is `opal.py`. It requires at least one gold standard file and one or more profile files to assess.

### Basic Command Pattern
```bash
opal.py -g gold_standard.bin profile_1.txt profile_2.txt -o output_directory
```

### Common Arguments
- `-g, --gold_standard_file`: Path to the reference taxonomic profile.
- `-o, --output_dir`: Directory where HTML reports and processed data will be saved.
- `-l, --labels`: Comma-separated names for the profilers (e.g., `-l "MetaPhlAn,mOTUs2"`).
- `-r, --ranks`: Specify the taxonomic ranks to consider (default is `superkingdom,species`). Valid options: `superkingdom, phylum, class, order, family, genus, species, strain`.
- `-f, --filter`: Filter out predictions with the smallest relative abundances summing up to [FILTER]% within a rank.

## Expert Tips and Best Practices

### Data Normalization
If your input profiles are not already normalized to sum to 1 (or 100%), use the `-n` or `--normalize` flag. OPAL performs better and provides more consistent L1 norm and UniFrac results when samples are on the same scale.

### Performance Visualizations
OPAL generates "spider plots" to show relative and absolute performance across multiple metrics.
- **Relative Performance**: Use `--metrics_plot_rel` to choose metrics for the relative spider plot. Options include `w` (weighted UniFrac), `l` (L1 norm), `c` (completeness/recall), `p` (purity/precision), `f` (false positives), and `t` (true positives).
- **Absolute Performance**: Use `--metrics_plot_abs` for absolute performance. Options include `c` (completeness), `p` (purity), and `b` (Bray-Curtis).

### Handling Low Abundance Noise
Metagenomic profilers often produce long tails of very low-abundance false positives. Use the `-f` (filter) argument to remove these before calculation. For example, `-f 1` will filter out the lowest abundance predictions that sum to 1% of the total, which often clarifies the performance on the primary community members.

### Input Formats
OPAL supports the CAMI profiling Bioboxes format and BIOM format. If you have profiles in a standard TSV format that needs conversion to BIOM for specific downstream compatibility, use the included utility:
```bash
tsv2biom.py -i input_profile.tsv -o output_profile.biom
```

### Resource Tracking
If you have recorded the runtime and memory usage of the profilers you are testing, you can include this data in the OPAL report using:
- `-t, --time`: Comma-separated runtimes in hours.
- `-m, --memory`: Comma-separated memory usage in gigabytes.

## Reference documentation
- [OPAL GitHub Repository](./references/github_com_CAMI-challenge_OPAL.md)
- [OPAL Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cami-opal_overview.md)