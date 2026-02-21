---
name: sherpas
description: SHERPAS (Screening Historical Events of Recombination in a Phylogeny via Ancestral Sequences) is a high-throughput bioinformatics tool used to identify recombination patterns in genomic data.
homepage: https://github.com/phylo42/sherpas
---

# sherpas

## Overview

SHERPAS (Screening Historical Events of Recombination in a Phylogeny via Ancestral Sequences) is a high-throughput bioinformatics tool used to identify recombination patterns in genomic data. Unlike traditional methods that rely on computationally expensive sequence alignments, SHERPAS utilizes "phylo-kmers" to map query sequences to a reference tree. This allows for the analysis of thousands of sequences in minutes. It is particularly effective for viral surveillance and classification where query sequences may be diverse or unaligned.

## Core CLI Usage

The primary command for running a recombination analysis is `SHERPAS`.

### Basic Detection Command
```bash
SHERPAS -d <database.rps> -q <queries.fasta> -o <output_directory> -g <groups.csv> -c
```

### Mandatory Parameters
- `-d`: Path to the pre-computed phylo-kmer database (typically a `.rps` file).
- `-q`: The query sequences in FASTA format (unaligned genomes or long reads).
- `-o`: The output directory where results will be stored.
- `-g`: A CSV file associating reference sequence IDs with their respective types or strains.

### Key Options and Flags
- `-c`: Use this flag if the sequences are circular or to handle edge cases in genome completeness.
- `-k`: (During database build) Specifies k-mer size. For most viral models, a value of $k \ge 10$ is recommended.

## Database Construction

If a pre-built database for your specific virus is not available, you must construct one using the included `xpas` binaries.

1.  **Prepare Inputs**:
    - A multiple sequence alignment (MSA) of "pure" (non-recombinant) reference genomes.
    - A Maximum Likelihood (ML) phylogeny built from that alignment (e.g., via PhyML or RAxML).
2.  **Build Command**:
    ```bash
    # For DNA sequences
    lib/xpas/build/xpas-build-dna -a <alignment.fasta> -t <tree.newick> -k 10 -o <output_prefix>
    ```

## Expert Tips and Best Practices

- **Reference Selection**: When building a database, ensure the reference alignment contains only "pure" types. Including known recombinants in the reference set can create misleading evolutionary signals and degrade detection accuracy.
- **Tree Requirements**: Always use Maximum Likelihood reconstruction for the reference tree. Avoid distance-based methods like Neighbor-Joining (NJ), as they do not provide the ancestral state information required for accurate phylo-kmer placement.
- **K-mer Sizing**: While the default in many k-mer tools is $k=8$, SHERPAS performs better on viral genomes with $k=10$ or higher to ensure specificity across the genome.
- **Output Interpretation**:
    - `res-queries.txt`: Contains the detected recombinant regions and their coordinates for each query.
    - `queries-circ.fasta`: Contains the processed query sequences matching the coordinates in the results file.

## Reference documentation
- [sherpas - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sherpas_overview.md)
- [GitHub - phylo42/sherpas](./references/github_com_phylo42_sherpas.md)