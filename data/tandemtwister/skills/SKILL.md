---
name: tandemtwister
description: TandemTwister is a specialized bioinformatics tool designed to detect and genotype interleaved and embedded tandem repeats (TRs) using long-read sequencing data.
homepage: https://github.com/Lionward/tandemtwister
---

# tandemtwister

## Overview
TandemTwister is a specialized bioinformatics tool designed to detect and genotype interleaved and embedded tandem repeats (TRs) using long-read sequencing data. It supports various technologies including PacBio (CLR and CCS) and Oxford Nanopore (ONT). The tool is particularly effective for resolving complex genomic regions by leveraging phasing algorithms and noise correction mechanisms tailored for short motifs (≤3bp). Use this skill to guide the execution of germline, somatic, or assembly-based tandem repeat analysis workflows.

## Command Line Usage

The tool uses a command-first interface:
`tandemtwister [global options] <command> [command options]`

### Core Commands
- `germline`: Standard workflow for genotyping germline tandem repeats.
- `somatic`: Profiles somatic expansions (Note: currently experimental).
- `assembly`: Genotypes repeats from aligned genome assemblies.

### Required Arguments
When running any command, the following flags are typically required:
- `-b, --bam`: Path to the aligned BAM file.
- `-r, --ref`: Path to the reference genome (.fa/.fna).
- `-m, --motif_file`: BED/TSV/CSV file containing reference coordinates and motif sequences.
- `-o, --output_file`: Destination for the genotype results (hap1/hap2 copy numbers).
- `-sn, --sample`: Name of the sample.
- `-rt, --reads_type`: Type of reads (`CCS`, `CLR`, or `ONT`). Default is `CCS`.

### Common CLI Patterns

**Standard Germline Genotyping (CCS):**
```bash
tandemtwister germline -b sample.bam -r ref.fa -m repeats.bed -o results.txt -sn Sample01 -rt CCS -t 16
```

**High-Noise Long Reads (ONT/CLR) with Correction:**
For ONT or CLR data, ensure correction is enabled (it is default for these types) to handle higher error rates in short motifs.
```bash
tandemtwister germline -b ont_sample.bam -r ref.fa -m repeats.bed -o results.txt -sn Sample01 -rt ONT -cor true -t 32
```

**Assembly-based Genotyping:**
```bash
tandemtwister assembly -b assembly_aligned.bam -r ref.fa -m repeats.bed -o assembly_genotypes.txt -bt reads
```

## Expert Tips and Best Practices

### Performance Optimization
- **Multi-threading**: TandemTwister scales well. Use the `-t` flag to specify threads. It can process over 1 million regions in approximately 20 minutes using 32 threads.
- **Memory Efficiency**: The tool uses multi-threading for parallel execution to maintain a lower memory footprint compared to multi-processing.

### Accuracy and Refinement
- **Coordinate Refinement**: Use the `-rtr` (refineTrRegions) flag to allow the tool to adjust the input BED coordinates based on the reference genome for better alignment accuracy.
- **Phasing**: If your BAM file is already phased/tagged, use the `-btg` (bamIsTagged) flag to leverage existing phasing information.
- **Quality Filtering**: Use `-qs` to set a minimum quality score (default 10) to exclude low-quality reads from the genotyping process.

### Input Preparation
- **Motif Files**: Ensure your motif file includes the specific motif sequence. TandemTwister uses this for dynamic programming alignment.
- **Read Type Selection**: Always specify the correct `-rt` (CCS, CLR, or ONT) as this triggers specific internal noise correction parameters.

### Visualization
- After generating the output, use the companion tool **ProleTRact** for interactive exploration and visualization of the genotyped regions.

## Reference documentation
- [TandemTwister GitHub Repository](./references/github_com_Lionward_tandemtwister.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tandemtwister_overview.md)