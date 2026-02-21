---
name: smartmap
description: The `smartmap` tool addresses the challenge of multi-mapping reads by using an iterative Bayesian algorithm to distribute read weights based on local genomic context and alignment scores.
homepage: http://shah-rohan.github.io/SmartMap
---

# smartmap

## Overview
The `smartmap` tool addresses the challenge of multi-mapping reads by using an iterative Bayesian algorithm to distribute read weights based on local genomic context and alignment scores. It transforms standard alignments into weighted BEDGRAPH files, providing a more accurate representation of genome-wide coverage than traditional "unique-only" or "random-assignment" methods. This skill covers the three primary components: `SmartMapPrep` (DNA/Bowtie2), `SmartMapRNAPrep` (RNA/Hisat2), and the core `SmartMap` reweighting binary.

## Workflow and CLI Patterns

### 1. Data Preparation (Alignment)
Before running the Bayesian refinement, reads must be aligned and filtered. The prep scripts automate Bowtie2/Hisat2 execution with specific flags required for the downstream algorithm.

**For DNA-seq (Bowtie2):**
Use `SmartMapPrep` to generate extended BED files.
```bash
SmartMapPrep -x /path/to/bowtie2_index -o output_prefix -1 reads_R1.fq.gz -2 reads_R2.fq.gz -p 8 -k 51
```
*   **Key Parameter:** `-k` (default 51) defines the search space for multi-mappers. Increasing this captures more ambiguity but increases computation time.

**For RNA-seq (Hisat2):**
Use `SmartMapRNAPrep` for splice-aware alignment.
```bash
SmartMapRNAPrep -x /path/to/hisat2_index -o rna_prefix -1 rna_R1.fq.gz -2 rna_R2.fq.gz -p 8
```

### 2. Bayesian Reweighting
The core `SmartMap` binary processes the output from the prep stage. It requires a genome lengths file (tab-delimited: `chrom\tlength`).

**Standard Run:**
```bash
SmartMap -g hg38.chrom.sizes -o final_weighted -i 10 output_prefix.bed.gz
```

**Strand-Specific RNA-seq:**
If your library is stranded, ensure you use the `-S` flag to generate separate positive and negative strand BEDGRAPHs.
```bash
SmartMap -S -g hg38.chrom.sizes -o stranded_output input_splits/*.bed
```

### 3. Expert Tips and Best Practices
*   **Memory Management:** For large datasets, `SmartMap` processes files in the `splits/` directory created by the prep scripts. You can pass individual split files (e.g., `splits/read_1.bed`, `splits/read_2.bed`) to the binary to manage load.
*   **Iteration Tuning:** The `-i` parameter defaults to 1. For complex repetitive regions (e.g., transposons or paralogs), increasing iterations (e.g., `-i 5` or `-i 10`) allows the weights to converge more accurately.
*   **Score Thresholds:** Use `-s` to filter out low-quality alignments if the initial mapping was too permissive.
*   **Output Handling:** The tool produces Gzipped BEDGRAPH files. These can be converted to BigWig using `wigToBigWig` for visualization in IGV or UCSC Genome Browser.

## Reference documentation
- [SmartMap User Manual](./references/shah-rohan_github_io_SmartMap.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_smartmap_overview.md)