---
name: haplotaglr
description: HaplotagLR assigns individual long DNA sequencing reads to specific parental haplotypes by comparing them against pre-phased variants. Use when user asks to haplotag long-read data, assign reads to a specific chromosome, or perform allele-specific analysis.
homepage: https://github.com/Boyle-Lab/HaplotagLR.git
---


# haplotaglr

## Overview
HaplotagLR is a specialized bioinformatics tool for "haplotagging"—the process of assigning individual long DNA sequencing reads to a specific parental chromosome (haplotype). This skill enables the processing of long-read data (such as Oxford Nanopore or PacBio) by comparing observed bases in the reads against a set of high-confidence, pre-phased variants. It is particularly useful for downstream applications like allele-specific expression analysis, chromatin accessibility studies, or structural variant phasing.

## Usage Guidelines

### Core Command Structure
The primary mode of operation is `haplotag`. The tool requires a phased VCF and an input sequence file.

```bash
HaplotagLR haplotag -v <phased_variants.vcf.gz> -i <input_reads.bam> -r <reference.fasta> -o <output_dir>
```

### Input Requirements
- **VCF File (`-v`)**: Must be `bgzip` compressed and `tabix` indexed. If a raw `.vcf` is provided, the tool will attempt to convert it if `bgzip` and `tabix` are in your PATH.
- **Read Files (`-i`)**: Supports `.bam`, `.sam`, or `.fastq`. 
    - If using `.fastq`, the reference genome (`-r`) is **mandatory** for alignment via minimap2.
    - If using `.bam`, ensure it is sorted and indexed (`.bai` file in the same directory).

### Output Modes (`-O`)
Control how the results are organized using the `-O` flag:
- `combined` (Default): A single output file where reads contain an `HP:i:N` tag (1 for Haplotype 1, 2 for Haplotype 2).
- `phase_tagged`: One file for all phased reads, separate files for unphased/nonphasable reads.
- `full`: Four separate files (Maternal, Paternal, Unphased, Nonphasable).

### Statistical Tuning
- **Error Rates**: By default, the tool calculates error rates per read. Use `--global_epsilon` to set a fixed error rate if the sequencing quality is known and consistent.
- **FDR Control (`-F`)**: To reduce false assignments, set an FDR threshold (e.g., `-F 0.05`). This uses a negative-binomial estimate to filter out low-confidence tags.
- **Likelihood Threshold**: Use `--log_likelihood_threshold` to ignore assignments where the difference between haplotypes is marginal.

### Performance Optimization
- Use `-t <threads>` to speed up the alignment (if starting from FASTQ) and sorting phases.
- Use `-q` (quiet) or `-S` (silent) in automated pipelines to reduce log verbosity.

## Expert Tips
- **Sample Filtering**: If your VCF contains multiple individuals, use `-s <SAMPLE_NAME>` to ensure you are only phasing against the correct individual's haplotypes.
- **Reference Assembly**: Always specify the assembly version (e.g., `-A hg38`) to ensure coordinate consistency, especially if the tool needs to perform internal liftovers or reference lookups.
- **Memory Management**: When processing large BAM files, ensure the temporary directory has sufficient space for sorting operations.

## Reference documentation
- [HaplotagLR GitHub README](./references/github_com_Boyle-Lab_HaplotagLR.md)