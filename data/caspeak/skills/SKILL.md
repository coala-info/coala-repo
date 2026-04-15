---
name: caspeak
description: CasPeak identifies mobile element insertions from targeted Nanopore sequencing data by combining read alignment, peak detection, and local assembly. Use when user asks to identify non-reference insertions, detect coverage peaks from Cas9-targeted sequencing, or validate insertion events through local assembly and dotplot visualization.
homepage: https://github.com/Rye-lxy/CasPeak
metadata:
  docker_image: "quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0"
---

# caspeak

## Overview
CasPeak is a specialized bioinformatics pipeline designed to identify mobile element insertions (MEIs) that are not present in a reference genome. It specifically leverages the unique signal from outer-Cas9 targeted Nanopore sequencing. By combining read alignment (via LAST), peak detection, and local assembly (via lamassemble), it provides a robust workflow for validating real insertion events.

## Core Workflows

### The All-in-One Shortcut
For most users, the `exec` subcommand is the preferred entry point as it handles the entire pipeline from raw reads to validated VCF.

```bash
caspeak exec \
    --read reads.fq.gz \
    --ref hg38.fa \
    --insert consensus.fa \
    --target-start 100 \
    --target-end 120 \
    --thread 8 \
    --vcf \
    --bedtools-genome human.hg38.genome
```

### Step-by-Step Execution
If you need to inspect intermediate files or adjust parameters between stages, run the subcommands sequentially:

1.  **Align**: Map reads to both the reference and the insertion consensus.
    ```bash
    caspeak align --read reads.fq --ref ref.fa --insert mei.fa --thread 4
    ```
2.  **Peak**: Filter reads and identify coverage peaks.
    *   *Tip*: Use `--exog` if the mobile element is completely foreign to the reference genome.
    *   *Tip*: Use `--mask` with a RepeatMasker file to reduce false positives in repetitive regions.
    ```bash
    caspeak peak --target-start <INT> --target-end <INT> --min-cov 2
    ```
3.  **Valid**: Perform local assembly to confirm the insertion.
    ```bash
    caspeak valid --thread 4 --vcf
    ```

## Expert Tips and Best Practices

### Input Requirements
*   **Target Coordinates**: You must know the exact Cas9 target site coordinates within your insertion consensus sequence (`--target-start` and `--target-end`).
*   **Genome Files**: CasPeak defaults to `human.hg38.genome` for bedtools operations. If working with other species or custom builds, you must provide a genome file (tab-delimited: chromosome name and length) via `--bedtools-genome`.

### Filtering and Trimming
*   **Read Length**: The default minimum read length is 500bp. For highly fragmented data, adjust `--min-read-length`.
*   **Alignment Proportion**: Use `--max-prop` (default 0.99) and `--min-prop` (default 0.4) to control how much of a read must align to the reference. This helps filter out reads that are entirely reference-derived or entirely noise.
*   **Padding**: If your targeting isn't perfectly precise, increase `--padding` (default 20) to capture reads near the target site.

### Visualization
After validation, use the `plot` subcommand to generate dotplots for every detected peak. This is the most effective way to manually curate and verify the structural integrity of the detected MEIs.
```bash
caspeak plot --maf result/validate.maf
```



## Subcommands

| Command | Description |
|---------|-------------|
| caspeak | caspeak: error: argument {align,peak,valid,exec,plot}: invalid choice: 'sequence' (choose from align, peak, valid, exec, plot) |
| caspeak exec | Execute the CASpeak pipeline for detecting mobile element insertions. |
| caspeak_align | Aligns reads to a reference genome, considering MEI insertions. |
| caspeak_peak | Detects peaks of mobile element insertions in sequencing data. |
| caspeak_plot | Plot MAF files |
| caspeak_valid | Validate peaks |

## Reference documentation
- [CasPeak README](./references/github_com_Rye-lxy_CasPeak_blob_master_README.md)
- [CasPeak CLI Source](./references/github_com_Rye-lxy_CasPeak_blob_master_caspeak.md)