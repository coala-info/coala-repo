---
name: combined-pvalues
description: This tool identifies statistically significant genomic regions by accounting for spatial autocorrelation among p-values. Use when user asks to calculate autocorrelation, apply Stouffer-Liptak correction, identify differentially methylated regions, or perform FDR correction on spatially correlated genomic data.
homepage: https://github.com/brentp/combined-pvalues
---


# combined-pvalues

## Overview
The `combined-pvalues` library (invoked via the `comb-p` command) provides a specialized workflow for handling p-values that are not independent but spatially correlated. In genomic assays, a signal at one probe is often correlated with its neighbors; standard FDR corrections fail to account for this, leading to inaccurate results. This tool calculates the autocorrelation within a dataset and uses it to perform a modified Stouffer-Liptak correction, effectively grouping individual probe p-values into statistically robust regions or peaks.

## Installation
The tool is most easily installed via Bioconda:
```bash
conda install -c bioconda combined-pvalues
```

## Core CLI Usage

### The Automated Pipeline
For most users, the `pipeline` command is the most efficient way to identify regions (DMRs) from a sorted BED file containing p-values.

```bash
comb-p pipeline \
    -c 4 \
    --seed 1e-3 \
    --dist 200 \
    -p $OUT_PREFIX \
    --anno mm9 \
    input_pvals.bed
```
- `-c`: The 1-based column index containing the p-values.
- `--seed`: The p-value threshold required to initiate a region.
- `--dist`: The maximum distance (in bp) to extend a region if another significant p-value is found.
- `--anno`: (Optional) Genome build for annotation (e.g., hg19, mm9).

### Modular Workflow
If you need finer control, you can run the steps individually:

1. **Calculate Autocorrelation (ACF):**
   ```bash
   comb-p acf -d 1:500:50 -c 4 input.bed > acf.txt
   ```
   The `-d` flag specifies `start:stop:step` for distance lags.

2. **Apply Stouffer-Liptak-Kechris (SLK) Correction:**
   ```bash
   comb-p slk --acf acf.txt -c 4 input.bed > adjusted.bed
   ```

3. **Perform FDR Correction:**
   ```bash
   comb-p fdr -c 5 adjusted.bed > fdr.bed
   ```

4. **Identify Peaks/Regions:**
   ```bash
   comb-p peaks --dist 500 --seed 0.1 fdr.bed > regions.bed
   ```

## Expert Tips and Best Practices

### Input Requirements
- **Sorting is Mandatory:** All input BED files must be sorted by chromosome and start position. Use `sort -k1,1 -k2,2n` if unsure.
- **Column Indexing:** The tool uses 1-based indexing for columns. If your p-value is in the standard 4th column of a BED file, use `-c 4`.

### Parameter Tuning
- **Distance (`--dist`):** This should reflect the expected size of the biological feature you are looking for. For DNA methylation, 200-500bp is common; for ChIP-Seq, this may be larger depending on the protein.
- **Seed P-value:** A more stringent seed (e.g., `1e-4`) will result in fewer, more robust regions, while a relaxed seed (e.g., `0.05`) will merge more probes into larger, potentially noisier regions.

### Visualization
If `matplotlib` is installed in your environment, the `pipeline` and `manhattan` commands will automatically generate plots.
- **Manhattan Plots:** Use `comb-p manhattan input.bed` to visualize the distribution of p-values across the genome, with significant regions highlighted.

### Handling "Inverted" Data
If you are looking for high values (peaks) rather than low values (troughs/p-values), use the `--invert` flag in the `peaks` command.

## Reference documentation
- [Bioconda combined-pvalues Overview](./references/anaconda_org_channels_bioconda_packages_combined-pvalues_overview.md)
- [GitHub Repository README](./references/github_com_brentp_combined-pvalues.md)