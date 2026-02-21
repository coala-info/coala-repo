---
name: hhsuite
description: HH-suite3 is a specialized bioinformatics toolkit designed for sensitive protein sequence analysis using pairwise alignment of Hidden Markov Models (HMMs).
homepage: https://github.com/soedinglab/hh-suite
---

# hhsuite

## Overview
HH-suite3 is a specialized bioinformatics toolkit designed for sensitive protein sequence analysis using pairwise alignment of Hidden Markov Models (HMMs). Unlike traditional tools like BLAST that compare sequences to sequences or profiles, HH-suite compares HMMs to HMMs, allowing for the detection of extremely distant evolutionary relationships (remote homology). It is primarily used for generating high-quality multiple sequence alignments (MSAs), identifying structural templates for protein modeling, and annotating protein functions where sequence identity is low.

## Core CLI Usage Patterns

### HHblits: Iterative Sequence Searching
`hhblits` is the primary tool for searching databases like Uniclust30 to build an MSA or find homologs.

*   **Single search iteration:**
    `hhblits -i query.fasta -o results.hhr -n 1 -d /path/to/database_basename`
*   **Generate an alignment (A3M format):**
    `hhblits -i query.fasta -o results.hhr -oa3m output.a3m -d /path/to/database_basename`
*   **High-sensitivity search (multiple iterations):**
    `hhblits -i query.fasta -o results.hhr -n 3 -e 1e-3 -d /path/to/database_basename`

### HHsearch: Database Searching with HMMs
`hhsearch` is used to search a database of HMMs (e.g., PDB70) using a query MSA or HMM. It is slower but often more sensitive than `hhblits` for specific structural searches.

*   **Search with an MSA:**
    `hhsearch -i query.a3m -d /path/to/database_basename -o results.hhr`

### HHM-HMM Alignment and Manipulation
*   **Build an HMM from an alignment:**
    `hhmake -i query.a3m -o query.hhm`
*   **Align two specific MSAs/HMMs:**
    `hhalign -i query.a3m -t template.a3m -o alignment.hhr`
*   **Filter an MSA for diversity/quality:**
    `hhfilter -i input.a3m -o filtered.a3m -id 90 -cov 50`
    *(Filters to 90% maximum pairwise identity and 50% minimum coverage)*

## Expert Tips and Best Practices

*   **Database Basenames:** When specifying the database (`-d`), do not include file extensions like `.ffdata` or `.ffindex`. Use the common prefix (e.g., use `-d pdb70` if the files are `pdb70_hhm.ffdata`, etc.).
*   **Performance:** If running on modern hardware, ensure you use the AVX2-compiled binaries, which are roughly 2x faster than SSE2 versions.
*   **Memory Management:** Large databases like BFD or Uniclust30 require significant RAM. If you encounter segmentation faults, check system memory limits (`ulimit -s unlimited`).
*   **Secondary Structure:** For maximum sensitivity in structural detection, add predicted secondary structure to your query using `addss.pl` before running `hhsearch`.
*   **Alignment Formats:** HH-suite prefers A3M format, which is a condensed version of A2M. Use the `reformat.pl` script to convert between FASTA, Stockholm, and A3M formats.
*   **CPU Threads:** Use the `-cpu N` flag to specify the number of cores. Note that only self-compiled versions support MPI for cluster-wide distribution.

## Utility Scripts
The suite includes several Perl and Python utilities for data preparation:
*   `reformat.pl`: Convert between alignment formats (e.g., `reformat.pl a3m fas input.a3m output.fas`).
*   `hhsuitedb.py`: Used for building customized HH-suite databases from HMMs or A3M files.
*   `cif2fasta.py`: Extracts protein sequences from PDB/mmCIF files.
*   `renumberpdb.pl`: Matches PDB residue numbering to the input sequence.

## Reference documentation
- [HH-suite GitHub Repository](./references/github_com_soedinglab_hh-suite.md)
- [HH-suite Wiki and User Guide](./references/github_com_soedinglab_hh-suite_wiki.md)