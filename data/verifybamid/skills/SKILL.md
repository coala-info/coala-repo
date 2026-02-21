---
name: verifybamid
description: VerifyBamID2 is a specialized tool for quantifying DNA contamination in sequence reads.
homepage: https://github.com/Griffan/VerifyBamID
---

# verifybamid

## Overview

VerifyBamID2 is a specialized tool for quantifying DNA contamination in sequence reads. It addresses the limitations of older models by using an ancestry-agnostic method based on Singular Value Decomposition (SVD) of a genotype matrix. This approach prevents the underestimation of contamination that typically occurs when population-specific allele frequencies are incorrectly assigned. It is a critical tool for ensuring the reliability of downstream genomic analyses like variant calling.

## Command Line Usage

The primary executable is `VerifyBamID`. It requires aligned sequence data, a reference genome, and pre-calculated resource files (SVD results).

### Basic Estimation (Recommended)
The simplest way to run the tool is by using the `--SVDPrefix` flag, which automatically locates the associated `.UD`, `.mu`, and `.bed` files.

```bash
VerifyBamID \
  --SVDPrefix /path/to/resource/1000g.100k.b38.vcf.gz.dat \
  --Reference /path/to/GRCh38_reference.fa \
  --BamFile /path/to/sample.bam \
  --NumThread 4
```

### Explicit Resource Mapping
If resource files do not share a common prefix, specify them individually:

```bash
VerifyBamID \
  --UDPath /path/to/file.UD \
  --BedPath /path/to/file.bed \
  --MeanPath /path/to/file.mu \
  --Reference /path/to/reference.fa \
  --BamFile /path/to/sample.cram
```

## Key Parameters and Best Practices

### Resource Selection
*   **Genome Build Consistency**: Ensure the resource files match the reference genome used for alignment. 
    *   For **GRCh37**: Use resources labeled `b37` (typically no 'chr' prefix).
    *   For **GRCh38**: Use resources labeled `b38` (typically includes 'chr' prefix).
*   **Pre-calculated Resources**: Use the provided 1000 Genomes (1000g) or Human Genome Diversity Project (HGDP) datasets found in the `resource/` directory of the installation.

### Performance Tuning
*   **Multi-threading**: Use `--NumThread [Int]` to speed up likelihood calculations. The default is 4.
*   **Convergence**: The `--Epsilon` parameter (default 1e-10) controls the trade-off between accuracy and runtime. Most users should keep the default.

### Advanced Estimation Logic
*   **WithinAncestry**: Use `--WithinAncestry` if you assume the target sample and the contamination source originate from the same population. By default, the tool assumes "between-ancestry" contamination.
*   **Fixed Parameters**: If the contamination level or PC coordinates are already known from other assays, use `--FixAlpha [Double]` or `--FixPC [PC1:PC2:PC3...]` to constrain the model.
*   **Known Allele Frequency**: For legacy workflows similar to VerifyBamID 1.0, provide a BED file with known frequencies using `--KnownAF`.

## Expert Tips
*   **CRAM Support**: The tool natively supports CRAM files, but ensure the `--Reference` path is provided and indexed, as CRAM requires the reference for decompression.
*   **Contamination Bias**: Using pooled allele frequencies can lead to significant underestimation (up to 70% in some populations). Always prefer the SVD-based ancestry-agnostic method provided by VerifyBamID2.
*   **Output Interpretation**: The primary output of interest is the "Alpha" value, which represents the estimated contamination proportion (e.g., 0.02 indicates 2% contamination).

## Reference documentation
- [VerifyBamID README](./references/github_com_Griffan_VerifyBamID.md)