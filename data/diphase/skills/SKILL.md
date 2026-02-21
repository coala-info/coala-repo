---
name: diphase
description: Diphase is a bioinformatics pipeline designed to resolve diploid genome assemblies into distinct haplotypes.
homepage: https://github.com/zhangjuncsu/Diphase
---

# diphase

## Overview

Diphase is a bioinformatics pipeline designed to resolve diploid genome assemblies into distinct haplotypes. It functions by integrating heterozygous variations identified from long-read sequencing (ONT or PacBio) with the spatial proximity information provided by Hi-C data. The tool is specifically optimized for assemblies provided in a primary/alternate contig format. By leveraging Clair3 for variant calling and a custom phasing algorithm, Diphase produces two separate haplotype-resolved FASTA files, enabling more accurate downstream genomic analysis in polyploid or highly heterozygous organisms.

## CLI Usage and Best Practices

The primary interface for Diphase is the `pipeline.py` script using the `phase` command.

### Core Command Pattern
```bash
pipeline.py phase \
    --pri primary.fasta \
    --alt alternate.fasta \
    --rdfname long_reads.fastq.gz \
    --hic1 hic_R1.fastq.gz \
    --hic2 hic_R2.fastq.gz \
    --model /path/to/clair3/models/ont \
    --type ont \
    -d output_dir \
    -t 16
```

### Key Parameters
*   **Assembly Inputs**: Both `--pri` (primary) and `--alt` (alternate) files are required. Diphase currently does not support dual assembly formats directly.
*   **Sequencing Type**: Use `--type` to specify the long-read technology: `ont` (Oxford Nanopore), `clr` (PacBio CLR), or `hifi` (PacBio HiFi).
*   **Clair3 Model**: The `--model` flag must point to the specific Clair3 model directory corresponding to your sequencing platform and basecaller version.
*   **Resource Management**: Use `-t` to specify the maximum number of threads. Phasing and alignment steps are computationally intensive.

### Expert Tips and Workflow Optimization
*   **Dependency Pathing**: Ensure `run_clair3.sh` is available in your system `$PATH`. Diphase relies on this script for the variant calling stage.
*   **Hi-C Quality Control**: Use the `--dump_filtered` flag to save the filtered Hi-C mapping results (`phasing.hic.filtered.bam`). This is essential for troubleshooting low phasing connectivity.
*   **Output Interpretation**:
    *   `phasing.hap1.fasta` and `phasing.hap2.fasta`: The final phased assemblies.
    *   `phasing.result.txt`: Detailed phasing statistics and assignments.
    *   `phasing.fixed.switch`: Contains detected switch errors that were corrected during the process.
*   **Memory Management**: For large genomes, ensure the environment has sufficient RAM for `minimap2` and `bwa-mem` operations, which are invoked by the pipeline.
*   **Input Compression**: Diphase natively supports `.gz` compressed fastq files, which should be used to save disk space and I/O overhead.

## Reference documentation
- [Diphase GitHub Repository](./references/github_com_zhangjuncsu_Diphase.md)
- [Diphase Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_diphase_overview.md)