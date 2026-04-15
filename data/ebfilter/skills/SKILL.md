---
name: ebfilter
description: EBFilter reduces false positive somatic mutation calls by analyzing sequencing noise across a panel of non-matched normal control samples using an empirical Bayesian model. Use when user asks to filter somatic mutations, reduce false positives in VCF files, or estimate sequencing error rates using a panel of normals.
homepage: https://github.com/Genomon-Project/EBFilter
metadata:
  docker_image: "quay.io/biocontainers/ebfilter:0.2.2--pyh5ca1d4c_0"
---

# ebfilter

## Overview
EBFilter (Empirical Bayesian Mutation Filtering) is a specialized tool designed to reduce the high rate of false positives often found in somatic mutation calling. It works by analyzing the "background noise" at specific genomic positions across a panel of non-matched normal control samples. By estimating the parameters of a beta-binomial sequencing error model, it determines if a mismatch observed in a tumor sample is a true mutation or a recurring sequencing artifact. The tool outputs a VCF file enriched with an `EB` tag, representing the statistical confidence that a mutation is genuine.

## Command Line Usage

### Basic Syntax
The primary command structure requires the candidate mutations, the tumor BAM, a list of control BAMs, and the desired output path:

```bash
EBFilter [options] <target.vcf> <target.bam> <control_list.txt> <output.vcf>
```

### Input Requirements
*   **target.vcf**: A VCF file containing candidate somatic mutations. It must be indexed (e.g., using `tabix`).
*   **target.bam**: The indexed BAM file for the tumor sample.
*   **control_list.txt**: A plain text file containing absolute paths to indexed BAM files of non-matched normal samples, one path per line.
*   **Reference Genome**: Ensure `samtools` is in your PATH, as EBFilter relies on it for pileup generation.

### Key Options and Flags
*   `-f {vcf,anno}`: Specifies input format. Use `vcf` (default) for VCF files or `anno` for Annovar format.
*   `-t <int>`: Number of threads to use for parallel processing.
*   `-q <int>`: Mapping quality threshold. Reads with a score below this value are ignored (default: 20).
*   `-Q <int>`: Base quality threshold. Bases with a score below this value are ignored (default: 15).
*   `--region <string>`: Restrict analysis to a specific genomic region (e.g., `chr1:1000000-2000000`).
*   `--loption`: Highly recommended for large VCF files. It forces the use of the `-l` option in `samtools mpileup`, which is significantly more efficient for high-volume mutation lists.
*   `--ff <string>`: Filter reads based on SAM flags. Default skips `UNMAP,SECONDARY,QCFAIL,DUP`.

## Best Practices and Expert Tips

### Optimizing Performance
For whole-genome sequencing (WGS) or large exome batches, always use the `--loption` flag. Without it, EBFilter may run a separate `mpileup` command for every single mutation, which is computationally expensive. Combining `--loption` with `--region` is the most efficient way to process large datasets.

### Control Sample Selection
The power of the Empirical Bayesian model depends on the quality and quantity of the non-matched controls. 
*   **Quantity**: Aim for at least 10-20 normal control BAMs to accurately estimate the error model parameters.
*   **Consistency**: Use control samples sequenced using the same platform, library preparation kit, and capture bait (for exomes) as the tumor sample to ensure artifacts are comparable.

### Interpreting Results
The output VCF will contain an `EB` score in the INFO field. 
*   A higher `EB` score indicates a higher likelihood that the mutation is somatic and not an artifact.
*   If the mismatch ratio in the tumor is significantly higher than the predicted mismatch ratio from the controls, the mutation is identified as highly likely.

### Troubleshooting
*   **Index Errors**: If the tool fails immediately, verify that all BAM files in `control_list.txt` have corresponding `.bai` indexes in the same directory.
*   **Samtools Version**: Ensure a modern version of `samtools` is installed, as EBFilter parses mpileup output which can vary between very old versions.

## Reference documentation
- [EBFilter GitHub Repository](./references/github_com_Genomon-Project_EBFilter.md)
- [EBFilter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ebfilter_overview.md)