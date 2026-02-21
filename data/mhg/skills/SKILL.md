---
name: mhg
description: MHG (Maximal Homologous Groups) is a graph-based bioinformatics tool designed to merge and partition homologous groups across multiple genomes without the need for prior gene annotations.
homepage: https://github.com/NakhlehLab/Maximal-Homologous-Groups
---

# mhg

## Overview

MHG (Maximal Homologous Groups) is a graph-based bioinformatics tool designed to merge and partition homologous groups across multiple genomes without the need for prior gene annotations. It processes raw nucleotide sequences to identify homologous blocks where each group represents a single evolutionary history (a single tree) and is free from internal rearrangements. The tool is particularly useful for researchers working with non-model organisms or sets of genomes where high-quality annotations are unavailable.

## Installation and Environment

The most reliable way to install MHG is via Conda to manage its dependencies (NetworkX, Biopython, BEDtools, and BLAST+).

```bash
conda create --name mhg python=3.7
conda activate mhg
conda install -c bioconda mhg
```

## Command Line Usage

MHG provides three primary executables depending on the stage of your analysis:
1. `MHG`: The integrated pipeline (Database creation + Partitioning).
2. `genome-to-blast-db`: Only performs BLASTn database creation and query generation.
3. `MHG-partition`: Only performs the graph-based partitioning from existing BLASTn XML queries.

### Integrated Workflow (Recommended)
To run the full pipeline from a directory of FASTA genomes:

```bash
MHG -g <genome_directory> -o <output_file.txt> -t 0.95 -T <threads>
```

### Modular Workflow
If you already have BLASTn results or want to run steps separately:

**Step 1: Generate BLASTn Queries**
```bash
genome-to-blast-db -g genomes/ -db ./blast_db -q ./queries -T 8
```

**Step 2: Partition Homologous Groups**
```bash
MHG-partition -q ./queries -o mhg_results.txt -t 0.95
```

## Parameter Optimization

| Argument | Description | Best Practice |
| :--- | :--- | :--- |
| `-t`, `--threshold` | Bitscore threshold for homology | Default is 0.95 (95% of max bitscore). Increase for higher stringency. |
| `-w`, `--word_size` | BLASTn word size | Default is 28. Lower values increase sensitivity but significantly slow down processing. |
| `-T`, `--thread` | CPU threads | Increase this to speed up the `genome-to-blast-db` phase. |
| `-o`, `--output` | Output filename | The result is a text file where each line is one MHG. |

## Interpreting Output

The output file contains one Maximal Homologous Group per line. Each block within a group follows this format:
`((sequence_accession, (union_start, union_end)), (homology_start, homology_end), direction)`

- **sequence_accession**: The ID of the contig/chromosome.
- **homology_start/end**: The actual nucleotide indices of the homologous subsequence.
- **direction**: `+` (forward) or `-` (reverse complement) relative to other blocks in the same group.
- **union_start/end**: Internal graph traversal indices (can generally be ignored for downstream biological analysis).

## Expert Tips

- **Memory Management**: For very large genome sets, the alignment graph construction can be memory-intensive. Ensure your environment has sufficient RAM or process genomes in smaller, related batches.
- **Input Formatting**: Ensure all genome files in the input directory are in standard FASTA format. The tool uses the filenames and internal headers for accession tracking.
- **Threshold Tuning**: If your output contains too many small, fragmented groups, consider slightly lowering the `-t` threshold. If groups seem to merge unrelated regions, increase it.

## Reference documentation
- [MHG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mhg_overview.md)
- [MHG GitHub Repository and Usage](./references/github_com_NakhlehLab_Maximal-Homologous-Groups.md)