---
name: verifybamid2
description: "verifybamid2 quantifies inter-sample DNA contamination in sequencing libraries using an ancestry-agnostic SVD approach. Use when user asks to 'estimate DNA contamination', 'detect within-ancestry contamination', 'constrain contamination level', or 'constrain PC coordinates'."
homepage: https://github.com/Griffan/VerifyBamID
---


# verifybamid2

## Overview
verifybamid2 is a specialized tool for quantifying inter-sample DNA contamination in sequencing libraries. It improves upon previous methods by using an ancestry-agnostic approach based on Singular Value Decomposition (SVD). This method avoids the common bias of underestimating contamination that occurs when allele frequencies are not accurately matched to the sample's specific population. It is compatible with both BAM and CRAM formats and supports major human genome builds (GRCh37 and GRCh38).

## Installation
The most efficient way to install verifybamid2 is via Bioconda:
```bash
conda install -c bioconda verifybamid2
```

## Common CLI Patterns

### Standard Contamination Estimation
The simplest way to run the tool is by using the `--SVDPrefix` argument, which points to a set of pre-calculated resource files (.UD, .mu, and .bed).

```bash
VerifyBamID --BamFile sample.bam \
            --Reference reference.fasta \
            --SVDPrefix /path/to/resource/1000g.100k.b38.vcf.gz.dat \
            --NumThread 4
```

### Explicit Resource Pathing
If your resource files do not share a common prefix or are stored separately, specify them individually:

```bash
VerifyBamID --BamFile sample.cram \
            --Reference reference.fasta \
            --UDPath resources.UD \
            --BedPath resources.bed \
            --MeanPath resources.mu \
            --NumThread 8
```

### Handling Human Genome Builds
Ensure your resource files match your alignment reference:
*   **GRCh37 (b37):** Typically uses the `1000g.100k.b37` resources. Note that this build usually lacks the "chr" prefix in chromosome names.
*   **GRCh38 (b38):** Typically uses the `1000g.100k.b38` resources. This build usually includes the "chr" prefix.

## Parameter Optimization and Best Practices

### Performance Tuning
*   **Multithreading:** Use `--NumThread [Int]` to speed up likelihood calculations. The default is 4, but increasing this on high-core systems significantly reduces runtime.
*   **Convergence:** The `--Epsilon` parameter (default 1e-10) controls the minimization threshold. Adjusting this can trade off between precision and execution speed.

### Estimation Logic
*   **Ancestry Assumptions:** By default, the tool assumes "between-ancestry" contamination. If you suspect the contamination source is from the same population as the target sample, enable `--WithinAncestry`.
*   **Fixed Parameters:** If the contamination level or PC coordinates are already known from other assays, use `--FixAlpha [Double]` or `--FixPC [PC1:PC2:PC3...]` to constrain the model.
*   **Seed for Reproducibility:** Use `--Seed [INT]` (default 12345) to ensure deterministic results across different runs on the same data.

### Troubleshooting
*   **Reference Mismatch:** If the tool fails to find markers, verify that the `--Reference` fasta file matches the one used for the original BAM/CRAM alignment, specifically regarding chromosome naming conventions (e.g., "1" vs "chr1").
*   **Pileup Output:** If results seem anomalous, use `--OutputPileup true` to generate a temporary pileup file for manual inspection of the marker sites.

## Reference documentation
- [VerifyBamID GitHub Repository](./references/github_com_Griffan_VerifyBamID.md)
- [Bioconda verifybamid2 Package Overview](./references/anaconda_org_channels_bioconda_packages_verifybamid2_overview.md)