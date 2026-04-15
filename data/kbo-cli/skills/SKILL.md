---
name: kbo-cli
description: kbo-cli is a bioinformatics tool for fast, approximate local alignment and sequence comparison using the Spectral Burrows-Wheeler Transform. Use when user asks to identify genomic variants, locate gene sequences, or map query sequences to a reference genome.
homepage: https://docs.rs/kbo
metadata:
  docker_image: "quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0"
---

# kbo-cli

## Overview

kbo-cli is a specialized bioinformatics tool designed for fast, approximate local alignment. It leverages the Spectral Burrows-Wheeler Transform (SBWT) to convert matching statistics into character representations of alignments. It is particularly effective for comparing assembly contigs against reference genomes, identifying gene locations in large datasets, and generating VCF files for genomic variations without the overhead of traditional full-alignment algorithms.

## Core Workflows

### Variant Calling (`kbo call`)
Use this command to identify single and multi-base substitutions, insertions, and deletions. It is the primary tool for generating VCF files.

*   **Basic Usage**:
    ```bash
    kbo call --reference reference.fna query.fasta > variants.vcf
    ```
*   **Expert Tip**: Adjust `--max-error-prob` (default is often $10^{-7}$) to control the sensitivity of the derandomization process. Higher values allow more noise; lower values increase stringency.
*   **VCF Output**: Produces VCF v4.4. Note that the `QUAL` and `FILTER` columns are typically placeholders (`.`) as kbo uses a deterministic matching statistic rather than a probabilistic mapping quality.

### Finding Gene Locations (`kbo find`)
Use this to locate specific sequences (like a gene database) within a larger genome. It functions similarly to BLAST but uses k-mer matching.

*   **Basic Usage**:
    ```bash
    kbo find --reference genes.fasta genome.fna
    ```
*   **Detailed Output**: Use the `--detailed` flag to include the specific contig names from the reference file in the output table.
*   **Gap Management**: Use `--max-gap-len` (e.g., `--max-gap-len 100`) to define the maximum distance between k-mer matches that can be merged into a single alignment block.

### Sequence Mapping (`kbo map`)
Use this to project a query sequence onto a reference coordinate system.

*   **Basic Usage**:
    ```bash
    kbo map --reference reference.fna query.fasta > alignment.txt
    ```
*   **Output**: Returns the reference sequence where non-matching bases are masked with `-`.
*   **Configuration**: Ensure `build_select` is enabled in the underlying index (automatic in CLI) to support the mapping coordinate lookups.

## Parameter Tuning

| Parameter | Command | Description |
| :--- | :--- | :--- |
| `-k` | `build`, `find` | k-mer size. Larger `k` increases specificity but reduces sensitivity to highly divergent sequences. |
| `--max-gap-len` | `find` | Maximum gap size (in bases) allowed when merging local matches. |
| `--max-error-prob`| `call`, `map` | Probability threshold for considering a match "random noise." |
| `--add-revcomp` | `build` | Includes reverse complements in the index. Essential for double-stranded DNA queries. |

## Best Practices

*   **Input Formats**: kbo-cli natively supports FASTA and FASTQ. It can read DEFLATE-compressed files (e.g., `.gz`) automatically.
*   **Indexing**: While kbo can run directly on FASTA files, you can use `kbo build` to create a prebuilt index for `kbo find` tasks involving repetitive queries against the same reference.
*   **Memory Management**: For large genomes, use the `--mem-gb` flag during indexing to limit RAM usage. The tool defaults to 4GB.
*   **Threading**: Use `--num-threads` to parallelize the SBWT construction phase, which is the most computationally intensive part of the workflow.



## Subcommands

| Command | Description |
|---------|-------------|
| kbo | kbo |
| kbo-cli kbo build | Build a k-mer index |
| kbo-cli kbo call | Call variants using k-mer based approach. |
| kbo-cli kbo find | Finds sequences in query files based on a reference or index. |
| kbo-cli kbo map | Map sequence data against a reference. |

## Reference documentation
- [Crate kbo Overview](./references/docs_rs_kbo_latest_kbo.md)
- [Function: kbo find](./references/docs_rs_kbo_latest_kbo_fn.find.html.md)
- [Function: kbo call](./references/docs_rs_kbo_latest_kbo_fn.call.html.md)
- [Function: kbo map](./references/docs_rs_kbo_latest_kbo_fn.map.html.md)
- [Build Options](./references/docs_rs_kbo_latest_kbo_struct.BuildOpts.html.md)