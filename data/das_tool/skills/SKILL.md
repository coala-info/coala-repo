---
name: das_tool
description: DAS Tool recovers high-quality metagenome-assembled genomes by aggregating and scoring binning results from multiple individual tools. Use when user asks to refine metagenomic bins, aggregate contigs into complete sets, or resolve redundancies among different binning predictions.
homepage: https://github.com/cmks/DAS_Tool
metadata:
  docker_image: "biocontainers/dascrubber:v020160601-2-deb_cv1"
---

# das_tool

## Overview
DAS Tool (Dereplication, Aggregation, and Scoring) is an automated method used to recover high-quality genomes from metagenomes. It works by taking the predictions from a flexible number of individual binning tools and applying a scoring strategy to select the best bins or aggregate contigs into more complete sets. By leveraging single-copy gene (SCG) identification, it resolves redundancies and improves the overall completeness and purity of the final bin set compared to any single input method.

## Usage Instructions

### Basic Command Structure
The core execution requires a list of binning results, the original assembly contigs, and an output prefix.

```bash
DAS_Tool -i <bin_table_1>,<bin_table_2> -l <label_1>,<label_2> -c <contigs.fasta> -o <output_prefix>
```

### Input Requirements
- **Bin Tables (`-i`)**: Tab-separated files (TSV) with two columns: `Contig_ID` and `Bin_ID`. Multiple files must be comma-separated.
- **Labels (`-l`)**: A comma-separated list of names corresponding to the input bin tables.
- **Contigs (`-c`)**: The assembly file in FASTA format used to generate the bins.

### Common CLI Patterns

**Standard Refinement with FASTA Export**
To generate the refined bins as individual FASTA files (essential for downstream analysis like CheckM or GTDB-Tk), use the `--write_bins` flag.
```bash
DAS_Tool -i binner1.tsv,binner2.tsv -l b1,b2 -c assembly.fa -o refined_output --write_bins
```

**Optimizing Performance for Large Datasets**
- **Search Engine**: Use `--search_engine diamond` (default) for speed. Use `blastp` only if high sensitivity is required for small datasets.
- **Threads**: Increase performance using `-t` (e.g., `-t 16`).
- **Skip Gene Prediction**: If you have already run Prodigal, provide the protein file with `-p` to skip the internal gene prediction step.
```bash
DAS_Tool -i b1.tsv,b2.tsv -l b1,b2 -c assembly.fa -p predicted_proteins.faa -o refined_output -t 16
```

**Adjusting Stringency**
- **Score Threshold**: The default is `0.5`. Increase this (e.g., `--score_threshold 0.7`) to be more conservative, selecting only very high-quality bins.
- **Penalties**: Adjust `--duplicate_penalty` (default 0.6) or `--megabin_penalty` (default 0.5) only if you have specific domain knowledge regarding the expected genome sizes or redundancy.

### Output Files
- `*_DASTool_summary.tsv`: Quality and completeness estimates for the final bins.
- `*_DASTool_contigs2bin.tsv`: The final mapping of contigs to refined bins.
- `DASTool_bins/`: Directory containing bin FASTA files (if `--write_bins` is used).

## Expert Tips
- **Input Consistency**: Ensure that the Contig IDs in your binning TSV files exactly match the headers in your FASTA assembly file.
- **Database Setup**: On first use or in new environments, ensure the SCG database is unzipped in the `db/` directory or specify its location using `--dbDirectory`.
- **Memory Management**: For very large metagenomes, the DIAMOND search step can be memory-intensive. Ensure your environment has at least 64GB-128GB of RAM for complex samples.
- **Unbinned Contigs**: Use `--write_unbinned` if you need to track which sequences were rejected by the refinement process for further manual inspection.

## Reference documentation
- [DAS Tool GitHub Repository](./references/github_com_cmks_DAS_Tool.md)
- [Bioconda das_tool Overview](./references/anaconda_org_channels_bioconda_packages_das_tool_overview.md)