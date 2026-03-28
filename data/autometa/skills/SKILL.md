---
name: autometa
description: Autometa is a bioinformatics pipeline that recovers high-quality microbial genomes from complex metagenomes by integrating sequence composition, coverage, and taxonomic information. Use when user asks to bin metagenomic contigs, filter sequences by length, calculate assembly coverage, or identify single-copy marker genes.
homepage: https://github.com/KwanLab/Autometa
---

# autometa

## Overview

Autometa is a specialized bioinformatics pipeline designed to recover high-quality microbial genomes from complex, single shotgun metagenomes. It is particularly effective for host-associated samples where eukaryotic contamination is common. The tool integrates sequence composition (k-mer frequencies), coverage data, and taxonomic information to cluster contigs into discrete "bins" representing individual organisms.

## Core Workflow and CLI Patterns

### 1. Database Configuration
Before running the pipeline, ensure the required markers and NCBI/GTDB databases are configured and updated.

```bash
# Set database paths
autometa-config --section databases --option markers --value /path/to/markers
autometa-config --section databases --option ncbi --value /path/to/ncbi

# Update/Download databases
autometa-update-databases --update-markers
autometa-update-databases --update-ncbi
```

### 2. Pre-processing: Length Filtering
Small contigs often have noisy k-mer frequencies. Filter them to improve binning stability.

```bash
autometa-length-filter \
    --assembly metagenome.fna \
    --cutoff 3000 \
    --output-fasta filtered.fna \
    --output-stats stats.tsv
```
*Tip: If your N50 is very low (e.g., soil samples), consider lowering the cutoff to match the N50, though this increases computational load.*

### 3. Coverage Calculation
Coverage is a critical distinguishing feature for binning. Autometa supports multiple input formats.

```bash
# From BAM alignment
autometa-coverage --assembly filtered.fna --bam alignments.bam --out coverage.tsv

# From SPAdes assembly (extracts coverage from headers)
autometa-coverage --assembly assembly.fna --from-spades --out coverage.tsv
```

### 4. Feature Extraction (ORFs and Markers)
Identify protein-coding regions and single-copy marker genes to guide the clustering process.

```bash
# Call ORFs with Prodigal
autometa-orfs --assembly filtered.fna --output-prots proteins.faa

# Identify markers (Bacteria or Archaea)
autometa-markers --orfs proteins.faa --kingdom bacteria --out markers.tsv
```

### 5. Taxonomic Assignment
Filtering by kingdom (e.g., removing eukaryotic contigs) significantly improves binning purity.

```bash
# Run Diamond BLASTP (Format 6 is required)
diamond blastp --query proteins.faa --db nr.dmnd --outfmt 6 --out blastp.tsv --threads 40

# Assign taxonomy via LCA or Majority Vote
# (Refer to bash-step-by-step-tutorial.md for specific module calls)
```

### 6. Binning and Recruitment
The final stage reduces dimensions and clusters contigs.

```bash
# K-mer counting and embedding
python -m autometa.common.kmers --assembly filtered.fna --size 5 --out kmers.tsv

# Binning (Recursive DBSCAN)
# Use the 'autometa.sh' workflow script for a streamlined execution of the clustering logic.
```

## Expert Tips
- **Large Data Mode**: For datasets with >100,000 contigs, use the `autometa-large-data-mode.sh` workflow to partition the data by taxonomy before clustering.
- **Normalization**: The `ilr` (Isometric Log-Ratio) transformation is the default and recommended method for k-mer frequency normalization.
- **Embedding**: While `bhsne` is the default, `densmap` is often superior for preserving global structure in very large metagenomes.
- **Visualization**: Use the `x_1` and `x_2` coordinates in the `main.tsv` output to plot your bins in R using `ggplot2` to visually inspect cluster separation.



## Subcommands

| Command | Description |
|---------|-------------|
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version.No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |
| autometa | Describe Autometa citation & version. No arguments will list the available autometa commands, docs and code information |

## Reference documentation
- [Bash Step-by-Step Tutorial](./references/autometa_readthedocs_io_en_latest_bash-step-by-step-tutorial.html.md)
- [Bash Workflow Guide](./references/autometa_readthedocs_io_en_latest_bash-workflow.html.md)
- [Database Management](./references/autometa_readthedocs_io_en_latest_databases.html.md)
- [Python API Examples](./references/autometa_readthedocs_io_en_latest_autometa-python-api.html.md)