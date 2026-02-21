---
name: bustools
description: `bustools` is a specialized suite of tools designed to manipulate BUS files, which are the standard output format for the `kallisto bus` pseudoalignment pipeline.
homepage: https://github.com/BUStools/bustools
---

# bustools

## Overview

`bustools` is a specialized suite of tools designed to manipulate BUS files, which are the standard output format for the `kallisto bus` pseudoalignment pipeline. It is optimized for speed and memory efficiency, enabling the processing of hundreds of millions of reads on standard hardware. Use this skill to navigate the standard single-cell preprocessing workflow: sorting raw BUS records, correcting barcodes against an allowlist, and collapsing UMIs into final count matrices.

## Core Workflow Patterns

The standard `kallisto | bustools` pipeline typically follows this sequence:

### 1. Sorting
Raw BUS files are often unsorted. Sorting is a prerequisite for most other commands.
```bash
bustools sort -t 8 -m 4G -o output_sorted.bus input.bus
```
*   **Tip**: Use `-m` to specify maximum memory. For large datasets, ensure the `-T` (temp directory) has sufficient space.

### 2. Barcode Error Correction
Correct sequencing errors in barcodes using a technology-specific allowlist (e.g., 10x Genomics, Drop-seq).
```bash
bustools correct -w allowlist.txt -o output_corrected.bus output_sorted.bus
```

### 3. Re-sorting
After correction, the BUS file must be re-sorted to group corrected barcodes together before counting.
```bash
bustools sort -t 8 -m 4G -o output_corrected_sorted.bus output_corrected.bus
```

### 4. Generating Count Matrices
Convert the sorted, corrected BUS file into a digital gene expression (DGE) matrix.
```bash
bustools count -o matrix_prefix -g transcripts_to_genes.txt -e matrix.ec -t transcripts.txt --genecounts output_corrected_sorted.bus
```
*   **--genecounts**: Aggregates counts to the gene level.
*   **--cm**: Use this flag if you need to count multiplicities instead of unique UMIs.

## Utility Commands

### Quality Control with Inspect
Generate a summary report of the BUS file to check mapping rates and barcode diversity.
```bash
bustools inspect -o report.json -w allowlist.txt output_sorted.bus
```

### Interoperability with Text
Convert binary BUS files to tab-delimited text for inspection or custom scripting.
```bash
bustools text -o output.txt input.bus
```
To convert back to binary:
```bash
bustools fromtext -o output.bus input.txt
```

### Capturing Specific Targets
Filter a BUS file to include only specific transcripts or genes.
```bash
bustools capture -o captured.bus -c capture_list.txt -e matrix.ec -t transcripts.txt input.bus
```

## Expert Tips

*   **Piping for Efficiency**: Many commands support the `-p` or `--pipe` flag. You can pipe the output of `sort` directly into `correct` to save disk I/O, though intermediate files are often safer for large-scale troubleshooting.
*   **Memory Management**: When running `bustools sort`, set `-m` to approximately 70-80% of your available system memory to prevent OOM (Out of Memory) errors while maximizing performance.
*   **UMI Correction**: For advanced workflows, use `bustools umicorrect` to apply specific UMI error correction algorithms beyond simple collapsing.

## Reference documentation
- [bustools GitHub Repository](./references/github_com_BUStools_bustools.md)
- [Bioconda bustools Overview](./references/anaconda_org_channels_bioconda_packages_bustools_overview.md)