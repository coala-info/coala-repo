---
name: maegatk
description: maegatk analyzes mitochondrial DNA variants from single-cell sequencing data by performing consensus base inference and genotype calling. Use when user asks to call mitochondrial variants, process MAESTER data, or generate single-cell mtDNA sparse matrices.
homepage: https://github.com/caleblareau/maegatk
---


# maegatk

## Overview

maegatk (Mitochondrial Alteration Enrichment and Genome Analysis Toolkit) is a specialized command-line interface for analyzing mitochondrial DNA (mtDNA) variants. It is particularly optimized for MAESTER data but supports any UMI-based single-cell RNA-seq protocol. The tool's primary value lies in its ability to perform consensus base inference, which effectively removes PCR duplicates and sequencing errors to provide robust genotype calls at the single-cell level. It coordinates complex workflows using Snakemake to handle everything from barcode splitting to sparse matrix generation.

## Common CLI Patterns

### Standard Base Calling (bcall)
The most common entry point for processing a single-cell BAM file.
```bash
maegatk bcall \
  -i input.bam \
  -o output_directory \
  -n project_name \
  -g rCRS \
  -bt CB \
  -b barcodes.txt \
  -c 12
```
*   `-g rCRS`: Uses the built-in revised Cambridge Reference Sequence.
*   `-bt CB`: Specifies the BAM tag used for cell barcodes (e.g., 'CB' for 10x Genomics).
*   `-b`: Path to a whitelist of barcodes to process.

### Processing with Custom UMI Tags
If your data uses a non-standard UMI tag (default is often 'UB'), specify it explicitly.
```bash
maegatk bcall -i input.bam -o output -g rCRS -bt CB -ub UR
```

### Resource Management and Parallelization
For large datasets, manage CPU cores and Java memory (used by fgbio for duplicate removal).
```bash
maegatk bcall -i input.bam -o output -g rCRS -c 24 -jm 8000m
```

### Troubleshooting and Intermediate Files
If a run fails, use the `-z` flag to keep intermediate files for inspection in the `temp/` and `logs/` directories.
```bash
maegatk bcall -i input.bam -o output -g rCRS -z
```

## Expert Tips and Best Practices

### Java Temporary Directory Configuration
A common failure point is the system temporary directory overflowing during `fgbio` execution. If you encounter "No space left on device" errors despite having disk space, you must manually edit the `oneSample_maegatk.py` script in your installation directory to point to a larger scratch space:
*   Locate: `maegatk/bin/python/oneSample_maegatk.py`
*   Modify the `fgbio` string to include: `-Djava.io.tmpdir=/path/to/large/scratch/`

### Handling Indels
maegatk supports indel calling via `freebayes`. Ensure `freebayes` is available in your PATH to utilize this feature during the `bcall` process.

### Downstream Analysis Compatibility
*   **R Users**: By default, maegatk produces a `.rds` file in the `final/` folder containing a `SingleCellExperiment` object.
*   **Python/Other Users**: Use the `--skip-R` flag to generate only plain-text `.txt.gz` files, which are easier to parse in non-R environments and save time if R dependencies are problematic.

### Input BAM Requirements
Ensure your input BAM is:
1.  **Indexed**: A `.bai` file must exist.
2.  **Tagged**: Must contain the barcode (`-bt`) and UMI (`-ub`) tags.
3.  **Filtered**: While maegatk has internal filters (`--NHmax`, `--NMmax`), pre-filtering for mitochondrial reads can significantly speed up the initial barcode-splitting step.

## Reference documentation
- [maegatk GitHub Repository](./references/github_com_caleblareau_maegatk.md)
- [maegatk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_maegatk_overview.md)