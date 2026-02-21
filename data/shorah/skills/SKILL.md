---
name: shorah
description: ShoRAH (Short Reads Assembly into Haplotypes) is a specialized bioinformatics suite designed to characterize the genetic diversity within a sample, such as a viral population.
homepage: https://github.com/cbg-ethz/shorah
---

# shorah

## Overview

ShoRAH (Short Reads Assembly into Haplotypes) is a specialized bioinformatics suite designed to characterize the genetic diversity within a sample, such as a viral population. By processing next-generation sequencing (NGS) data, it identifies individual haplotypes and estimates their relative frequencies. The tool utilizes a window-based approach to perform local haplotype reconstruction, error correction via Dirichlet process mixture models, and strand-bias-aware SNV calling.

## Installation

The recommended method for installing ShoRAH is via Bioconda to ensure all C++ and Python dependencies (HTSlib, Boost, Biopython, and NumPy) are correctly configured.

```bash
conda install bioconda::shorah
```

## Core CLI Usage

ShoRAH is primarily used through its wrapper scripts for different sequencing strategies. The primary input required is a **sorted BAM file** and a corresponding **reference FASTA file**.

### Shotgun Sequencing Analysis
Use this for randomly fragmented genomic data.
```bash
shorah shotgun -b input_sorted.bam -f reference.fasta
```

### Amplicon Sequencing Analysis
Use this for targeted sequencing data.
```bash
shorah amplicon -b input_sorted.bam -f reference.fasta
```

### Manual Component Execution
While the wrappers are preferred, individual components can be invoked for specific tasks:
- **snv**: Detects single nucleotide variants with strand bias testing.
- **b2w**: Splits a shotgun BAM file into multiple overlapping windows for localized analysis.
- **diri_sampler**: Performs Gibbs sampling for error correction.

## Best Practices and Expert Tips

### Input Preparation
- **Sorting and Indexing**: Always ensure your BAM file is coordinate-sorted and indexed (`samtools index`) before running ShoRAH.
- **Reference Matching**: The reference FASTA used for ShoRAH must be the same one used during the initial read mapping/alignment.

### Version Considerations
- **Local vs. Global Reconstruction**: ShoRAH 2.x (v1.99+) currently has global haplotype reconstruction disabled. It focuses on high-accuracy local reconstruction. If your workflow requires global reconstruction, use version 1.1.3 or integrate ShoRAH into the V-pipe pipeline.
- **Output Formats**: Modern versions of ShoRAH (1.99.0+) support VCF output for SNV calling, making it compatible with standard downstream variant analysis tools.

### Performance and Reproducibility
- **Parallelization**: When compiling from source, use `make -j<threads>` to speed up the process. For execution, ShoRAH handles window-based processing which can be resource-intensive; ensure sufficient memory is available for the `diri_sampler` component.
- **Random Seeds**: Use the `-S` flag to set a random seed if you need to attempt to reproduce Gibbs sampling results, though be aware that some stochasticity is inherent to the Dirichlet process mixture model.

### Troubleshooting
- **Empty Regions**: If the tool encounters regions with no read coverage, it may skip them or produce warnings. Ensure your BAM file has sufficient coverage for the regions of interest.
- **Strand Bias**: If you observe high false-positive rates in SNV calling, check the `fil` (strand bias test) output to see if the variants are heavily biased toward one sequencing direction.

## Reference documentation
- [ShoRAH Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shorah_overview.md)
- [ShoRAH GitHub Repository](./references/github_com_cbg-ethz_shorah.md)