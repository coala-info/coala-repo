---
name: famli
description: FAMLI identifies protein-coding sequences from metagenomic data by resolving multi-mapped reads and filtering by coverage evenness. Use when user asks to filter protein alignments, resolve multi-mapped reads, identify protein-coding sequences, or perform functional profiling of metagenomic data.
homepage: https://github.com/FredHutch/FAMLI
---

# famli

## Overview

FAMLI is a specialized tool for identifying protein-coding sequences from short-read shotgun metagenomic data. Its primary purpose is to solve the "multi-mapping" problem—where a single read aligns equally well to multiple reference proteins—which often leads to high false-positive rates. FAMLI uses an iterative likelihood inference algorithm to reassign these reads to the most probable reference and filters out sequences with uneven coverage (SD/Mean ratio > 1.0), significantly improving the precision of functional profiling.

## Core Workflows

### 1. Filtering Alignments
The `filter` command is the core of FAMLI. It processes BLASTX-like tabular alignments (e.g., from DIAMOND) to prune unlikely references and assign multi-mapped reads.

```bash
famli filter --input <alignments.tab> --output <results.json> --threads <int>
```

**Key Parameters:**
- `--sd-mean-cutoff`: Threshold for coverage evenness (default: 1.0). Lower values are more stringent.
- `--strim-5` / `--strim-3`: Number of amino acids to trim from the ends of references when calculating coverage to avoid edge effects.
- `--bitscore-ix`: The column index (0-based) for bitscores in the input file if using a non-standard tabular format.

### 2. Alignment Best Practices
FAMLI is designed to work with DIAMOND. For optimal results, use the following DIAMOND alignment parameters before running `famli filter`:

- `--query-cover 90`: Ensures the read covers most of the reference.
- `--id 80`: Minimum identity percentage.
- `--top 10`: Reports alignments within 10% of the top bitscore.
- `--min-score 20`: Minimum bitscore threshold.

### 3. Taxonomic Analysis Wrapper
The `diamond-tax.py` script acts as a wrapper for running the entire pipeline (alignment + LCA/likelihood inference) on FASTQ files.

```bash
python3 diamond-tax.py --input <input_url> --sample-name <name> --ref-db <db_path> --output-folder <out_path>
```
*Note: Supports local paths as well as s3:// and ftp:// URLs.*

## Expert Tips

- **Coverage Evenness**: If you encounter high false-positive rates despite using FAMLI, check the `SD / MEAN` ratio in the output. Truly present peptides should have relatively even coverage across their length.
- **Memory Management**: When processing very large metagenomes with many multi-mapping reads, increase the `--threads` count to speed up the iterative reassignment phase.
- **Input Formatting**: If your alignment tool produces custom tabular output, use the `--qseqid-ix`, `--sseqid-ix`, and `--slen-ix` flags to map the correct columns for FAMLI.



## Subcommands

| Command | Description |
|---------|-------------|
| famli | Align a set of reads with DIAMOND, filter alignments with FAMLI, and return the results |
| famli | Filter a set of existing alignments in tabular format with FAMLI |

## Reference documentation
- [FAMLI README](./references/github_com_FredHutch_FAMLI_blob_master_README.md)
- [DIAMOND-tax Wrapper](./references/github_com_FredHutch_FAMLI_blob_master_diamond-tax.py.md)