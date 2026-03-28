---
name: hhsuite
description: HH-suite is a bioinformatics toolkit that uses profile Hidden Markov Models to detect distant evolutionary relationships between protein sequences. Use when user asks to find remote homologs, generate multiple sequence alignments, build protein HMMs, or search protein databases like Pfam and PDB.
homepage: https://github.com/soedinglab/hh-suite
---

# hhsuite

## Overview
The HH-suite is a specialized bioinformatics toolkit designed for detecting distant evolutionary relationships (homology) between proteins. Unlike standard BLAST which compares single sequences, HH-suite uses profile Hidden Markov Models (HMMs) to represent protein families. By aligning these HMMs against each other, it can identify homologous proteins even when sequence identity is very low (the "twilight zone"). This is particularly useful for protein function annotation, secondary structure prediction, and identifying templates for 3D structure modeling.

## Core Workflows

### Iterative Sequence Searching (HHblits)
HHblits is the fastest and most common tool for generating high-quality Multiple Sequence Alignments (MSAs) and finding remote homologs.

*   **Single iteration search**:
    `hhblits -i query.fasta -d <database_basename> -o results.hhr -n 1`
*   **Generate an alignment (A3M format)**:
    `hhblits -i query.fasta -d <database_basename> -oa3m output.a3m`
*   **High-sensitivity search (multiple iterations)**:
    `hhblits -i query.fasta -d <database_basename> -n 3 -e 1e-3`

### Database Searching (HHsearch)
Use HHsearch when you already have a query MSA or HMM and want to search it against a database of HMMs (like Pfam or PDB70).

*   **Standard search**:
    `hhsearch -i query.a3m -d <database_basename> -o results.hhr`
*   **Search with secondary structure scoring**:
    `hhsearch -i query.a3m -d <database_basename> -ssm 2 -ssw 0.11`

### Building and Manipulating HMMs
*   **Build an HMM from an alignment**:
    `hhmake -i input.a3m -o output.hhm`
*   **Align two specific MSAs/HMMs**:
    `hhalign -i query.a3m -t template.a3m -o alignment.hhr`
*   **Filter an MSA for diversity**:
    `hhfilter -i input.a3m -o filtered.a3m -id 90 -cov 50`

## Expert Tips & Best Practices

### Performance Optimization
*   **CPU Architecture**: HH-suite3 is optimized for AVX2 and SSE2. Ensure you use the AVX2 build if your CPU supports it for a ~2x speed increase.
*   **Parallelization**: Use the `-cpu <N>` flag to specify the number of threads. For large-scale searches, HH-suite supports MPI for distribution across cluster nodes.
*   **Memory Management**: Searching large databases like BFD requires significant RAM. If memory is limited, ensure you are using the compressed `.ffdata` and `.ffindex` database formats.

### Alignment Formats
*   **A3M Format**: This is the native format for HH-suite. It stores the master sequence in uppercase and insertions relative to the master in lowercase, with deletions marked as dots. It is much more compact than standard FASTA alignments.
*   **Reformatting**: Use the included `reformat.pl` script to convert between formats:
    `reformat.pl a3m fas input.a3m output.fas`

### Interpreting Results
*   **Probability**: The most reliable metric in HH-suite. A probability > 95% usually indicates a true homologous relationship.
*   **E-value**: Indicates the number of false positives expected at this score.
*   **Neff**: (Number of effective sequences) Check this value in the `.hhr` header. A low Neff (< 3.0) suggests the input alignment is not diverse enough, which may reduce search sensitivity.



## Subcommands

| Command | Description |
|---------|-------------|
| hhalign | Align a query alignment/HMM to a template alignment/HMM by HMM-HMM alignment |
| hhblits | HMM-HMM-based lightning-fast iterative sequence search HHblits is a sensitive, general-purpose, iterative sequence search tool that represents both query and database sequences by HMMs. You can search HHblits databases starting with a single query sequence, a multiple sequence alignment (MSA), or an HMM. HHblits prints out a ranked list of database HMMs/MSAs and can also generate an MSA by merging the significant database HMMs/MSAs onto the query MSA. |
| hhfilter | Filter an alignment by maximum pairwise sequence identity, minimum coverage, minimum sequence identity, or score per column to the first (seed) sequence. |
| hhmake | Build an HMM from an input alignment in A2M, A3M, or FASTA format, or convert between HMMER format (.hmm) and HHsearch format (.hhm). |
| hhsearch | Search a database of HMMs with a query alignment or query HMM |
| reformat.pl | Read a multiple alignment in one format and write it in another format |

## Reference documentation
- [HH-suite GitHub Repository](./references/github_com_soedinglab_hh-suite.md)
- [HH-suite User Guide](./references/github_com_soedinglab_hh-suite_wiki.md)
- [HH-suite3 Research Paper (BMC Bioinformatics)](./references/link_springer_com_article_10.1186_s12859-019-3019-7.md)