---
name: deblur
description: Deblur is a greedy deconvolution algorithm that denoises amplicon sequencing data to produce high-resolution single-nucleotide community profiles. Use when user asks to denoise 16S rRNA sequences, generate sub-operational taxonomic units, or perform reference-based filtering on amplicon data.
homepage: https://github.com/biocore/deblur
---

# deblur

## Overview

Deblur is a greedy deconvolution algorithm designed to obtain high-resolution single-nucleotide community profiles from amplicon sequencing data. It uses error profiles to distinguish between true biological sequences and sequencing errors, resulting in sub-operational taxonomic units (sOTUs). This skill should be used to guide the denoising process, manage reference-based filtering (positive and negative), and interpret the resulting BIOM tables. It is particularly effective for 16S rRNA studies but can be adapted for other markers with appropriate reference databases.

## Core Workflow and CLI Patterns

The primary interface for Deblur is the `workflow` subcommand. It handles the end-to-end process from raw sequences to filtered BIOM tables.

### Basic Execution
The most common usage involves providing a demultiplexed FASTA file and a fixed trim length.
```bash
deblur workflow --seqs-fp all_samples.fna --output-dir output_dir -t 150
```

### Key Parameters
- `-t <int>`: **Trim Length (Required).** Deblur requires all sequences to be the same length. Reads shorter than this value are discarded. Use `-t -1` only if sequences are already manually trimmed to a uniform length.
- `-O <int>`: **Threads.** Specify the number of CPU cores to use for parallel processing (default is 1).
- `--min-reads <int>`: **Abundance Filtering.** Removes sOTUs with a total count across all samples lower than this threshold (default is 10). Set to `0` to disable this filter.
- `--pos-ref-fp <path>`: Path to a positive filtering database (default is 16S).
- `--neg-ref-fp <path>`: Path to a negative filtering database (default is PhiX and adapter sequences).

## Input Requirements
- **Demultiplexing**: Data must be demultiplexed before running Deblur. If starting from raw FASTQ files with barcodes, use `split_libraries_fastq.py` (from QIIME 1) or equivalent tools first.
- **Format**: Accepts FASTA or FASTQ files (can be gzipped). Input can be a single demultiplexed file or a directory containing one file per sample.

## Interpreting Outputs
The output directory contains several key files:
- `all.biom` / `all.seqs.fa`: The complete set of sOTUs generated after denoising and negative filtering.
- `reference-hit.biom` / `reference-hit.seqs.fa`: sOTUs that matched the positive reference database (e.g., known 16S sequences). This is typically the table used for downstream analysis.
- `reference-non-hit.biom`: sOTUs that did not match the positive reference but passed negative filtering.

## Expert Tips and Best Practices
- **Sequence Length Consistency**: Because Deblur cannot associate sequences of different lengths, the choice of `-t` is critical. Choosing a length that is too long will discard many reads; choosing one too short may lose taxonomic resolution.
- **Quality Pre-filtering**: While Deblur handles error correction, pre-filtering low-quality reads (e.g., using a Q-score threshold of 19-20 during demultiplexing) improves performance and results.
- **Non-16S Data**: To use Deblur for ITS or 18S data, you must provide specific reference databases using `--pos-ref-fp`. Without these, the `reference-hit.biom` will be empty or incorrect.
- **Memory Management**: For very large datasets, ensure the system has sufficient RAM, as SortMeRNA (used for filtering) can be memory-intensive depending on the reference database size.



## Subcommands

| Command | Description |
|---------|-------------|
| deblur build-biom-table | Generate a BIOM table from a directory of chimera removed fasta files |
| deblur build-db-index | Preapare the artifacts database |
| deblur deblur-seqs | Clean read errors from Illumina reads |
| deblur dereplicate | Dereplicate FASTA sequences. |
| deblur multiple-seq-alignment | Multiple sequence alignment |
| deblur remove-artifacts | Filter artifacts from input sequences based on database(s) provided with the   --ref-fp (raw FASTA file) or --ref-db-fp (indexed database) options. |
| deblur remove-chimeras-denovo | Remove chimeras de novo using UCHIME (VSEARCH implementation) |
| deblur trim | Trim FASTA sequences |
| deblur workflow | Launch deblur workflow |

## Reference documentation
- [Deblur GitHub Repository](./references/github_com_biocore_deblur.md)
- [Bioconda Deblur Package](./references/anaconda_org_channels_bioconda_packages_deblur_overview.md)