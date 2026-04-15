---
name: last-align
description: LAST performs high-sensitivity sequence alignment and comparison for large genomes using adaptive scoring parameters. Use when user asks to align sequences, perform genome-to-genome comparisons, conduct translated DNA-to-protein alignments, or train custom substitution matrices.
homepage: https://gitlab.com/mcfrith/last
metadata:
  docker_image: "biocontainers/last-align:v963-2-deb_cv1"
---

# last-align

## Overview
LAST is a versatile suite of tools designed for high-sensitivity sequence alignment. It excels at comparing large genomes and identifying subtle similarities that other aligners might miss. A key strength of LAST is its ability to "train" on specific datasets to learn the optimal substitution matrix and gap penalties, making it highly adaptable to different sequencing technologies and evolutionary distances.

## Core Workflow

The standard LAST pipeline involves three primary steps: indexing, training (optional but recommended), and aligning.

1.  **Index the reference genome:**
    ```bash
    lastdb mydb reference.fasta
    ```
    *Tip: Use `-u` to specify a seeding scheme (e.g., `-u NEAR` for closely related sequences).*

2.  **Train the aligner on your data:**
    ```bash
    last-train mydb queries.fasta > my_params.train
    ```
    This step calculates the optimal scoring parameters for your specific query-reference pair.

3.  **Perform the alignment:**
    ```bash
    lastal -p my_params.train mydb queries.fasta > alignments.maf
    ```

## Common CLI Patterns

### DNA-versus-Protein (Translated) Alignment
To align DNA queries against a protein database (or vice versa), use the translated alignment features.
```bash
lastal -f BlastTab+ -s 2 -m 500 -k 2 -C 3 db query.fasta
```
*   `-f BlastTab+`: Outputs in a tabular format similar to BLAST.
*   Recent versions (tag 1651+) include the translation frame in the `BlastTab+` output for DNA-to-protein tasks.

### Genome-to-Genome Alignment
For aligning whole genomes, it is often useful to find unique "split" alignments where each part of a query matches one part of the reference.
```bash
lastal --split mydb query.fasta > alignments.maf
```
*   Use `--split` to handle rearrangements and ensure each query base is aligned to its most likely orthologous position.
*   For very large genomes, LAST supports coordinates greater than 2^32 (tag 1638+).

### Format Conversion
LAST typically outputs in MAF (Multiple Alignment Format). Use `maf-convert` to transform this into other common formats:
```bash
maf-convert sam alignments.maf > alignments.sam
maf-convert blasttab alignments.maf > alignments.tab
```

## Expert Tips

*   **E-values:** LAST provides E-values to indicate the significance of alignments. If you are getting too many random matches, increase the threshold using `-e`.
*   **Memory Management:** For large datasets, `lastal` memory usage can be significant. Recent updates have optimized memory allocation for `--split` and high-coordinate alignments.
*   **Bisulfite Mapping:** LAST has specialized support for bisulfite-converted DNA (e.g., for methylation studies). Ensure you consult the specific documentation for the `-u` and `-m` flags tailored for C-to-T conversions.
*   **Dotplots:** Use `last-dotplot` to visualize alignments, which is essential for identifying large-scale genomic inversions or duplications.
    ```bash
    last-dotplot alignments.maf output.png
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| last-dotplot | Draw a dotplot of pair-wise sequence alignments in MAF or tabular format. |
| last-train | Try to find suitable score parameters for aligning the given sequences. |
| lastal | Find and align similar sequences. |
| lastdb | Prepare sequences for subsequent alignment with lastal. |
| maf-convert | Read MAF-format alignments & write them in another format. |

## Reference documentation
- [gitlab_com_mcfrith_last.md](./references/gitlab_com_mcfrith_last.md)
- [gitlab_com_mcfrith_last_-_blob_main_README.rst.md](./references/gitlab_com_mcfrith_last_-_blob_main_README.rst.md)