---
name: famli
description: FAMLI identifies and quantifies protein-coding sequences in metagenomic datasets by resolving multi-mapped reads and filtering alignments based on coverage evenness. Use when user asks to align metagenomic reads to a protein database, resolve multi-mapping using likelihood inference, or filter existing alignments to estimate protein abundances.
homepage: https://github.com/FredHutch/FAMLI
---


# famli

## Overview

FAMLI (Functional Analysis of Metagenomes by Likelihood Inference) is a specialized tool designed to improve the precision of protein-coding sequence identification in metagenomic datasets. In shotgun metagenomics, short reads often align equally well to multiple reference proteins (multi-mapping), leading to high false-positive rates. FAMLI addresses this by using an iterative algorithm that weights alignments based on the total depth of coverage and prunes candidates that exhibit highly uneven coverage across the peptide length. It transforms raw alignments into a high-confidence set of protein abundances, typically outputting results in a structured JSON format.

## Core CLI Usage

The `famli` tool is primarily interacted with through two main subcommands: `align` and `filter`.

### The `align` Command
This is the comprehensive wrapper command that handles the end-to-end workflow.
- **Workflow**: Downloads reference databases/input data (if remote) -> Aligns reads using DIAMOND -> Parses alignments -> Resolves multi-mapping -> Computes metrics -> Writes JSON output.
- **Input Support**: Accepts local files, SRA accessions, AWS S3 URIs, or FTP links.

### The `filter` Command
Use this command if you have already performed alignments and need to run the FAMLI likelihood inference algorithm on existing data.
- **Primary Function**: Prunes multi-mapped reads and filters out references with uneven coverage (SD/Mean ratio > 1.0).

## Tool-Specific Best Practices

### Alignment Optimization
FAMLI relies on DIAMOND for amino acid space alignment. For optimal results compatible with FAMLI's filtering logic, use the following DIAMOND parameters:
- `--query-cover 90`: Ensures the read covers most of the reference.
- `--id 80`: Minimum identity threshold.
- `--min-score 20`: Minimum bitscore for consideration.
- `--top 10`: Limits the number of candidate alignments per read to the top 10.

### Filtering Logic & Thresholds
- **Coverage Evenness**: FAMLI filters out any reference sequence where the Standard Deviation of coverage depth divided by the Mean coverage depth is greater than 1.0.
- **Likelihood Scaling**: By default, the tool uses a scale of 0.9. During iterations, any alignment with a likelihood score less than 90% of the maximum likelihood for that specific query is culled.
- **Read Length**: Use the `--min-read-length` flag (introduced in v0.8) to discard very short reads that contribute to noise. The conservative default is 30bp.

### Output Management
- **JSON Output**: The primary output is a JSON file containing reference IDs, abundance metrics, and coverage statistics.
- **Alignment Persistence**: Use the `--output-aln` flag (available in v1.1+) if you need to save the filtered alignment file in addition to the summary statistics.
- **Cloud Integration**: FAMLI can write output directly to AWS S3 buckets if a URI is provided as the output path.

## Common CLI Patterns

**Basic local alignment and filtering:**
```bash
famli align --input sample_reads.fastq.gz --refdb protein_db.dmnd --output results.json
```

**Filtering an existing alignment file:**
```bash
famli filter --input alignments.tab --output filtered_results.json
```

**Processing an SRA dataset with a specific read length cutoff:**
```bash
famli align --input SRR1234567 --refdb protein_db.dmnd --min-read-length 50 --output SRR1234567_famli.json
```

## Reference documentation
- [FAMLI Main Documentation](./references/github_com_FredHutch_FAMLI.md)
- [Version History and Feature Tags](./references/github_com_FredHutch_FAMLI_tags.md)