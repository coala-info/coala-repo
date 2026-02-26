---
name: htseq
description: HTSeq is a Python-based suite used to quantify gene expression by overlapping aligned sequencing reads with genomic features. Use when user asks to count reads per gene, perform quality assessment of sequencing data, or process single-cell barcoded alignments.
homepage: https://github.com/htseq/htseq
---


# htseq

## Overview
HTSeq is a specialized Python-based suite designed for the functional analysis of high-throughput sequencing data. Its primary utility lies in `htseq-count`, a robust tool for overlapping aligned reads with genomic features to produce a digital gene expression matrix. This skill provides the necessary patterns for gene quantification, quality control via `htseq-qa`, and handling modern sequencing outputs like BigWig or single-cell barcodes.

## Installation and Environment
HTSeq requires Python 3.10+ and key dependencies including `numpy` and `pysam`.
- **Conda (Recommended):** `conda install bioconda::htseq`
- **Pip:** `pip install HTSeq`
- **Optional Dependencies:** 
  - `matplotlib` (required for `htseq-qa`)
  - `pyBigWig` (required for BigWig manipulation)
  - `scipy`, `anndata`, or `loompy` (required for custom output formats like `.mtx`, `.h5ad`, or `.loom`)

## Common CLI Patterns

### Basic Gene Quantification
The most common use case is counting how many reads map to each gene.
```bash
htseq-count [options] <alignment_file.bam> <features.gtf> > counts.txt
```

### Handling Multi-mapping and Secondary Alignments
By default, `htseq-count` ignores reads that are not uniquely mapped. To adjust behavior for secondary alignments:
- Use `--secondary-alignments` to determine whether to skip or include alignments marked as secondary.
- For multimappers, ensure your alignment file is sorted by name (`-r name`) or position (`-r pos`) as required by your specific version's logic.

### Single-Cell and Barcoded Data
For single-cell RNA-Seq, use the barcode-aware counting script:
```bash
htseq-count-barcodes [options] <alignment_file.bam> <features.gtf>
```
*Note: This requires `scipy` or `anndata` if you intend to output in sparse matrix formats.*

### Quality Assessment
To generate a report on the quality of the HTS measurements:
```bash
htseq-qa [options] <alignment_file.bam>
```

## Expert Tips
- **Chromosome Info:** If your GTF and BAM files have different chromosome naming conventions, use `--add-chromosome-info` to help resolve mapping issues.
- **Output Formats:** When working with large-scale datasets (like single-cell), prefer outputting to `.h5ad` or `.loom` formats to save disk space and improve downstream loading times in Python environments.
- **Feature Types:** You can specify which feature type (3rd column in GTF, e.g., "exon") and which attribute (e.g., "gene_id") to use for grouping counts using the `-t` and `-i` flags respectively.
- **Testing:** Use the `-o` option to output the counts to a specific file and verify the run completion without relying solely on stdout redirection.

## Reference documentation
- [HTSeq Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_htseq_overview.md)
- [HTSeq GitHub Repository](./references/github_com_htseq_htseq.md)
- [HTSeq Issues and Bug Reports](./references/github_com_htseq_htseq_issues.md)