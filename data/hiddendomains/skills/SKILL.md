---
name: hiddendomains
description: "hiddendomains uses a Hidden Markov Model to detect broad epigenetic domains from ChIP-seq data. Use when user asks to identify large-scale genomic domains, bin reads from BAM files, or convert domain calling results into BED format for visualization and analysis."
homepage: http://hiddendomains.sourceforge.net/
---


# hiddendomains

## Overview
The `hiddendomains` suite is designed for detecting broad epigenetic domains rather than narrow transcription factor peaks. It utilizes a Hidden Markov Model approach to analyze read distributions across genomic bins. This skill provides the necessary workflows to run the integrated pipeline or execute individual components for custom binning, domain calling, and BED file generation.

## Core Workflow
The primary entry point is the `hiddenDomains` wrapper script, which automates binning and HMM analysis.

### Integrated Analysis
Run the full pipeline with a treatment and control (input) BAM file:
```bash
hiddenDomains -g ChromInfo.txt -b 200 -t treatment.bam -c control.bam -o output_prefix
```
- `-g`: Tab-delimited file with chromosome names and sizes.
- `-b`: Bin width (default 1000bp; use smaller values like 200 for higher resolution).
- `-t`: Treatment ChIP-seq BAM file.
- `-c`: Control/Input BAM file (highly recommended to reduce false positives).
- `-o`: Prefix for output files (`_domains.txt`, `_vis.bed`, `_analysis.bed`).

## Modular Components
For granular control, run the underlying Perl and R scripts individually.

### 1. Binning Reads
Use `binReads.pl` to convert BAM files into binned read counts.
```bash
binReads.pl -b 1000 -q 30 treatment.bam > treatment_bins.txt
```
- `-q`: Minimum mapping quality (default 30).
- `-B`: Use if input is in BED format instead of BAM.
- `-c`: Specify a custom list of chromosomes (e.g., `"chr1 chr2"`).

### 2. Generating BED Files
After running the HMM analysis (which produces a `domainFile.txt`), convert the results to BED format for visualization or downstream analysis.

**For Visualization (Individual Bins):**
```bash
domainsToBed.pl -b 1000 domainFile.txt > visualization.bed
```

**For Analysis (Merged Domains):**
```bash
domainsMergeToBed.pl -b 1000 -p 0.9 domainFile.txt > merged_domains.bed
```
- `-p`: Minimum posterior probability threshold (e.g., 0.9 for high confidence).
- `-t`: Adds a track line for the UCSC Genome Browser.

## Expert Tips
- **ChromInfo Files**: Ensure the chromosome names in your `ChromInfo.txt` exactly match the headers in your BAM files (e.g., "chr1" vs "1").
- **Control Samples**: Always use a control/input file when possible. Without it, the tool may flag regions of high mappability or copy number variation as false positive domains.
- **Dependencies**: This tool requires `samtools` to be in your PATH and the R packages `depmixS4` and `HiddenMarkov` to be installed.
- **Permissions**: If the wrapper fails to execute, ensure it is executable: `chmod +755 hiddenDomains`.

## Reference documentation
- [hiddenDomains Manual and Tutorial](./references/hiddendomains_sourceforge_net_index.md)
- [bioconda hiddendomains overview](./references/anaconda_org_channels_bioconda_packages_hiddendomains_overview.md)