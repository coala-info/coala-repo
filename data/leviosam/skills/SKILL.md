---
name: leviosam
description: LevioSAM is a high-performance tool for re-coordinating sequence alignments.
homepage: https://github.com/alshai/levioSAM
---

# leviosam

## Overview
LevioSAM is a high-performance tool for re-coordinating sequence alignments. It allows researchers to map reads aligned against a personalized or variant-aware reference back to a standard reference (like GRCh38) or to move alignments between different assembly versions. It preserves essential alignment metadata—including flags, CIGAR strings, and mate information—while updating positions to match the target reference.

## Common CLI Patterns

### 1. VCF-based Lift-over (VcfMap)
Use this workflow when lifting alignments from a variant-aware/personalized reference back to a standard reference.

**Step 1: Index the VCF**
```bash
leviosam index -v <input.vcf> -s <sample_name> -p <output_prefix>
```
*   `-v`: Input VCF file.
*   `-s`: Sample name in the VCF.
*   `-p`: Prefix for the generated `.lft` index.

**Step 2: Lift the alignments**
```bash
leviosam lift -a <input.sam/bam> -l <prefix.lft> -p <output_prefix> -t <threads> -O bam
```
*   `-a`: Input alignment file (SAM or BAM).
*   `-l`: The `.lft` index file created in Step 1.
*   `-O`: Output format (use `bam` for compressed output).

### 2. Chain-based Lift-over (ChainMap)
Use this workflow for assembly-to-assembly conversions (e.g., GRCh37 to GRCh38).

**Step 1: Index the Chain file**
```bash
leviosam index -c <input.chain> -p <output_prefix> -F <target.fai>
```
*   `-c`: Input chain file.
*   `-F`: Fasta index (`.fai`) of the destination reference.

**Step 2: Lift the alignments**
```bash
leviosam lift -C <prefix.clft> -a <input.bam> -p <output_prefix> -t <threads> -O bam
```
*   `-C`: The `.clft` index file created in Step 1.

## Expert Tips and Best Practices

*   **Performance**: Always utilize the `-t` flag to specify the number of threads, as levioSAM is optimized for multithreading.
*   **Memory Management**: For large VCFs or complex chain files, ensure the system has sufficient RAM to load the index into memory.
*   **Tag Preservation**: By default, levioSAM updates the MD:Z and NM:i tags. If these are not required, you can omit them to save processing time.
*   **ChainMap Updates**: While levioSAM supports chain files, the developers recommend using `levioSAM2` for the most up-to-date assembly-to-assembly lift-over features.
*   **Input Validation**: Ensure your input SAM/BAM files are sorted if you intend to perform downstream analysis immediately after lift-over, though levioSAM itself can process unsorted streams.

## Reference documentation
- [levioSAM GitHub Repository](./references/github_com_alshai_levioSAM.md)
- [levioSAM Wiki](./references/github_com_alshai_levioSAM_wiki.md)