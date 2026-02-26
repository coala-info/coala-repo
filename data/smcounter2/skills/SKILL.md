---
name: smcounter2
description: smCounter2 is a variant caller that leverages Unique Molecular Identifiers to identify low-allele-frequency mutations in deep sequencing data. Use when user asks to identify low-frequency variants, perform liquid biopsy analysis, or call variants from UMI-tagged sequencing data.
homepage: https://github.com/qiaseq/qiaseq-smcounter-v2
---


# smcounter2

## Overview
smCounter2 is a specialized variant caller optimized for identifying low-allele-frequency (AF) mutations. By leveraging Unique Molecular Identifiers (UMIs), it distinguishes true biological variants from sequencing artifacts and PCR errors. This tool is essential for liquid biopsy analysis, oncology research, and any deep sequencing application where high precision at low detection limits is required.

## CLI Usage and Best Practices

### Core Command Pattern
The primary execution involves pointing the tool to your aligned BAM file (containing UMI tags) and the target regions.

```bash
python smCounter2.py \
    --outdir ./results \
    --runPath ./ \
    --bam <input.bam> \
    --bed <targets.bed> \
    --ref <reference.fasta> \
    --rType <primer_dist> \
    --mtp <threshold> \
    --hpLen <homopolymer_limit>
```

### Key Parameters
- `--bam`: Input BAM must be indexed and contain UMI information (typically in the `BC` or `RX` tag).
- `--bed`: A BED file defining the target regions (e.g., the QIAseq panel regions).
- `--rType`: Set to `target` for most panel-based sequencing.
- `--mtp`: The "Maximum Threshold for Primer" - adjust based on the expected primer distance for your specific library prep.
- `--hpLen`: Homopolymer length filter; increasing this can help reduce false positives in repetitive regions but may miss true indels.

### Expert Tips
- **Resource Allocation**: smCounter2 is computationally intensive due to UMI consensus building. Ensure you provide sufficient CPU cores and memory, especially for high-depth samples (>10,000x).
- **Input Validation**: Always ensure your BAM file headers are compatible with your reference FASTA. Discrepancies in chromosome naming (e.g., "chr1" vs "1") will cause the tool to fail or return empty results.
- **Filtering**: The raw output contains many candidate variants. Focus on the `FILTER` column in the resulting VCF; variants marked as `PASS` have met the internal statistical thresholds for UMI support and quality.

## Reference documentation
- [smCounter2 Overview](./references/anaconda_org_channels_bioconda_packages_smcounter2_overview.md)