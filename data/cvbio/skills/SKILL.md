---
name: cvbio
description: cvbio is a suite of bioinformatics tools for multi-species read disambiguation, remote control of the Integrative Genomics Viewer, and genomic file contig renaming. Use when user asks to disambiguate reads from multiple species, control IGV from the command line, or update contig names in genomic data files.
homepage: https://github.com/clintval/cvbio
---


# cvbio

## Overview

cvbio is a suite of Scala-based bioinformatics tools designed to streamline specific genomic workflows. Its primary strengths lie in multi-species read disambiguation—essential for analyzing sequencing data from transduction, transfection, or patient-derived xenograft (PDX) experiments—and providing a programmatic interface to the Integrative Genomics Viewer (IGV). It also includes utilities for standardizing contig naming conventions across different genomic data formats.

## Installation

Install via Bioconda:
```bash
conda install bioconda::cvbio
```

## Tool-Specific Guidance

### 1. Disambiguate Reads
Use this tool to separate reads that have been mapped to multiple reference genomes (e.g., Human and Mouse). It compares alignment scores across primary, secondary, and supplementary alignments to assign a template to the most likely source.

*   **Supported Aligners**: Currently supports BAM files produced by `bwa` or `STAR`.
*   **Input Requirements**: Accepts BAMs in any sort order, but queryname-sorted input avoids an internal sort step.
*   **Command Pattern**:
    ```bash
    cvbio Disambiguate \
      -i sample.human.bam sample.mouse.bam \
      -p results/sample_output \
      -n hg38 mm10
    ```
*   **Expert Tip**: Use the `-n` (names) flag to provide clear labels for your references. This determines the naming of the output BAM files (e.g., `sample_output.hg38.bam`).

### 2. IgvBoss (IGV Remote Control)
Use this to control an IGV session directly from the terminal. This is highly effective for rapid visualization of specific loci across multiple samples.

*   **Prerequisite**: In IGV, go to `Preferences > Advanced` and ensure "Enable remote control" is checked.
*   **Command Pattern**:
    ```bash
    cvbio IgvBoss \
      -g hg38 \
      -i alignments.bam targets.bed \
      -l chr1:1000-2000 chr2:5000-6000
    ```
*   **Key Features**:
    *   **Locus Navigation**: Provide multiple loci to trigger a split-window view.
    *   **Auto-Start**: If IGV isn't running, IgvBoss will attempt to find and launch the IGV executable or JAR.
    *   **Cleanup**: Use `--close-on-exit` to shut down the IGV application once your investigation is finished.

### 3. UpdateContigNames
Use this to relabel chromosome names (e.g., converting Ensembl `1` to UCSC `chr1`) in delimited files like GTF, GFF, or BED.

*   **Command Pattern**:
    ```bash
    cvbio UpdateContigNames \
      -i input.gtf.gz \
      -o output.ucsc.gtf.gz \
      -m mapping_table.txt \
      --columns 0 \
      --comment-chars '#'
    ```
*   **Best Practices**:
    *   **Mapping Tables**: Use standard mapping files (e.g., from the `ChromosomeMappings` repository).
    *   **Column Selection**: Use `--columns` to specify which zero-indexed columns contain the contig names (e.g., column `0` for GTF/BED).
    *   **Handling Missing**: Set `--skip-missing true` if you want to drop rows where the chromosome name is not found in your mapping file.

## Reference documentation
- [cvbio Overview](./references/anaconda_org_channels_bioconda_packages_cvbio_overview.md)
- [cvbio GitHub Documentation](./references/github_com_clintval_cvbio.md)