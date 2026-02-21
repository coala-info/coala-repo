---
name: bindashtree
description: bindashtree is a high-performance bioinformatics tool designed for building phylogenetic trees from microbial genomes.
homepage: https://github.com/jianshu93/bindashtree
---

# bindashtree

## Overview
bindashtree is a high-performance bioinformatics tool designed for building phylogenetic trees from microbial genomes. It leverages Binwise Densified MinHash for distance estimation and Rapid Neighbor-joining for tree construction. By using densified hashing strategies, it achieves speeds over 1000x faster than alternatives, capable of processing 20,000 E. coli genomes in minutes while maintaining high accuracy.

## Installation
The tool can be installed via multiple package managers:
- **Conda**: `conda install -c bioconda bindashtree`
- **Homebrew (macOS)**: `brew install jianshu93/bindashtree/bindashtree`
- **Cargo**: `cargo install bindashtree`

## Command Line Usage

### Input Preparation
bindashtree requires a text file containing the paths to your genome files (FASTA/FNA), with one file path per line. It supports gzipped files (.gz).

```bash
# Create the input list
ls ./genomes/*.fna.gz > genome_list.txt
```

### Basic Tree Construction
To generate a Newick format tree with default settings:

```bash
bindashtree -i genome_list.txt --output_tree phylogeny.nwk
```

### Advanced Configuration and Best Practices

| Option | Description | Best Practice |
|:---|:---|:---|
| `-k, --kmer_size` | K-mer size (default: 16) | Use 16 for most microbial applications. |
| `-s, --sketch_size` | MinHash sketch size (default: 10240) | For highly similar genomes (>99% ANI), ensure a large sketch size (10240+) is used. |
| `-d, --densification` | 0=Optimal, 1=Reverse/Faster | Use `1` for large sketch sizes to improve speed and accuracy. |
| `-t, --threads` | Parallel execution | Scale this to the number of available CPU cores for maximum performance. |
| `--tree` | Tree method: naive, rapidnj, hybrid | `rapidnj` is the default and recommended for large datasets. |

### Generating a Distance Matrix
If you require the raw genomic distances in Phylip format:

```bash
bindashtree -i genome_list.txt --output_matrix distances.phylip --output_tree phylogeny.nwk
```

### High-Performance Example
For a large-scale analysis using 64 threads and the faster densification strategy:

```bash
bindashtree -i name.txt -k 16 -s 10240 -d 1 -t 64 --tree rapidnj --output_tree final_tree.nwk
```

## Reference documentation
- [bindashtree GitHub Repository](./references/github_com_jianshu93_bindashtree.md)
- [bindashtree Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bindashtree_overview.md)