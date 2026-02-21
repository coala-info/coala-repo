---
name: ncrf
description: The Noise-Cancelling Repeat Finder (NCRF) is a specialized tool designed to uncover tandem repeats in error-prone genomic data.
homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
---

# ncrf

## Overview
The Noise-Cancelling Repeat Finder (NCRF) is a specialized tool designed to uncover tandem repeats in error-prone genomic data. Traditional repeat finders often fail on long-read data due to high insertion, deletion, and mismatch rates. NCRF solves this by aligning segments of DNA sequences to repeated copies of a user-specified motif using a noise-tolerant algorithm. It is primarily an exploratory tool for researchers working with PacBio or Nanopore reads, allowing for fine-tuned control over alignment scoring and filtering based on match ratios and repeat lengths.

## Installation and Setup
The most reliable way to install NCRF is via Bioconda:
```bash
conda install bioconda::ncrf
```
Note: While the core engine is written in C, the post-processing helper scripts are designed for Python 2.7 and may require a legacy environment.

## Common CLI Patterns

### Basic Motif Search
Search a FASTA file for a specific repeated motif (e.g., GGCAT):
```bash
cat reads.fa | NCRF GGCAT > results.ncrf
```

### Using Named Motifs
Assigning a name to a motif helps in downstream parsing and organization:
```bash
cat reads.fa | NCRF telomere:TTAGGG > results.ncrf
```

### Platform-Specific Scoring
NCRF provides optimized scoring matrices for different sequencing technologies to improve alignment accuracy:
- **PacBio**: `--scoring=pacbio` (M=10, MM=35, IO=33, IX=21, DO=6, DX=28)
- **Nanopore**: `--scoring=nanopore` (M=10, MM=63, IO=51, IX=98, DO=27, DX=34)

### Filtering at Runtime
To reduce noise in the output, apply filters directly during the search:
- **Match Ratio**: `--minmratio=0.85` (discards alignments with < 85% matches)
- **Minimum Length**: `--minlength=500` (discards repeats shorter than 500bp)
- **Max Noise**: `--maxnoise=15%` (equivalent to 85% match ratio)

## Post-Processing Workflow
NCRF output is typically processed through a pipeline of helper scripts:

1.  **Concatenation**: Use `ncrf_cat.py` instead of the standard shell `cat` to merge multiple `.ncrf` files, as it correctly handles end-of-file markers.
    ```bash
    ncrf_cat.py file1.ncrf file2.ncrf > combined.ncrf
    ```
2.  **Consensus Filtering**: Filter out alignments where the motif in the read doesn't match the intended motif's consensus.
    ```bash
    cat results.ncrf | ncrf_consensus_filter.py --maxactualnoise=0.20
    ```
3.  **Overlaps**: Resolve overlapping repeat detections.
    ```bash
    cat results.ncrf | ncrf_resolve_overlaps.py > resolved.ncrf
    ```
4.  **Conversion**: Convert the specialized `.ncrf` format to standard BED format for visualization in IGV or UCSC Genome Browser.
    ```bash
    cat results.ncrf | ncrf_to_bed.py > results.bed
    ```

## Expert Tips
- **Memory Constraints**: NCRF is optimized for sequences up to ~500kbp and motifs up to ~200bp. Performance may degrade significantly on chromosome-scale scaffolds or extremely long motifs.
- **Detailed Statistics**: Use `--stats=events` to see specific match, mismatch, insertion, and deletion counts for every alignment.
- **Positional Bias**: Use `--positionalevents` to detect if errors are non-uniform across the motif, which can help distinguish true biological variation from sequencing artifacts.
- **Custom Scoring**: If the presets don't work, define a simple matrix with `--scoring=simple:M/E` where M is the match reward and E is the penalty for all errors.

## Reference documentation
- [NCRF GitHub Repository](./references/github_com_makovalab-psu_NoiseCancellingRepeatFinder.md)
- [Bioconda NCRF Package](./references/anaconda_org_channels_bioconda_packages_ncrf_overview.md)