---
name: maegatk
description: maegatk extracts high-quality mitochondrial genotypes from sequencing data by using UMIs to collapse PCR duplicates and create consensus base calls. Use when user asks to call mitochondrial variants, generate genotype matrices from single-cell data, or identify mitochondrial heteroplasmy and indels.
homepage: https://github.com/caleblareau/maegatk
---


# maegatk

## Overview

maegatk is a specialized toolkit designed to extract high-quality mitochondrial genotypes from sequencing data. Its primary strength lies in its ability to collapse PCR duplicates using Unique Molecular Identifiers (UMIs) and insert positions to create a consensus base call. This error-correction mechanism is essential for distinguishing true low-frequency heteroplasmy from sequencing artifacts. The tool is optimized for single-cell workflows, allowing researchers to reconstruct cellular lineages or track clones using mitochondrial mutations as natural barcodes.

## Core Workflows

### Mitochondrial Base Calling (bcall)

The `bcall` mode is the primary entry point for generating genotype matrices.

```bash
maegatk bcall -i <input.bam> -o <output_directory> -b <barcodes.txt> -g rCRS -c <cores>
```

**Key Parameters:**
- `-i, --input`: A singular, indexed BAM file containing mitochondrial reads.
- `-b, --barcodes`: A text file containing the cell barcodes to be processed.
- `-bt, --barcode-tag`: The BAM tag representing the cell barcode (e.g., `CB` or `CR`).
- `-ub, --umi-barcode`: The BAM tag representing the UMI (e.g., `UB` or `OX`).
- `-g, --mito-genome`: The reference genome. Use `rCRS` for the built-in human mitochondrial reference or provide a path to a BWA-indexed FASTA.
- `-mr, --min-reads`: Minimum number of supporting reads required to call a consensus UMI (default is 1). Increase this for higher stringency.

### Indel Calling

Indel calling is a multi-step process that requires a successful `bcall` run first.

1. **Run bcall with quality control flags**: Ensure you retain the per-cell BAM files.
2. **Execute maegatk-indel**:
   ```bash
   maegatk-indel -i <bcall_output_dir>/temp/ready_bam -o <indel_output_dir> -m 5
   ```
   - The `-m` flag sets the minimum number of reads in a cell required to support an indel (default is 5).

## Expert Tips and Best Practices

### Resource Management
- **Java Memory**: If the duplicate removal step (fgbio) fails, increase the allocated memory using `-jm` (e.g., `-jm 8000m`).
- **Parallelization**: Use the `-c` flag to specify the number of cores. maegatk uses Snakemake internally to parallelize processing across cell barcodes.
- **Temporary Files**: Use the `-z` flag to keep intermediate files. This is critical for troubleshooting and is required if you plan to run `maegatk-indel` later.

### Input Preparation
- **BAM Tags**: Ensure your BAM file is properly tagged with Cell Barcodes and UMIs. If these tags are missing or non-standard, the tool will not be able to collapse reads or separate cells.
- **NH/NM Flags**: maegatk filters reads based on the `NH` (number of alignments) and `NM` (edit distance) tags. You can adjust these thresholds using `--NHmax` and `--NMmax`.

### Output Interpretation
- **RDS Files**: By default, maegatk produces a `.rds` file in the `final/` directory. This is a `SingleCellExperiment` object ready for analysis in R.
- **Plain Text**: If you do not have R installed or prefer text output, use the `--skip-R` flag to generate compressed `.txt.gz` files containing the sparse matrices of counts.
- **Variant Selection**: When analyzing results, focus on variants with high strand correlation and sufficient coverage to avoid false positives.

### Troubleshooting
- **Generic R Errors**: These often stem from failures in the Snakemake pipeline. Check the `logs/` directory for specific error messages from individual cell processing steps.
- **Fgbio Tmp Directory**: For large datasets, the default system tmp directory may overflow. You may need to manually edit the `oneSample_maegatk.py` script in your installation to point `-Djava.io.tmpdir` to a larger partition.



## Subcommands

| Command | Description |
|---------|-------------|
| maegatk | a Maester genome toolkit. |
| maegatk | a Maester genome toolkit. |

## Reference documentation
- [Main README and CLI Reference](./references/github_com_caleblareau_maegatk.md)
- [Frequently Asked Questions](./references/github_com_caleblareau_maegatk_wiki_FAQ.md)
- [Indel Calling Workflow](./references/github_com_caleblareau_maegatk_wiki_Indel-calling.md)
- [Functional Annotation of Variants](./references/github_com_caleblareau_maegatk_wiki_Functional-annotation.md)