---
name: strandphaser
description: StrandPhaseR is an R package designed to reconstruct whole-chromosome haplotypes from single-cell Strand-seq data. Use when user asks to phase single-cell genomic data, reconstruct haplotypes using strand-inheritance patterns, or map genomic features to specific parental homologs.
homepage: https://github.com/daewoooo/StrandPhaseR/
metadata:
  docker_image: "quay.io/biocontainers/strandphaser:1.0.2--r42hdfd78af_0"
---

# strandphaser

## Overview
StrandPhaseR is an R package specifically designed for the phasing of single-cell Strand-seq data. It utilizes the unique strand-inheritance patterns of Strand-seq to reconstruct whole-chromosome haplotypes. This tool is essential for researchers working with single-cell genomics who need to distinguish between parental homologs and map genomic features to specific haplotypes without requiring parental genotype information.

## Installation and Setup
The most reliable way to install StrandPhaseR is via Bioconda or directly from GitHub using `devtools`.

**Conda installation:**
```bash
conda install bioconda::strandphaser
```

**R-based installation (Development version):**
```R
if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install(c("GenomicRanges", "GenomicAlignments"))
install.packages("devtools")
devtools::install_github("daewoooo/StrandPhaseR")
```

## Core Usage Patterns

### Basic Execution
The primary function is `strandPhaseR()`. You must provide the directory containing your BAM files and the locations of known SNVs.

```R
library(StrandPhaseR)

strandPhaseR(
    inputfolder = "path/to/bam_files",
    outputfolder = "path/to/output",
    positions = "path/to/SNV_positions.vcf",
    WCregions = "path/to/WC_regions.bed"
)
```

### Parameter Breakdown
- `inputfolder`: Directory containing single-cell BAM files.
- `outputfolder`: Directory where results and phased haplotypes will be stored.
- `positions`: A VCF file or data frame containing the SNV positions to be phased.
- `WCregions`: A BED file or GRanges object defining haplotype-informative Watson-Crick regions.
- `chromosomes`: (Optional) A vector of chromosome names to process (e.g., `c('chr1', 'chr2')`).
- `configfile`: (Optional) Path to a configuration file to load parameters.

### Using a Configuration File
For complex projects or reproducible pipelines, it is recommended to use a configuration file.

```R
strandPhaseR(
    inputfolder = "input_data/",
    outputfolder = "phased_results/",
    configfile = "my_parameters.conf"
)
```

## Best Practices and Expert Tips
- **Input Quality**: Ensure your BAM files are properly indexed. The quality of phasing is highly dependent on the accuracy of the input SNV positions.
- **WC Regions**: The `WCregions` input is critical. These are regions where the cell has inherited one Watson and one Crick strand; only these regions provide the necessary information for phasing.
- **Memory Management**: Phasing entire genomes can be memory-intensive. If running on a local machine, process chromosomes individually using the `chromosomes` parameter to reduce the memory footprint.
- **Inversion Correction**: The developmental branch of StrandPhaseR includes specific functionality for phasing inverted regions. If your data contains known inversions, ensure you are using the latest version from GitHub.
- **Output Inspection**: Check the `phased` sub-directory in your output folder for the final haplotype strings and consensus files.

## Reference documentation
- [StrandPhaseR GitHub Repository](./references/github_com_daewoooo_StrandPhaseR.md)
- [Bioconda StrandPhaseR Overview](./references/anaconda_org_channels_bioconda_packages_strandphaser_overview.md)