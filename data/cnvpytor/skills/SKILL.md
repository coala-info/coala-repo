---
name: cnvpytor
description: CNVpytor is a Python-based tool designed for CNV/CNA analysis using read-depth (RD) and allele imbalance signals.
homepage: https://github.com/abyzovlab/CNVpytor
---

# cnvpytor

## Overview

CNVpytor is a Python-based tool designed for CNV/CNA analysis using read-depth (RD) and allele imbalance signals. It serves as an extension of the original CNVnator, providing improved performance, SNP integration, and interactive visualization. Use this skill to guide users through the multi-step process of initializing a pytor file, generating histograms, partitioning data, and calling variations across different genomic bin sizes.

## Core Workflow

The standard cnvpytor analysis follows a sequential pipeline. All data is stored in a central `.pytor` HDF5 file.

### 1. Data Initialization and Read Depth
First, import the read depth data from a BAM or CRAM file into the pytor container.
```bash
cnvpytor -root sample.pytor -rd sample.bam
```

### 2. Histogram Generation
Generate histograms for specific bin sizes (e.g., 1kb, 10kb, 100kb). Choosing multiple bin sizes allows for detection of both small and large CNVs.
```bash
cnvpytor -root sample.pytor -his 1000 10000 100000
```

### 3. Partitioning and Calling
Perform mean-shift partitioning (segmentation) and then call the CNVs based on the processed RD signal.
```bash
# Partitioning
cnvpytor -root sample.pytor -partition 1000 10000 100000

# Calling
cnvpytor -root sample.pytor -call 1000 10000 100000
```

## SNP and BAF Analysis

Integrating SNP data improves the accuracy of calls and allows for the detection of copy-neutral loss of heterozygosity (cnLOH).

1. **Import SNPs**:
   ```bash
   cnvpytor -root sample.pytor -snp sample.vcf -sample sample_name
   ```
2. **Calculate BAF**:
   ```bash
   cnvpytor -root sample.pytor -baf 10000 100000
   ```

## Filtering and Exporting Results

Use the `-view` command to filter calls and export them to various formats (XLS, VCF, TSV).

```bash
# Enter view mode for a specific bin size
cnvpytor -root sample.pytor -view 100000
```

Inside the interactive view mode (or via piped commands):
* **Filter by quality**: `set Q0_range 0 0.5` (removes calls with high zero-mapping quality reads)
* **Filter by size**: `set size_range 100000 inf`
* **Annotate**: `set annotate` (requires internet connection for gene info)
* **Export**: 
  ```bash
  set print_filename output.vcf
  print calls
  ```

## Expert Tips and Best Practices

* **Storage Optimization**: Use the `-nolh` flag during the `-snp` or `-baf` steps to avoid storing the full BAF likelihood matrix. This reduces file size significantly (often < 50MB) while calculating likelihoods on-the-fly during calling.
* **Masking**: For human data, use `-rd_use_mask` to apply strict masks (e.g., 1000 Genomes Project) to filter out problematic genomic regions.
* **Genotyping**: To check the copy number of specific known regions across samples:
  ```bash
  cnvpytor -root sample.pytor -genotype 10000 100000 chr12:11396601-11436500
  ```
* **Visualization**: CNVpytor supports several plot types in view mode:
  * `manhattan`: Genome-wide RD view.
  * `rd`: Regional read depth.
  * `snp`: BAF and likelihood plots.
  * `circular`: Circular genome view.

## Reference documentation
- [CNVpytor GitHub Repository](./references/github_com_abyzovlab_CNVpytor.md)
- [CNVpytor Wiki](./references/github_com_abyzovlab_CNVpytor_wiki.md)