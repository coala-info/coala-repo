---
name: eastr
description: EASTR (Emending Alignment of Spliced Transcript Reads) is a bioinformatics utility designed to refine RNA-seq datasets by identifying and eliminating mapping artifacts.
homepage: https://github.com/ishinder/EASTR
---

# eastr

## Overview
EASTR (Emending Alignment of Spliced Transcript Reads) is a bioinformatics utility designed to refine RNA-seq datasets by identifying and eliminating mapping artifacts. It works by extracting splice junction sequences and re-aligning them to the reference genome using Bowtie2 to determine if a junction is uniquely supported or likely a result of spurious alignment. This tool is particularly useful for researchers performing transcriptome assembly who need to reduce noise and improve the precision of their transcript models.

## Installation and Setup
The recommended way to install EASTR and its dependencies (Bowtie2 and Samtools) is via Bioconda:
```bash
conda install bioconda::eastr
```
Note: A C++ implementation (`eastr-cpp`) is available for users requiring higher performance (approx. 10x faster).

## Core CLI Patterns

### Processing BAM Files
To filter spurious alignments from one or more BAM files, provide a text file containing the paths to your BAMs:
```bash
# Create a list of BAM files
ls path/to/BAMs/*.bam > bamlist.txt

# Run EASTR to generate filtered BAMs
eastr --bam bamlist.txt \
      --reference reference.fasta \
      --bowtie2_index /path/to/bt2_index \
      --out_filtered_bam output/filtered_bams/ \
      -p 8
```

### Processing GTF Annotations
To identify questionable junctions within a transcript annotation file:
```bash
eastr --gtf input.gtf \
      --reference reference.fasta \
      --bowtie2_index /path/to/bt2_index \
      --out_removed_junctions questionable_junctions.bed
```

### Processing BED Files
To analyze specific intron coordinates:
```bash
eastr --bed introns.bed \
      --reference reference.fasta \
      --bowtie2_index /path/to/bt2_index
```

## Parameter Optimization
*   **Parallelization**: Always use the `-p` flag to specify the number of parallel processes, as the alignment step is computationally intensive.
*   **Stringency (`--bt2_k`)**: This sets the minimum number of distinct alignments found by Bowtie2 for a junction to be flagged as spurious. The default is 10.
*   **Anchor Length (`-a`)**: The minimum required anchor length in each of the two exons (default: 7). Increase this if you are working with very long reads or high-complexity genomes.
*   **Overhang (`-o`)**: Sets the length of the sequence extracted on either side of the splice junction (default: 50).
*   **Trusted Junctions**: Use `--trusted_bed` to provide a list of known-good junctions that EASTR should never remove.

## Expert Tips
*   **QC Removed Reads**: Use the `--removed_alignments_bam` flag when filtering BAM files. This allows you to inspect exactly what EASTR is discarding to ensure you aren't losing biological signal.
*   **Memory Management**: When processing large BAM lists, ensure your environment has sufficient memory for Bowtie2 indices.
*   **Case Sensitivity**: Ensure your reference FASTA and Bowtie2 index match. Recent updates have addressed case-sensitivity bugs, but consistent naming conventions are recommended.

## Reference documentation
- [EASTR GitHub Repository](./references/github_com_ishinder_EASTR.md)
- [Bioconda EASTR Overview](./references/anaconda_org_channels_bioconda_packages_eastr_overview.md)