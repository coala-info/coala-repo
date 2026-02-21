---
name: ragtag
description: RagTag is a suite of tools designed to improve genome assemblies by leveraging homology with reference genomes.
homepage: https://github.com/malonge/RagTag
---

# ragtag

## Overview

RagTag is a suite of tools designed to improve genome assemblies by leveraging homology with reference genomes. It provides a fast and flexible workflow for scaffolding draft assemblies, correcting structural errors (misassemblies), and filling gaps using related sequences. It is an essential tool for researchers looking to elevate the quality of a draft genome by using a closely related, high-quality reference.

## Core Workflows

### 1. Misassembly Correction
Use the `correct` command to identify and fix potential misassemblies in a query genome based on alignments to a reference.

```bash
ragtag.py correct ref.fasta query.fasta
```
*   **Tip**: This should generally be the first step before scaffolding if you suspect structural errors in your draft.

### 2. Genome Scaffolding
The `scaffold` command orders and orients query contigs based on their alignment to a reference genome.

```bash
ragtag.py scaffold ref.fasta query.fasta
```
*   **Multiple References**: If you have multiple reference genomes or maps, scaffold against each one individually into separate output directories, then use the `merge` command.
    ```bash
    ragtag.py scaffold -o out_ref1 ref1.fasta query.fasta
    ragtag.py scaffold -o out_ref2 ref2.fasta query.fasta
    ```

### 3. Merging Scaffolds
Combine multiple scaffolding results (AGP files) into a single consensus assembly.

```bash
ragtag.py merge query.fasta out_1/*.agp out_2/*.agp
```
*   **Hi-C Integration**: You can resolve conflicts between different maps using Hi-C data by providing a BAM file.
    ```bash
    ragtag.py merge -b hic.bam query.fasta out_*/*.agp
    ```

### 4. Assembly Patching
Use the `patch` command to join contigs and fill gaps in a target assembly using sequences from a query assembly.

```bash
ragtag.py patch target.fa query.fa
```

## Expert Tips and Best Practices

*   **Alignment Tools**: RagTag supports `minimap2` (default), `unimap`, and `nucmer`. Ensure these are in your PATH. You can pass specific parameters to the aligner using flags like `--mm2-params`.
*   **Output Files**: RagTag generates several useful files in the output directory:
    *   `ragtag.scaffold.fasta`: The final scaffolded assembly.
    *   `ragtag.scaffold.agp`: The AGP file describing the organization of the scaffolds.
    *   `ragtag.scaffold.stats`: Summary statistics of the scaffolding process.
*   **Naming Conventions**: Use the `-o` flag to keep your workspace organized, especially when running multiple iterations or comparing different reference genomes.
*   **GFF Updates**: If you have functional annotations, use the `update_gff` utility (found in the wiki/utilities) to lift over coordinates to your new scaffolds.

## Reference documentation
- [RagTag GitHub README](./references/github_com_malonge_RagTag.md)
- [RagTag Wiki Home](./references/github_com_malonge_RagTag_wiki.md)