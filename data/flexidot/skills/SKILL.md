---
name: flexidot
description: FlexiDot is a specialized suite for creating high-quality, ambiguity-aware dotplots to visualize discrete biological sequences.
homepage: https://github.com/flexidot-bio/flexidot
---

# flexidot

## Overview

FlexiDot is a specialized suite for creating high-quality, ambiguity-aware dotplots to visualize discrete biological sequences. It transforms FASTA sequences or alignment data into visual representations that highlight structural features like inversions, repeats, and conserved domains. By supporting both strict k-mer matching and relaxed alignment-based plotting, it accommodates both high-identity consensus sequences and error-prone raw reads.

## Core CLI Usage

### Basic Sequence Comparison
FlexiDot requires at least one input FASTA file and a specified mode.

*   **Self-comparison (Mode 0):** Compare each sequence in the input file against itself to find internal repeats or inversions.
    ```bash
    flexidot -i input.fasta -m 0 -k 10
    ```
*   **Pairwise comparison (Mode 1):** Compare sequences in pairs.
    ```bash
    flexidot -i seq1.fasta seq2.fasta -m 1 -k 12
    ```
*   **All-to-all comparison (Mode 2):** Compare every sequence against every other sequence in the input set.
    ```bash
    flexidot -i input.fasta -m 2 -k 10
    ```

### Working with Pre-computed Alignments
For large datasets or sequences with high divergence, use alignments from BLAST (format 6) or Nucmer (PAF format) to speed up plotting and handle gaps.
```bash
flexidot -i sequences.fasta -m 2 -a alignments.blast6 -o output_name
```

### Visual Customization and Annotations
*   **Add GFF Shading:** Overlay biological features onto the dotplot using a GFF3 file and a color configuration file.
    ```bash
    flexidot -i seq.fasta -m 0 -g annotations.gff3 -G color_map.config
    ```
*   **Enable Length Scaling:** Use `-L` to scale the axes according to actual sequence lengths rather than forcing a square plot.
    ```bash
    flexidot -i seq.fasta -m 1 -L
    ```
*   **Create Collages:** Combine multiple plots into a single image for rapid screening of large sequence sets.
    ```bash
    flexidot -i multiple_seqs.fasta -m 0 --collage --n_col 4
    ```

## Expert Tips and Best Practices

*   **K-mer Selection:** Use smaller k-mer sizes (e.g., `-k 8` to `10`) for sensitive detection of small repeats, and larger sizes (e.g., `-k 15+`) for highly specific matches in large genomic regions.
*   **Sequence Type:** Always specify the sequence type if working with proteins using `-t aa` (default is `-t nuc`).
*   **Ambiguity Awareness:** FlexiDot is designed to handle ambiguous residues (like N in DNA or X in proteins). If your sequences are error-prone, consider using the alignment-based mode (`-m 2 -a`) for better sensitivity.
*   **Memory Management:** When processing very large FASTA files with many sequences, use the `--collage` option to manage output file generation and prevent the creation of thousands of individual image files.
*   **Output Formats:** By default, FlexiDot produces high-quality images. Ensure your environment has `matplotlib` and `biopython` installed to handle the rendering and sequence parsing.

## Reference documentation

- [FlexiDot Main Documentation](./references/github_com_flexidot-bio_flexidot.md)
- [FlexiDot Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_flexidot_overview.md)