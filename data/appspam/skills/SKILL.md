---
name: appspam
description: App-SpaM performs alignment-free phylogenetic placement of query sequences into a reference tree using filtered spaced word matches. Use when user asks to place sequences into a phylogeny without multiple sequence alignment, estimate distances between genomic sequences, or perform phylogenetic placement on unassembled draft genomes.
homepage: https://github.com/matthiasblanke/App-SpaM/
---


# appspam

## Overview

App-SpaM (Alignment-free Phylogenetic Placement using filtered SPAced word Matches) is a tool designed to place query sequences into a reference tree without the need for a multiple sequence alignment. It utilizes the concept of Filtered Spaced Word Matches (FSWM) to estimate distances or match counts between queries and references. The tool is particularly effective for large-scale genomic data and supports both assembled reference genomes and unassembled draft sequences.

## Core Workflow

To perform a standard phylogenetic placement, provide the reference sequences, the reference tree in Newick format, and the query sequences.

```bash
appspam -s references.fasta -t referencetree.nwk -q query.fasta -o output.jplace
```

### Input Requirements
- **Reference Sequences (`-s`)**: A FASTA file containing the sequences used to build the reference tree.
- **Reference Tree (`-t`)**: A Newick file containing the phylogeny of the reference sequences. The leaf names must match the headers in the reference FASTA.
- **Query Sequences (`-q`)**: A FASTA file containing the sequences (e.g., short reads) to be placed.

## Advanced Usage and Optimization

### Working with Unassembled References
If your reference sequences are not fully assembled (e.g., multiple contigs per species), use the unassembled mode. App-SpaM will group sequences sharing a common prefix.

```bash
appspam -u --delimiter "-" -s draft_refs.fasta -t tree.nwk -q query.fasta
```
*Note: Ensure the sequence names before the delimiter in the FASTA match the leaf names in the Newick tree.*

### Tuning Performance and Accuracy
- **Weight (`-w`)**: Controls the number of match positions in the pattern. Increasing the weight (default 12) speeds up computation but may reduce accuracy on small datasets.
- **Patterns (`-p`)**: Sets the number of patterns used for extraction (default 10). Use fewer patterns for faster runs at the cost of sensitivity.
- **Threads (`--threads`)**: Utilize multiple CPU cores for parallelization.

### Placement Heuristics
Change the assignment mode using the `-g` flag to suit your analysis needs:
- `LCACOUNT` (Default): Uses the Lowest Common Ancestor approach based on match counts.
- `MINDIST`: Places based on the minimum estimated distance.
- `SPAMCOUNT`: Uses the raw number of spaced word matches.
- `APPLES`: Uses a distance-based placement heuristic.

## Expert Tips
- **Output Analysis**: The primary output is a `.jplace` file, which can be visualized using tools like Genesis or iTOL.
- **Diagnostics**: Use `--write-histogram` to generate a histogram of spaced word matches or `--write-scoring` to see the raw pairwise distances between queries and references in `scoring_table.txt`.
- **Memory Management**: For very large reference sets, ensure your system has sufficient RAM, as the tool builds indices for the spaced words.

## Reference documentation
- [App-SpaM GitHub README](./references/github_com_matthiasblanke_App-SpaM.md)
- [App-SpaM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_appspam_overview.md)