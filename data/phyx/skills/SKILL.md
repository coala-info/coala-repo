---
name: phyx
description: Phyx is a collection of command-line utilities designed for efficient phylogenetic data manipulation and workflow construction. Use when user asks to concatenate alignments, reroot or prune trees, convert sequence formats, or clean alignments by removing ambiguous data.
homepage: https://github.com/FePhyFoFum/phyx
metadata:
  docker_image: "quay.io/biocontainers/phyx:1.1--hc0837bd_5"
---

# phyx

## Overview

Phyx is a collection of specialized C++ utilities designed for high-efficiency phylogenetic workflows. It follows the Unix philosophy of "one tool for one task," allowing complex bioinformatics pipelines to be constructed by piping data between programs. It is particularly useful for researchers needing to manipulate large sets of Newick trees or sequence alignments without the overhead of heavy graphical interfaces.

## Core CLI Patterns

### Sequence Manipulation
Phyx tools typically expect Fasta format by default but can handle others via converters.
- **Concatenate alignments**: `pxcat -s seq1.fa seq2.fa -p partitions.txt -o combined.fa`
- **Clean alignments**: Remove sites with high missing data using `pxclsq`.
- **Translate sequences**: `pxtlate -i dna.fa -f 1 > protein.fa` (where `-f` specifies the reading frame).
- **Format Conversion**: Use `pxs2fa`, `pxs2nex`, or `pxs2phy` to move between Fasta, Nexus, and Phylip.

### Tree Processing
Phyx is highly effective for rapid tree topology edits.
- **Rerooting**: `pxrr -t tree.tre -outgroup taxon_A,taxon_B`
- **Pruning**: `pxrmt -t tree.tre -n taxon_to_remove`
- **Subtree Extraction**: `pxtrt -t tree.tre -m "taxon_A,taxon_B"` extracts the induced subtree for the specified taxa.
- **Support Filtering**: `pxcolt -t tree.tre -c 70` collapses nodes with bootstrap support below 70.

### Piping and Composition
The power of phyx lies in combining tools. For example, to take a tree, reroot it, and then convert it to Nexus format in one line:
`pxrr -t input.tre -o outgroup_name | pxt2nex > final_tree.nex`

## Expert Tips

- **Line Endings**: Phyx requires Unix line endings (`\n`). If your files were created on Windows, run `dos2unix` on them before processing to avoid truncated results or crashes.
- **Illegal Characters**: Nexus and Newick formats are sensitive to characters like `()[]{}/,;:=*'"+-<>`. If your taxon names contain these, wrap the names in single quotes or use `pxrlt` to relabel them before analysis.
- **Standard Input**: Most phyx programs can read from `stdin` if the input file argument is omitted or replaced with `-`, facilitating long pipe chains.
- **Help Access**: Every tool supports the `-h` flag (e.g., `pxcat -h`) to display specific options and usage examples.



## Subcommands

| Command | Description |
|---------|-------------|
| pxbp | Print out bipartitions found in treefile. Trees are assumed rooted unless the -e argument is provided. This will take a newick- or nexus-formatted tree from a file or STDIN. |
| pxcat | Sequence file concatenation. This will take fasta, fastq, phylip, and nexus sequence formats. Individual files may be of different formats. |
| pxclsq | Clean alignments by removing positions/taxa with too much ambiguous data. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Results are written in fasta format. |
| pxcomp | Sequence compositional homogeneity test. Chi-square test for equivalent character state counts across lineages. This will take fasta, phylip, and nexus formats from a file or STDIN. |
| pxnj | Basic neighbour-joining tree maker. This will take fasta, fastq, phylip, and nexus inputs from a file or STDIN. |
| pxrevcomp | Reverse complement sequences. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Results are written in fasta format. |
| pxrmt | Remove tree tips by label. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format. |
| pxrr | Reroot (or unroot) a tree file and produce a newick. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format. |
| pxs2fa | Convert seqfiles from nexus, phylip, fastq to fasta. Data can be read from a file or STDIN. |
| pxs2nex | Convert seqfiles from nexus, phylip, or fastq to nexus. Can read from STDIN or file. |
| pxs2phy | Convert seqfiles from nexus, phylip, or fastq to phylip. Can read from STDIN or file. |
| pxt2new | Converts a tree file (newick or nexus) to newick format. |
| pxtlate | Translate DNA alignment to amino acids. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. NOTE: assumes sequences are in frame. |
| pxtrt | This will trace a big tree given a taxon list and produce newick. Data can be read from a file or STDIN. |
| pxupgma | Bare bones UPGMA tree generator. Currently only uses uncorrected p-distances. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. |

## Reference documentation
- [github_com_FePhyFoFum_phyx.md](./references/github_com_FePhyFoFum_phyx.md)
- [github_com_FePhyFoFum_phyx_wiki_Program-list.md](./references/github_com_FePhyFoFum_phyx_wiki_Program-list.md)
- [github_com_FePhyFoFum_phyx_wiki_Installation.md](./references/github_com_FePhyFoFum_phyx_wiki_Installation.md)