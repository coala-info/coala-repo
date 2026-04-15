---
name: hapcut2
description: HapCUT2 is a high-performance tool for reconstructing haplotypes from aligned sequence reads using a maximum-likelihood framework. Use when user asks to reconstruct haplotypes, phase variants from BAM and VCF files, or assemble haplotypes using long-read or Hi-C sequencing data.
homepage: https://github.com/vibansal/HapCUT2/
metadata:
  docker_image: "quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2"
---

# hapcut2

## Overview
HapCUT2 is a high-performance tool for reconstructing haplotypes from aligned sequence reads. It utilizes a maximum-likelihood framework to "just work" across various sequencing platforms with high speed and accuracy. The tool is designed for diploid organisms and processes one individual at a time, requiring a BAM file of aligned reads and a VCF file of called variants as input.

## Core Workflow
Haplotype assembly with HapCUT2 is a two-step process.

### 1. Extract Haplotype-Informative Reads (HAIRS)
Use `extractHAIRS` to convert the BAM file into a compact fragment file containing only the information relevant for phasing.
```bash
./build/extractHAIRS [options] --bam reads.sorted.bam --VCF variants.vcf --out fragment_file
```
*Note: The VCF file must be unzipped; gzipped VCFs are not supported.*

### 2. Assemble Haplotypes
Use `HAPCUT2` to process the fragment file and generate phased blocks.
```bash
./build/HAPCUT2 --fragments fragment_file --VCF variants.vcf --output haplotype_output_file
```

## Technology-Specific Best Practices

### Long Reads (PacBio and Oxford Nanopore)
To improve accuracy with error-prone long reads, use the specific technology flags and provide the reference genome for realignment.
*   **PacBio**: Use `--pacbio 1` in `extractHAIRS`.
*   **ONT**: Use `--ont 1` in `extractHAIRS`.
*   **Indels**: Add `--indels 1` to phase insertion/deletion variants.
*   **Example**:
    ```bash
    ./build/extractHAIRS --pacbio 1 --indels 1 --bam reads.bam --VCF vars.vcf --ref ref.fa --out fragments
    ```

### Hi-C (Proximity Ligation)
Hi-C data requires specific handling for long-range information.
*   **Alignment**: Align reads using `bwa mem -5SPM` to preserve mate-pair information.
*   **Execution**: Use the `--hic 1` flag in **both** steps.
*   **Insert Size**: Use `--maxIS` (e.g., 10000000) in `extractHAIRS` to control the maximum insert size for read pairs on the same chromosome.

### Multi-Technology Integration
If combining data (e.g., PacBio + Hi-C):
1.  Run `extractHAIRS` on each BAM independently.
2.  Use the `--nf 1` flag during extraction to ensure a compatible fragment format.
3.  Concatenate the resulting fragment files using the Linux `cat` command.
4.  Run `HAPCUT2` on the combined fragment file using the `--nf 1` flag.

## Expert Tips and Parameters
*   **SNV Pruning**: Control the filtering of low-quality phased SNVs using `--threshold <float>`. A value closer to 1.0 is more aggressive (higher precision, lower yield), while 0.5 is less aggressive. Use `--no_prune 1` to disable pruning entirely.
*   **Output Files**: HapCUT2 generates two primary outputs:
    1.  A phased block file (custom format).
    2.  A phased VCF file (`.phased.vcf`) following standard VCF specifications.
*   **Statistics**: Use the `calculate_haplotype_statistics` script in the `utilities` directory to evaluate N50, AN50, and error rates against a reference haplotype.

## Reference documentation
- [HapCUT2 GitHub README](./references/github_com_vibansal_HapCUT2.md)
- [HapCUT2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hapcut2_overview.md)