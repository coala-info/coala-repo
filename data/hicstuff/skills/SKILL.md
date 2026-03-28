---
name: hicstuff
description: hicstuff is a lightweight Python library and command-line toolset designed for the end-to-end processing and analysis of Hi-C data. Use when user asks to build a Hi-C pipeline, generate contact maps, convert between Hi-C file formats, or visualize contact frequencies.
homepage: https://github.com/koszullab/hicstuff
---

# hicstuff

## Overview
hicstuff is a lightweight Python library and command-line toolset designed for the end-to-end processing of Hi-C data. It streamlines the workflow from raw sequencing reads to finalized contact maps in formats like Cooler, graal, or 2D bedgraph. Beyond matrix generation, it provides specialized utilities for genome digestion, iterative alignment, spurious event filtering, and statistical analysis of chromosome folding properties. Use this skill when you need to build a Hi-C pipeline, convert between Hi-C file formats, or visualize contact frequencies.

## Core CLI Usage

### Running the Full Pipeline
The `pipeline` command is the primary entry point to generate a contact matrix from FastQ files.

```bash
# Basic pipeline execution with DpnII enzyme and minimap2 aligner
hicstuff pipeline \
    --genome genome.fa \
    --enzyme DpnII \
    --aligner minimap2 \
    --threads 8 \
    --outdir results/ \
    reads_R1.fastq.gz reads_R2.fastq.gz
```

### Matrix Manipulation and Conversion
hicstuff supports several formats, including `.cool`, `.bg2` (2D bedgraph), and `.tsv` (graal).

*   **Convert formats**: `hicstuff convert --to cool input_matrix.tsv output_prefix`
*   **Rebin a matrix**: `hicstuff rebin --bin-size 5000 input.cool output.cool`
*   **Subsample contacts**: `hicstuff subsample --n-contacts 1000000 input.cool output.cool`

### Analysis and Visualization
*   **Visualize a matrix**: `hicstuff view --bin-size 10kb --transform log10 matrix.cool`
*   **Distance Law**: Generate and plot the relationship between genomic distance and contact probability.
    ```bash
    hicstuff distancelaw --pairs library.pairs --frags fragments_list.txt --plot
    ```

## Expert Tips and Best Practices

*   **Aligner Selection**: Use `minimap2` for faster processing or `bowtie2` (default) for standard accuracy. For very short reads or complex libraries, consider the `iteralign` subcommand to maximize uniquely mapped reads.
*   **Enzyme Specification**: You can provide a restriction enzyme name (e.g., `DpnII`, `HinfI`), a comma-separated list for multiple digestion, or an integer for fixed-size "virtual" digestion (e.g., `--enzyme 5000` for 5kb chunks).
*   **Input Flexibility**: The pipeline can start from different stages using `--start-stage`.
    *   `fastq`: Raw reads (default).
    *   `bam`: Name-sorted BAM files.
    *   `pairs`: Validated Hi-C pairs.
*   **Filtering**: Always use the `--filter` flag in the pipeline to remove spurious events like loops and uncuts, which can bias the contact map.
*   **Memory Management**: For large genomes, use the `--tmpdir` option to point to a high-capacity disk, as intermediate alignment files can be substantial.



## Subcommands

| Command | Description |
|---------|-------------|
| distancelaw | Take the distance law file from hicstuff and can average it, normalize it compute the     slope of the curve and plot it. |
| hicstuff_convert | Convert between different Hi-C dataformats. Currently supports tsv (graal), bedgraph2D (bg2) and cooler (cool). Input format is automatically inferred. |
| hicstuff_cutsite | Generates new gzipped fastq files from original fastq. The function will cut the reads at their religation sites and creates new pairs of reads with the different fragments obtained after cutting at the digestion sites. |
| hicstuff_digest | Digests a fasta file into fragments based on a restriction enzyme or a fixed chunk size. Generates two output files into the target directory named "info_contigs.txt" and "fragments_list.txt" |
| hicstuff_filter | Filters spurious 3C events such as loops and uncuts from the library based on a minimum distance threshold automatically estimated from the library by default. Can also plot 3C library statistics. |
| hicstuff_iteralign | Truncate reads from a fastq file to 20 basepairs and iteratively extend and     re-align the unmapped reads to optimize the proportion of uniquely aligned     reads in a 3C library. |
| hicstuff_missview | Previews bins that will be missing in a Hi-C map with a given read length by finding repetitive regions in the genome. |
| hicstuff_pipeline | Whole (end-to-end) contact map generation command |
| hicstuff_rebin | Rebins a Hi-C matrix and modifies its fragment and chrom files accordingly.     Output files are in the same format as the input files (cool, graal or bg2). |
| hicstuff_stats | Extract stats from a hicstuff log file. |
| hicstuff_subsample | Subsample contacts from a Hi-C matrix. Probability of sampling is proportional to the intensity of the bin. |
| hicstuff_view | Visualize a Hi-C matrix file as a heatmap of contact frequencies. Allows to tune visualisation by binning and normalizing the matrix, and to save the output image to disk. If no output is specified, the output is displayed. |

## Reference documentation
- [hicstuff GitHub Repository](./references/github_com_koszullab_hicstuff.md)
- [hicstuff CLI Demo](./references/hicstuff_readthedocs_io_en_latest_notebooks_demo_cli.html.md)
- [hicstuff API Reference](./references/hicstuff_readthedocs_io_en_latest_api_hicstuff.html.md)