---
name: mummer4
description: MUMmer4 is a high-performance alignment system designed for comparing large DNA sequences and entire genomes. Use when user asks to align whole genomes, compare nucleotide or protein sequences, identify SNPs, or generate dot plots for sequence comparisons.
homepage: https://mummer4.github.io/
---


# mummer4

## Overview
MUMmer4 is a high-performance alignment system designed for comparing large DNA sequences, such as entire bacterial or eukaryotic genomes. It excels at identifying maximal exact matches (MUMs) and clustering them into longer alignments. You should use this skill to navigate the modular nature of the MUMmer package, selecting the appropriate tool (nucmer for nucleotides, promer for amino acids, or dnadiff for automated comparative statistics) based on the evolutionary distance and quality of your input sequences.

## Core Workflows

### 1. Nucleotide Alignment (nucmer)
Use `nucmer` for comparing highly similar sequences (e.g., different strains of the same species or mapping contigs to a reference).

*   **Basic Usage**: `nucmer -p <prefix> <reference.fasta> <query.fasta>`
*   **Key Options**:
    *   `--mum`: Use only matches that are unique in both reference and query.
    *   `--mumreference`: (Default) Use matches unique in the reference.
    *   `--maxmatch`: Use all matches regardless of uniqueness (use with caution in repetitive genomes).
    *   `-c <int>`: Minimum cluster size. Increase this to reduce noise in draft assemblies.

### 2. Protein-Level Alignment (promer)
Use `promer` for divergent sequences where DNA similarity is low but protein conservation remains. It translates sequences in all 6 frames before aligning.

*   **Basic Usage**: `promer -p <prefix> <reference.fasta> <query.fasta>`
*   **Note**: Coordinates in output are still nucleotide-based, but delta values represent amino acids.

### 3. Automated Comparison (dnadiff)
Use `dnadiff` for a comprehensive "all-in-one" report of differences between two similar genomes or assemblies.

*   **Usage**: `dnadiff <reference.fasta> <query.fasta>`
*   **Outputs**: Generates `.report` (summary statistics), `.snps` (mismatches), and `.qdiff/.rdiff` (structural breakpoints).

## Processing Alignment Output
MUMmer produces `.delta` files which must be parsed by helper utilities to become human-readable.

*   **show-coords**: Converts delta files to a tabular coordinate format.
    *   `show-coords -r -c -l <file.delta> > <file.coords>`
    *   `-r`: Sort by reference.
    *   `-c`: Include percent coverage.
*   **show-snps**: Extracts SNPs and indels.
    *   `show-snps -C <file.delta>` (-C ensures only SNPs from unique regions are reported).
*   **delta-filter**: Filters alignments to find the "best" set.
    *   `delta-filter -m <file.delta>`: Many-to-many alignment (allows for duplications).
    *   `delta-filter -1 <file.delta>`: One-to-one alignment (best for SNP finding).
*   **show-tiling**: Generates a minimal set of contigs to cover the reference.
    *   `show-tiling <file.delta>`

## Visualization
*   **mummerplot**: Generates dot plots for gnuplot.
    *   `mummerplot -p <prefix> <file.delta>`
    *   Use `-postscript` or `-png` to specify output format.
    *   Forward matches appear as red lines (slope 1); reverse matches appear as green/blue lines (slope -1).

## Expert Tips
*   **Memory Management**: MUMmer4 is memory-efficient, but for extremely large genomes, ensure you have sufficient RAM for the suffix tree construction.
*   **Draft Assemblies**: When aligning hundreds of contigs, always use `show-coords -rcl` to see which contigs have the best coverage and identity relative to the reference.
*   **Tandem Repeats**: Use the `exact-tandems` utility for quick detection of repetitive units within a single FASTA file.



## Subcommands

| Command | Description |
|---------|-------------|
| delta-filter | Reads a delta alignment file from either nucmer or promer and filters the alignments based on the command-line switches, leaving only the desired alignments which are output to stdout in the same delta format as the input. |
| dnadiff | Run comparative analysis of two sequence sets using nucmer and its associated utilities with recommended parameters. See MUMmer documentation for a more detailed description of the output. Produces the following output files: |
| mummerplot | mummerplot generates plots of alignment data produced by mummer, nucmer, promer or show-tiling by using the GNU gnuplot utility. After generating the appropriate scripts and datafiles, mummerplot will attempt to run gnuplot to generate the plot. If this attempt fails, a warning will be output and the resulting .gp and .[frh]plot files will remain so that the user may run gnuplot independently. If the attempt succeeds, either an interactive gnuplot window will be spawned (default) or an additional output file will be generated (e.g., .ps or .png depending on the selected terminal with -t). Feel free to edit the resulting gnuplot script (.gp) and rerun gnuplot to change line thinkness, labels, colors, plot size etc. |
| nucmer | generates nucleotide alignments between two mutli-FASTA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format. |
| promer | promer generates amino acid alignments between two mutli-FASTA DNA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format. The DNA input is translated into all 6 reading frames in order to generate the output, but the output coordinates reference the original DNA input. |
| show-coords | Output is to stdout, and consists of a list of coordinates, percent identity, and other useful information regarding the alignment data contained in the .delta file used as input. |
| show-snps | Output is to stdout, and consists of a list of SNPs (or amino acid substitutions for promer) with positions and other useful info. |
| show-tiling | Output is to stdout, and consists of the predicted location of each aligning query contig as mapped to the reference sequences. These coordinates reference the extent of the entire query contig, even when only a certain percentage of the contig was actually aligned (unless the -a option is used). Columns are, start in ref, end in ref, distance to next contig, length of this contig, alignment coverage, identity, orientation, and ID respectively. |

## Reference documentation
- [MUMmer4 Manual](./references/mummer4_github_io_manual_manual.html.md)
- [MUMmer4 Tutorials](./references/mummer4_github_io_tutorial_tutorial.html.md)
- [MUMmer4 GitHub Wiki](./references/github_com_mummer4_mummer_wiki.md)