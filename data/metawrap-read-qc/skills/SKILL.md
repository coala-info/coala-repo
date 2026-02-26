---
name: metawrap-read-qc
description: This tool performs quality control, adapter trimming, and host DNA removal on raw metagenomic sequencing reads. Use when user asks to clean raw reads, remove host contamination, or prepare sequencing data for metagenomic assembly.
homepage: https://github.com/bxlab/metaWRAP
---


# metawrap-read-qc

## Overview
The `metawrap-read-qc` skill manages the first critical step in the MetaWRAP pipeline. It acts as a wrapper for tools like Trim Galore (which utilizes FastQC and Cutadapt) and BMTagger to transform raw sequencing data into "clean" reads. By removing technical artifacts and host-derived DNA, it ensures that downstream processes—such as metagenomic assembly, taxonomic profiling, and binning—are performed on high-quality microbial data, significantly improving the reliability of the final genomic reconstructions.

## Command Line Usage

The primary command for this module is `metawrap read_qc`. It requires paired-end or single-end FASTQ files and a host reference index for contamination removal.

### Basic Paired-End Pattern
```bash
metawrap read_qc -1 raw_reads_1.fastq -2 raw_reads_2.fastq -t 16 -o output_dir -x host_index
```

### Key Arguments
- `-1`: Forward paired-end reads (FASTQ format).
- `-2`: Reverse paired-end reads (FASTQ format).
- `-o`: Output directory for cleaned reads and QC reports.
- `-t`: Number of threads to use (default is 1).
- `-x`: Path to the host genome index (e.g., human) for BMTagger.

## Best Practices and Expert Tips

### Host Contamination Removal
- **Index Preparation**: Ensure your host index is properly formatted for BMTagger. If you are working with human data, use the standard hg38 or GRCh38 indices.
- **Skipping Host Removal**: If your sample has no host (e.g., environmental water samples), you can omit the `-x` flag to perform only trimming and quality filtering.

### Resource Management
- **Memory Requirements**: While `read_qc` is less memory-intensive than assembly, BMTagger still requires significant RAM depending on the size of the host genome. For human host removal, ensure at least 32GB of RAM is available.
- **Parallelization**: Use the `-t` flag to match the available CPU cores on your system to significantly speed up the trimming and alignment phases.

### Configuration
- **Database Paths**: MetaWRAP relies on a configuration file to find its dependencies and databases. If the tool fails to find BMTagger or the host index, verify the paths in your `config-metawrap` file (usually located in the `bin` directory of the MetaWRAP installation).

### Output Interpretation
- **Cleaned Reads**: The final cleaned reads will be located in the output directory, typically named `final_pure_reads_1.fastq` and `final_pure_reads_2.fastq`.
- **QC Reports**: Review the FastQC reports generated within the output folder to ensure that adapter content has been successfully removed and base quality scores are acceptable.

## Reference documentation
- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [Bioconda metawrap-read-qc Overview](./references/anaconda_org_channels_bioconda_packages_metawrap-read-qc_overview.md)