---
name: encode-blacklist
description: The ENCODE Blacklist tool identifies and removes genomic regions that exhibit consistent high-signal artifacts to prevent false positives in downstream analyses. Use when user asks to filter problematic genomic regions, apply pre-computed blacklists for standard assemblies, or generate custom blacklists from raw sequencing data.
homepage: https://github.com/Boyle-Lab/Blacklist
---


# encode-blacklist

## Overview
The ENCODE Blacklist tool is used to identify and remove genomic regions that consistently show high signal artifacts regardless of the cell line or experiment type. Removing these regions is a critical quality control step to prevent false positives in peak calling and other downstream analyses. This skill covers the application of existing blacklists for standard assemblies (like hg38 and mm10) and the procedure for generating new blacklists from raw sequencing data.

## Installation and Setup

### Bioconda (Recommended)
The easiest way to install the tool is via Conda:
```bash
conda install bioconda::encode-blacklist
```

### Building from Source
If building from the GitHub repository, ensure `bamtools` and `zlib` are installed.
1. Clone the repository with submodules: `git clone --recurse-submodules https://github.com/Boyle-Lab/Blacklist.git`
2. Build the `bamtools` API within the directory.
3. Run `make` in the root directory to create the `Blacklist` executable.

## Usage Patterns

### Using Pre-computed Blacklists
For most users, the pre-computed BED files are sufficient. These are located in the `lists/` directory of the repository for the following assemblies:
- **Human**: hg19, hg38
- **Mouse**: mm9, mm10
- **Worm**: ce10, ce11
- **Fly**: dm3, dm6

### Generating a Custom Blacklist
To generate a new blacklist, the software requires a specific directory structure relative to the executable:

1. **Directory Structure**:
   - `Blacklist` (executable)
   - `input/` - Must contain all sorted and indexed BAM files (`.bam` and `.bam.bai`).
   - `mappability/` - Must contain `uint8` Umap files.

2. **Execution**:
   The tool runs on a per-chromosome or per-contig basis.
   ```bash
   ./Blacklist <contig_name> > <output_file>.bed
   ```
   *Example for Chromosome 1:*
   ```bash
   ./Blacklist chr1 > chr1.blacklist.bed
   ```

## Hardware Requirements and Performance
Generating a blacklist is resource-intensive. For standard mammalian genomes:
- **RAM**: 64GB+ recommended.
- **CPU**: 24+ cores recommended.
- **Runtime**: Approximately 192 CPU hours for a full genome.

## Best Practices
- **Input Data**: Ensure all BAM files in the `input/` folder are from the same assembly and are properly indexed.
- **Mappability**: The `mappability/` folder must contain Umap files corresponding to the read length of your data for accurate identification.
- **Downstream Filtering**: Once the `.bed` file is obtained, use `bedtools intersect -v` to filter your experimental data against the blacklist.

## Reference documentation
- [ENCODE Blacklist Overview](./references/anaconda_org_channels_bioconda_packages_encode-blacklist_overview.md)
- [Boyle-Lab Blacklist GitHub Repository](./references/github_com_Boyle-Lab_Blacklist.md)