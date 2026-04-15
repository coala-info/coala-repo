---
name: alfa
description: ALFA analyzes the distribution of aligned NGS reads across genomic annotations to provide a global perspective on dataset composition. Use when user asks to intersect BAM files with GTF annotations, generate feature enrichment plots, or perform quality control on sequencing data.
homepage: https://github.com/biocompibens/ALFA
metadata:
  docker_image: "quay.io/biocontainers/alfa:1.1.1--pyh5e36f6f_0"
---

# alfa

## Overview
ALFA (Annotation Landscape for Aligned Reads) provides a global perspective on the composition of NGS datasets. By intersecting aligned reads (BAM) with genomic annotations (GTF), it produces plots showing both the raw nucleotide distribution and the enrichment/depletion of features relative to their total genomic "surface area." This tool is sequencing-technique agnostic and works for any organism, making it essential for quality control and biological discovery in transcriptomics and genomics workflows.

## Core Workflow

ALFA operates in two main phases: indexing the genome and processing the reads. These can be performed separately or in a single command.

### 1. Preparing Input Files
Before running ALFA, ensure your input files are correctly formatted and sorted.
*   **GTF Sorting**: The annotation file must be sorted by position.
    ```bash
    sort -k1,1 -k4,4n -k5,5nr input.gtf > sorted.gtf
    ```
*   **BAM Sorting**: BAM files must be coordinate-sorted (e.g., via `samtools sort`).
*   **Chromosome Lengths**: While ALFA can estimate lengths from the GTF, providing a tab-delimited file (`ChrName Length`) via `--chr_len` is more accurate.

### 2. Indexing and Processing (Combined Command)
The most efficient way to run ALFA for a new project is to generate the index and process BAM files simultaneously.
```bash
alfa -a sorted.gtf -g genome_index_name --bam sample1.bam Label1 sample2.bam Label2 --pdf output_plots.pdf
```

### 3. Two-Step Execution
Use this approach if you plan to reuse the same genome index for multiple experiments.

**Step A: Generate Index**
```bash
alfa -a sorted.gtf -g my_index --chr_len lengths.txt
```

**Step B: Process Reads**
```bash
alfa -g my_index --bam sample.bam MyLabel --strandness reverse --png results.png
```

## CLI Reference & Best Practices

### Library Strandness (`-s/--strandness`)
Correctly identifying strandness is critical for accurate feature assignment:
*   `unstranded` (Default)
*   `forward` or `fr-firststrand`
*   `reverse` or `fr-secondstrand`

### Handling Ambiguity
By default, nucleotides mapping to more than one feature are discarded. Use `--keep_ambiguous` to split the count equally between overlapping features instead.

### Categories Depth (`-d`)
Adjust the granularity of the genomic categories (1 to 4). Higher values provide more detailed sub-category breakdowns.

### Output Management
*   **Plots**: Use `--pdf`, `--svg`, or `--png` to specify the format and path.
*   **No GUI**: Use `-n/--no_display` if running on a headless server to prevent the tool from attempting to open a plot window.
*   **Recalculation**: Use `-c/--count` with existing count files to regenerate plots without re-processing the BAM files.

## Expert Tips
*   **Resource Allocation**: ALFA is efficient; 1GB of RAM is typically sufficient for human-scale BAM files. Use `-p` to specify the number of CPUs for faster processing.
*   **Intergenic Features**: ALFA automatically calculates intergenic regions based on the gaps between annotations in the GTF and the chromosome lengths provided.
*   **Biotype Requirements**: Ensure your GTF contains `gene_biotype` or `transcript_biotype` attributes. If these are missing, ALFA may fail to produce the biotype-level distribution plot.

## Reference documentation
- [ALFA GitHub Repository](./references/github_com_biocompibens_ALFA.md)
- [ALFA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_alfa_overview.md)