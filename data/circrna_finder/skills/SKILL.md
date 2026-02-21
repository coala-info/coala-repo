---
name: circrna_finder
description: The circrna_finder pipeline is a specialized bioinformatics tool designed to extract circular RNA candidates from transcriptomic data.
homepage: https://github.com/orzechoj/circRNA_finder
---

# circrna_finder

## Overview
The circrna_finder pipeline is a specialized bioinformatics tool designed to extract circular RNA candidates from transcriptomic data. It operates in two distinct phases: first, it utilizes the STAR aligner's chimeric detection capabilities to map reads that span non-linear junctions; second, it applies a series of Perl and Awk scripts to filter these junctions for quality, length, and canonical splicing motifs. This tool is particularly useful for researchers looking for a lightweight, STAR-based approach to circRNA discovery that provides BED-formatted outputs for easy downstream analysis.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::circrna_finder
```

## Core Workflow

### 1. Alignment with STAR
The first step uses a wrapper script to execute STAR with the specific parameters required for chimeric (circular) detection.

**Paired-end command:**
```bash
./runStar.pl --inFile1 [R1.fastq] --inFile2 [R2.fastq] --genomeDir [path/to/STAR_index] --maxMismatch 0.02 --outPrefix [output_dir/prefix]
```

**Key Parameters:**
- `--maxMismatch`: Sets the `outFilterMismatchNoverReadLmax` parameter in STAR. The default is 0.02 (2% of read length).
- `--genomeDir`: Must point to a pre-generated STAR genome index.
- `--outPrefix`: Defines the directory and file prefix for all STAR-generated outputs.

### 2. Post-Processing
Once alignment is complete, run the post-processing script to filter the raw junctions. This script can process a single directory containing STAR results.

**Command:**
```bash
./postProcessStarAlignment.pl --starDir [directory_with_STAR_results] --minLen [minimum_length] --outDir [output_directory]
```

**Key Parameters:**
- `--starDir`: The directory where the `runStar.pl` outputs are located.
- `--minLen`: The minimum genomic distance between the start and end of the circular junction.
- `--outDir`: Where the final BED files and filtered BAMs will be stored.

## Output Interpretation
The pipeline produces several BED files for each library:

1.  **`_filteredJunctions.bed`**: All circular junctions identified. The score column represents the number of reads spanning the junction.
2.  **`_s_filteredJunctions.bed`**: A subset of the first file, containing only junctions flanked by canonical **GT-AG** splice sites.
3.  **`_s_filteredJunctions_fw.bed`**: Same junctions as the "s" file, but the score column provides the average number of forward-spliced reads at the splice sites, useful for calculating circular-to-linear ratios.
4.  **`Chimeric.out.sorted.bam`**: A sorted and indexed BAM file containing all chimeric reads identified by STAR.

## Expert Tips and Best Practices
- **STAR Version**: This pipeline was specifically tested and optimized for STAR version 2.7.9a. Using significantly older or newer versions may require manual adjustment of the `runStar.pl` script if STAR's command-line arguments have changed.
- **Memory Requirements**: Since the pipeline relies on STAR, ensure the system has enough RAM to load the reference genome index (typically 30GB+ for the human genome).
- **Batch Processing**: If you have multiple datasets in one directory, `postProcessStarAlignment.pl` is designed to iterate through all STAR output folders found within the `--starDir`.
- **Prerequisites**: Ensure `perl`, `awk`, and `samtools` are available in your PATH, as the wrapper scripts call these tools directly.

## Reference documentation
- [circRNA_finder GitHub Repository](./references/github_com_orzechoj_circRNA_finder.md)
- [circrna_finder Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_circrna_finder_overview.md)