---
name: illumina-cleanup
description: This tool processes raw Illumina sequencing data through a standardized pipeline of quality assessment, adapter trimming, and error correction. Use when user asks to clean raw FASTQ files, remove sequencing artifacts, perform k-mer based error correction, or downsample reads to a specific coverage level.
homepage: https://github.com/rpetit3/illumina-cleanup
---


# illumina-cleanup

## Overview
The `illumina-cleanup` tool is a Nextflow-based pipeline designed to transform raw Illumina sequencing data into high-quality reads suitable for downstream analysis like de novo assembly or variant calling. It acts as a streamlined wrapper for several industry-standard tools: FastQC for quality assessment, BBTools (BBDuk and Reformat) for trimming and filtering, Lighter for k-mer based error correction, and fastq-scan for summary statistics. 

Use this skill when you have raw FASTQ files (single-end or paired-end) and need a standardized, reproducible workflow to remove technical artifacts and improve the overall signal-to-noise ratio of your sequencing data.

## Installation and Setup
The most reliable way to use the tool is via Bioconda:
```bash
conda install -c bioconda illumina-cleanup
```

## Input Preparation (The FOFN)
The tool requires a tab-delimited "File of Filenames" (FOFN) to define your samples. This avoids complex pattern matching and allows processing of mixed single-end (SE) and paired-end (PE) datasets in one run.

**FOFN Structure:**
The file must have a header: `sample`, `r1`, and `r2`.
- For PE: Provide paths to both R1 and R2.
- For SE: Provide the path to R1 and leave R2 empty or omit the tab.

**Example FOFN (`samples.txt`):**
```text
sample	r1	r2
ERR123	/data/ERR123_1.fq.gz	/data/ERR123_2.fq.gz
ERR456	/data/ERR456_single.fq.gz
```

**Pro Tip:** Use the built-in validation flag to ensure your paths are correct before starting the pipeline:
```bash
illumina-cleanup --fastqs samples.txt --check_fastqs
```

## Common CLI Patterns

### Standard Quality Cleanup
To run a basic cleanup with default parameters (Adapter removal, PhiX removal, Q6 trimming, and Error Correction):
```bash
illumina-cleanup --fastqs samples.txt --outdir ./cleaned_reads --max_cpus 8
```

### Coverage Normalization/Reduction
If you have extremely high coverage and want to downsample to a specific level (e.g., 100x) to speed up assembly:
```bash
illumina-cleanup --fastqs samples.txt --genome_size 5000000 --coverage 100
```
*Note: `--genome_size` is required when using `--coverage`.*

### Aggressive Quality Filtering
For datasets with known low-quality tails, increase the minimum average quality (`--maq`) and trimming threshold (`--trimq`):
```bash
illumina-cleanup --fastqs samples.txt --trimq 20 --maq 25 --minlength 50
```

## Expert Tips and Best Practices

- **Memory Management:** The tool uses Java-based BBTools. If you encounter OutOfMemory errors, use the `--xmx` flag to allocate more RAM (e.g., `--xmx 16g`).
- **Resource Allocation:** Use `--max_cpus` to limit the total CPUs used by the entire Nextflow workflow, and `--cpus` to define how many threads a single process (like Lighter) can use.
- **PhiX Contamination:** By default, the tool filters against the phiX174 genome. If you are working with non-standard spike-ins, you can provide a custom FASTA using `--phix`.
- **Intermediate Files:** By default, the tool deletes the `work/` directory and `.nextflow` logs upon successful completion to save space. If you need to debug a failure, use `--keep_cache`.
- **Error Correction:** Base-error correction via Lighter is enabled by default. If you prefer to skip this (e.g., for very low-depth samples where k-mer counts might be unreliable), you may need to modify the underlying Nextflow logic as there is no explicit "skip" flag in the standard CLI.

## Reference documentation
- [illumina-cleanup GitHub Repository](./references/github_com_rpetit3_illumina-cleanup.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_illumina-cleanup_overview.md)