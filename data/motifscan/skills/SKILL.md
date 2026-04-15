---
name: motifscan
description: MotifScan detects known DNA motifs within genomic regions and performs statistical enrichment analysis. Use when user asks to scan genomic regions for motifs, manage reference genomes, install motif sets, or perform motif enrichment analysis.
homepage: https://github.com/shao-lab/MotifScan
metadata:
  docker_image: "quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3"
---

# motifscan

## Overview
MotifScan is a specialized bioinformatics tool for detecting known DNA motifs within genomic regions. It provides a complete workflow for motif discovery, including the management of reference genomes and Position Frequency Matrix (PFM) sets. Beyond simple pattern matching, MotifScan can perform statistical tests to determine if motifs are significantly enriched or depleted in a target set of regions compared to a control set. It is highly optimized for performance using multi-threading and C extensions for score calculations.

## Command Line Usage

### 1. Genome Management
Before scanning, you must install the relevant genome assembly.

*   **List available remote genomes (UCSC):**
    ```bash
    motifscan genome --list-remote
    ```
*   **Install a genome from UCSC:**
    ```bash
    motifscan genome --install -n hg19 -r hg19
    ```
*   **Install from local files:**
    Requires a FASTA file and a refGene annotation file.
    ```bash
    motifscan genome --install -n hg19 -i <genome.fa> -a <refGene.txt>
    ```

### 2. Motif Set Management
MotifScan uses motif sets (typically from JASPAR) to scan sequences.

*   **List available JASPAR sets:**
    ```bash
    motifscan motif --list-remote
    ```
*   **Install a motif set for a specific genome:**
    ```bash
    motifscan motif --install -n vertebrates -r vertebrates_non-redundant -g hg19
    ```
*   **Build an existing motif set for a new genome:**
    If you have a motif set installed for hg19 but now need it for hg38:
    ```bash
    motifscan motif --build vertebrates -g hg38
    ```

### 3. Scanning Genomic Regions
The `scan` command is the primary tool for motif detection.

*   **Basic scan:**
    ```bash
    motifscan scan -i regions.bed -g hg19 -m vertebrates -o output_dir
    ```
*   **Enrichment analysis:**
    To compare input regions against a control set to find significantly enriched motifs:
    ```bash
    motifscan scan -i regions.bed -c control.bed -g hg19 -m vertebrates -o output_dir
    ```

## Best Practices and Expert Tips

*   **Performance Optimization:** MotifScan v1.3.0+ uses pthreads for concurrent scanning. Ensure your environment allows for multi-threading to take advantage of significant speed improvements.
*   **Input Formats:** The tool natively supports multiple genomic formats including BED, MACS, MACS2, and narrowPeak. You do not need to manually convert these to standard BED in most cases.
*   **Memory Management:** For very large datasets, monitor memory usage. Recent updates have optimized memory footprint, but scanning high-resolution motif sets across whole-genome datasets remains resource-intensive.
*   **Score Cutoffs:** MotifScan supports multiple rounds of sampling to calculate score cutoffs. If your results are too noisy, consider adjusting the sampling parameters (check `motifscan scan -h` for specific sampling flags).
*   **Naming Conventions:** Avoid special characters like `/` or `*` in custom motif names; the tool automatically replaces these with `_` to prevent filesystem errors.



## Subcommands

| Command | Description |
|---------|-------------|
| motifscan config | Configure data paths for MotifScan. |
| motifscan genome | Genome assembly commands. This subcommand controls the genome assemblies used by MotifScan. MotifScan requires a sequences FASTA file and a gene annotation file (if available) for each genome assembly, users can either download them from a remote database or install directly with local prepared files. |
| motifscan motif | Motif set (PFMs/PWMs) commands. |
| motifscan scan | Scan input regions to detect motif occurrences. |

## Reference documentation
- [MotifScan GitHub Repository](./references/github_com_shao-lab_MotifScan.md)
- [MotifScan README](./references/github_com_shao-lab_MotifScan_blob_master_README.rst.md)
- [MotifScan ChangeLog](./references/github_com_shao-lab_MotifScan_blob_master_CHANGELOG.rst.md)