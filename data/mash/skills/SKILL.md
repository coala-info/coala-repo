---
name: mash
description: Mash estimates evolutionary distances between genomes and metagenomes by using the MinHash dimensionality-reduction technique to compare sequence sketches. Use when user asks to sketch sequences, estimate Mash distances, calculate Average Nucleotide Identity, screen metagenomes for containment, or generate distance matrices for large-scale clustering.
homepage: https://github.com/marbl/Mash
metadata:
  docker_image: "quay.io/biocontainers/mash:2.3--hb105d93_10"
---

# mash

## Overview

Mash is a specialized bioinformatics tool designed to estimate the evolutionary distance between genomes and metagenomes with high efficiency. By applying the MinHash dimensionality-reduction technique, Mash converts large sequence files into compact "sketches." These sketches can be compared in a fraction of the time required for traditional alignment-based methods, providing estimates of the Jaccard index and the Mash distance (which correlates with Average Nucleotide Identity, or ANI).

## Core CLI Patterns

### Sketching Sequences
The `sketch` command is the first step in most workflows. It reduces a fasta/fastq file into a `.msh` file.

*   **Basic Sketch**: `mash sketch genome.fasta`
*   **Specify Sketch Size**: Use `-s` to define the number of min-hashes. Larger sketches (e.g., 10,000) provide better resolution for closely related species.
    `mash sketch -s 10000 genome.fasta`
*   **Specify K-mer Size**: Use `-k` (default is 21).
    `mash sketch -k 31 genome.fasta`
*   **Sketching Reads**: When sketching raw reads, use `-m` to filter out unique k-mers that are likely sequencing errors.
    `mash sketch -m 2 reads.fastq`

### Estimating Distances
The `dist` command compares two sketches or a sketch and a sequence file.

*   **Compare Two Sketches**: `mash dist ref.msh query.msh`
*   **Compare Reference to Multiple Queries**: `mash dist ref.msh queries.fasta`
*   **Output Table**: The output provides: [Reference-ID, Query-ID, Mash-distance, P-value, Matching-hashes].
*   **Filtering Results**: Use `-d` to set a maximum distance threshold or `-v` for a maximum p-value.
    `mash dist -d 0.05 ref.msh queries.fasta`

### Containment Screening
The `screen` command is used to determine if a reference (like a specific genome) is contained within a large, unassembled mixture (like a metagenomic sample).

*   **Screen Metagenome**: `mash screen ref.msh metagenome_reads.fastq`
*   **Sorting by Identity**: Pipe the output to `sort -gr` to see the highest containment matches first.
    `mash screen ref.msh reads.fastq | sort -gr`

### Large-Scale Clustering
For all-vs-all comparisons, `triangle` is more efficient for generating distance matrices.

*   **Distance Matrix**: `mash triangle list_of_files.txt > tree.dist`
*   **Edge Output**: Use `-E` to produce a three-column edge list (ID1, ID2, Distance), which is useful for network analysis.
    `mash triangle -E input_dir/ > edges.txt`

## Expert Tips

*   **Individual Sequences**: When working with multi-fasta files (like a database of many genomes), use the `-i` flag with `sketch` to create a separate sketch for every sequence in the file rather than one combined sketch.
*   **Multiplicity**: Use `-M` during sketching to store the abundance of k-mers, which can be useful for certain downstream statistical analyses.
*   **P-value Significance**: Always check the p-value in `dist` output. A distance of 0.01 is only meaningful if the p-value is very low (e.g., < 1e-10), indicating the match is not due to random k-mer collisions.
*   **Memory Efficiency**: Mash is dependency-free and highly parallelized. Use `-p` to specify the number of threads for large-scale sketching or distance calculations.



## Subcommands

| Command | Description |
|---------|-------------|
| mash dist | Estimate the distance of each query sequence to the reference. Both the reference and queries can be fasta or fastq, gzipped or not, or Mash sketch files (.msh) with matching k-mer sizes. Query files can also be files of file names (see -l). Whole files are compared by default (see -i). The output fields are [reference-ID, query-ID, distance, p-value, shared-hashes]. |
| mash info | Display information about sketch files. |
| mash paste | Create a single sketch file from multiple sketch files. |
| mash screen | Determine how well query sequences are contained within a mixture of sequences. The queries must be formatted as a single Mash sketch file (.msh), created with the `mash sketch` command. The <mixture> files can be contigs or reads, in fasta or fastq, gzipped or not, and "-" can be given for <mixture> to read from standard input. The <mixture> sequences are assumed to be nucleotides, and will be 6-frame translated if the <queries> are amino acids. The output fields are [identity, shared-hashes, median-multiplicity, p-value, query-ID, query-comment], where median-multiplicity is computed for shared hashes, based on the number of observations of those hashes within the mixture. |
| mash sketch | Create a sketch file, which is a reduced representation of a sequence or set of sequences (based on min-hashes) that can be used for fast distance estimations. Inputs can be fasta or fastq files (gzipped or not), and "-" can be given to read from standard input. Input files can also be files of file names (see -l). For output, one sketch file will be generated, but it can have multiple sketches within it, divided by sequences or files (see -i). By default, the output file name will be the first input file with a '.msh' extension, or 'stdin.msh' if standard input is used (see -o). |
| mash triangle | Estimate the distance of each input sequence to every other input sequence. Outputs a lower-triangular distance matrix in relaxed Phylip format. The input sequences can be fasta or fastq, gzipped or not, or Mash sketch files (.msh) with matching k-mer sizes. Input files can also be files of file names (see -l). If more than one input file is provided, whole files are compared by default (see -i). |
| mash_bounds | Mash distance and Screen distance calculations based on sketch size and distance thresholds. |
| mash_taxscreen | Create Kraken-style taxonomic report based on how well query sequences are contained within a pool of sequences. The queries must be formatted as a single Mash sketch file (.msh), created with the `mash sketch` command. The <pool> files can be contigs or reads, in fasta or fastq, gzipped or not, and "-" can be given for <pool> to read from standard input. The <pool> sequences are assumed to be nucleotides, and will be 6-frame translated if the <queries> are amino acids. The output fields are [total percent of hashes, number of contained hashes in the clade, number of contained hashes in the taxon, total number of hashes in the clade, total number of hashes in the taxon, rank, taxonomy ID, padded name]. |

## Reference documentation

- [Mash GitHub Repository](./references/github_com_marbl_Mash.md)
- [Mash Issues and Command Usage](./references/github_com_marbl_Mash_issues.md)
- [Mash Commit History and Feature Updates](./references/github_com_marbl_Mash_commits_master.md)