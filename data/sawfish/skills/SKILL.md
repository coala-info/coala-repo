---
name: sawfish
description: Sawfish is a high-resolution variant caller that identifies structural variations and copy number changes in PacBio HiFi reads. Use when user asks to call structural variants, perform copy number segmentation, or conduct joint-calling across a cohort of samples.
homepage: https://github.com/PacificBiosciences/sawfish
---


# sawfish

## Overview

Sawfish is a high-resolution variant caller specifically optimized for Pacific Biosciences (PacBio) HiFi reads. It provides a unified analysis of structural variations and copy number changes by combining local sequence assembly with sequencing coverage segmentation. The tool operates in a two-stage workflow: an initial discovery phase per sample followed by a joint-calling phase that harmonizes variants across a cohort. It is particularly effective at resolving complex variants to base-pair resolution and correcting for GC-bias in depth-based calls.

## Command Line Usage

### 1. Discovery Step (Per-Sample)
Run the discovery module on each individual BAM or CRAM file. This step performs local assembly and initial depth analysis.

```bash
sawfish discover \
    --bam sample.bam \
    --ref reference.fasta \
    --out-dir ./sample_discovery
```

**Key Options:**
- `--min-sv-minq`: Sets the minimum mapping quality for evidence reads (default is 5).
- `--disable-cnv`: Use this for non-WGS data or when depth-based CNV calling is not required.
- `--min-variant-size`: Minimum size for reported variants (default is 35bp).

### 2. Joint-Call Step (Cohort)
Combine the results from multiple discovery directories to produce a joint VCF and synchronized copy number segments.

```bash
sawfish joint-call \
    --discover-dir ./sample1_discovery \
    --discover-dir ./sample2_discovery \
    --ref reference.fasta \
    --out-dir ./joint_output
```

**Advanced Joint-Calling:**
For large cohorts, use a CSV file to specify inputs instead of multiple `--discover-dir` flags:
```bash
sawfish joint-call \
    --sample-csv samples.csv \
    --ref reference.fasta \
    --out-dir ./joint_output
```

## Expert Tips and Best Practices

- **Input Requirements**: Ensure your HiFi reads are mapped to the reference genome. Sawfish relies on existing alignments to trigger local assembly.
- **Memory Management**: When working with CRAM files in large cohorts, monitor memory usage. Recent updates (v1.0.1+) have optimized memory for CRAM, but BAM remains the most stable for extremely high thread counts.
- **Inversion Calling**: Sawfish applies specific phasing requirements for large inversions (>100kb). Breakends must not be in phase with unrelated breakends on the same read to reduce false positives.
- **Output Interpretation**:
    - **VCF**: Contains merged SV and CNV records.
    - **Depth Tracks**: Look for the GC-bias corrected depth tracks in the joint-call output for accurate copy number visualization.
    - **Assembled Contigs**: Use the optional BAM output of assembled SV contig alignments to manually review complex breakpoints in a genome browser.
- **Supporting Reads**: To identify which specific reads contributed to a call, use the `--report-supporting-reads` flag during the joint-call step.



## Subcommands

| Command | Description |
|---------|-------------|
| sawfish | For more information, try '--help'. |
| sawfish | For more information, try '--help'. |
| sawfish | Print help information for sawfish commands. |
| sawfish | For more information, try '--help'. |
| sawfish | For more information, try '--help'. |
| sawfish discover | Discover SV candidate alleles in one sample |
| sawfish joint-call | Merge and genotype SVs from one or more samples, given the discover command results from each |

## Reference documentation
- [Sawfish README](./references/github_com_PacificBiosciences_sawfish_blob_main_README.md)
- [Sawfish Changelog](./references/github_com_PacificBiosciences_sawfish_blob_main_CHANGELOG.md)
- [Sawfish User Guide Reference](./references/github_com_PacificBiosciences_sawfish_blob_main_docs_user_guide.md)