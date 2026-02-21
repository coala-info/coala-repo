---
name: krepp
description: `krepp` is a high-performance bioinformatics tool that utilizes k-mer-based maximum likelihood estimation to analyze metagenomic data.
homepage: https://github.com/bo1929/krepp
---

# krepp

## Overview

`krepp` is a high-performance bioinformatics tool that utilizes k-mer-based maximum likelihood estimation to analyze metagenomic data. Unlike traditional alignment-based methods, it provides a rapid way to calculate distances between sequencing reads and reference genomes and to perform phylogenetic placement. The workflow typically involves building a specialized index from reference genomes and a phylogeny, followed by querying reads against that index to generate distance tables or `.jplace` files for downstream evolutionary analysis.

## Core Workflows

### 1. Building a Reference Index
Before querying, you must create an index from your reference genomes. This requires a mapping file and a Newick tree.

```bash
# Basic index construction
krepp index -k 27 -w 35 -h 11 -i input_map.tsv -t tree.nwk -o index_name --num-threads 8
```
*   `-k`: K-mer size.
*   `-w`: Window size for minimizers.
*   `-i`: A TSV file mapping genome IDs to their respective fasta files.
*   `-t`: The backbone phylogenetic tree in Newick format.

### 2. Estimating Distances
To find the distance between query reads and the indexed reference genomes:

```bash
krepp dist -i index_name -q query_reads.fq --num-threads 4 > distances.tsv
```
The output provides a `SEQ_ID`, `REFERENCE_NAME`, and the calculated `DIST`.

### 3. Phylogenetic Placement
To place reads onto the backbone tree provided during indexing:

```bash
# Generate standard jplace (JSON) output
krepp place -i index_name -q query_reads.fq --num-threads 8 > placements.jplace

# Generate human-readable tabular output
krepp place -i index_name -q query_reads.fq --tabular --num-threads 8 > placements.tsv
```

## Expert Tips and Best Practices

*   **Thread Optimization**: Always specify `--num-threads` to match your hardware, as `krepp` is designed to scale across multiple cores during both indexing and querying.
*   **Output Formats**: Use the `--tabular` flag with the `place` command if you need to quickly parse results with standard Unix tools (grep, awk) or R/Python dataframes. Use the default `.jplace` format if you intend to use downstream tools like `gappa` for visualization (e.g., heat trees).
*   **Memory Management**: Indexing large numbers of genomes can be memory-intensive. Ensure your hash size (`-h`) and k-mer parameters are appropriate for your available RAM.
*   **Quick Analysis**: For simple comparisons against a single reference without a full index/tree setup, use the `sketch` and `seek` subcommands.
*   **Handling Ns**: `krepp` typically ignores 'N' bases in query sequences to maintain accuracy in k-mer counting.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_bo1929_krepp.md)
- [Official Wiki and Documentation](./references/github_com_bo1929_krepp_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_krepp_overview.md)