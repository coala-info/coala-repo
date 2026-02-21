---
name: lexicmap
description: LexicMap is a high-performance alignment tool specifically engineered to handle the scale of modern genomic databases.
homepage: https://github.com/shenwei356/LexicMap
---

# lexicmap

## Overview

LexicMap is a high-performance alignment tool specifically engineered to handle the scale of modern genomic databases. Unlike alignment-free tools that only identify matching genomes, LexicMap provides full base-level alignment and positional information. It utilizes a hierarchical index and an improved LexicHash sketching method to maintain high sensitivity while operating with significantly lower memory and time requirements than BLAST or MMseqs2. It is particularly robust for circular queries (plasmids/mtDNA) and fragmented assemblies.

## Installation

Install via Bioconda:
```bash
conda install bioconda::lexicmap
```

## Core Workflows

### 1. Building an Index
Indexing is the first step and can be performed on directories of FASTA/Q files or specific file lists.

*   **From a directory**:
    `lexicmap index -I /path/to/genomes/ -O db.lmi`
*   **From a file list** (one path per line):
    `lexicmap index -S -X genome_list.txt -O db.lmi`

### 2. Searching the Database
Search parameters should be tuned based on the length and expected conservation of the query.

*   **For Short Queries (Genes, 16S, Long Reads)**:
    Use a higher hit limit and strict coverage filters.
    `lexicmap search -d db.lmi query.fasta -o results.tsv --top-n-genomes 10000 --align-min-match-pident 80 --min-qcov-per-genome 70`

*   **For Long/Circular Queries (Plasmids, Viruses)**:
    Set `top-n-genomes` to 0 to return all matches and lower the coverage threshold to account for fragmentation.
    `lexicmap search -d db.lmi query.fasta -o results.tsv --top-n-genomes 0 --min-qcov-per-genome 50 --align-min-match-len 1000`

## Command Line Tips and Best Practices

*   **Memory Management**: If running on a system with limited RAM during search, use the `--gc-interval` flag to trigger garbage collection and reduce memory usage by up to 50%.
*   **Handling Multi-copy Genes**: LexicMap returns all possible matches by default. To see every instance of a gene within a single genome, ensure you are inspecting the `hsp` and `cls` columns in the TSV output.
*   **Circular Query Coverage**: Use the `qcovGnm` (genome-wide query coverage) metric instead of standard HSP coverage when dealing with circular sequences that might map across assembly gaps or start/end boundaries.
*   **Resuming Tasks**: If an indexing or search task is interrupted, LexicMap provides utility commands to resume or merge partial results.
*   **Merging Results**: For very large queries split across multiple runs, use:
    `lexicmap utils merge-search-results -i search_dir/ -o combined_results.tsv`
*   **Subsequence Extraction**: After identifying hits, you can extract the specific matched regions from the subject genomes using:
    `lexicmap utils subseq -d db.lmi -i search_results.tsv -o matched_regions.fasta`

## Output Format Key
The default TSV output includes:
*   `qcovGnm`: Total coverage of the query sequence by all HSPs in a genome.
*   `qcovHSP`: Coverage of the query by a single High-scoring Segment Pair.
*   `pident`: Percentage of identical matches.
*   `sstr`: Subject strand (+ or -).

## Reference documentation
- [LexicMap Main Documentation](./references/github_com_shenwei356_LexicMap.md)
- [LexicMap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lexicmap_overview.md)