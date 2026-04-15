---
name: rmetl
description: rMETL identifies mobile element insertions in long-read sequencing data using a realignment-based strategy. Use when user asks to detect mobile element insertions, realign chimeric reads to a mobile element reference, or perform variant calling and genotyping on PacBio or ONT datasets.
homepage: https://github.com/tjiangHIT/rMETL
metadata:
  docker_image: "quay.io/biocontainers/rmetl:1.0.4--py_0"
---

# rmetl

## Overview

rMETL (Realignment-based Mobile Element insertion detection Tool for Long read) is a specialized bioinformatics suite designed to identify MEIs in noisy long-read datasets. It overcomes the complexity of repetitive mobile elements by using a realignment strategy. The tool is particularly effective for producing high-quality MEI callsets in genomics studies using PacBio or ONT platforms.

## Installation and Environment

rMETL requires Python 2.7 and several dependencies (pysam, Biopython, ngmlr, samtools, and cigar).

*   **Conda (Recommended):** `conda install -c bioconda rmetl`
*   **Pip:** `pip install rMETL`
*   **Resource Requirements:** Peak memory footprint is approximately 7.05 GB for human reference (hs37d5) alignments.

## Core Workflow

The rMETL pipeline consists of three sequential stages. **Critical:** You must manually create the output directory before running any command.

### 1. Locus Detection
Infers putative MEI loci from initial alignments.

```bash
rMETL.py detection <alignments.bam> <reference.fa> <temp_dir> <output_dir>
```

*   **Key Parameters:**
    *   `--presets`: Set to `ont` for Oxford Nanopore or `pacbio` (default).
    *   `--min_support`: Minimum number of supporting reads (default: 5). Increase for high-coverage data to reduce noise.
    *   `--threads`: Number of threads to utilize.

### 2. Chimeric Read Realignment
Realigns chimeric read parts to a mobile element reference.

```bash
rMETL.py realignment <potential_ME.fa> <ME_reference.fa> <output_dir>
```

*   **Input:** The `<potential_ME.fa>` is typically generated in the detection stage.
*   **ME Reference:** Requires a reference file containing known mobile element sequences (e.g., Alu, L1, SVA).
*   **Subread Parameters:** `SUBREAD_LENGTH` (default 128) and `SUBREAD_CORRIDOR` (default 20) control the granularity of the realignment.

### 3. MEI Calling
Performs the final variant calling and genotyping.

```bash
rMETL.py calling <realigned.sam> <reference.fa> <out_type> <output_dir>
```

*   **out_type:** Specify the desired output format.
*   **Genotyping Thresholds:** 
    *   `--homozygous`: Minimum score for homozygous calls (default: 0.8).
    *   `--heterozygous`: Minimum score for heterozygous calls (default: 0.3).
*   **Filtering:** Use `--min_mapq` (default: 20) to filter low-quality alignments.
*   **Display:** Set `--MEI True` to display only MEI/MED (Mobile Element Deletion) results.

## Expert Tips and Best Practices

*   **Manual Directory Creation:** The tool may fail if the output path does not exist. Always run `mkdir -p <output_dir>` before execution.
*   **Sequencing Presets:** Never skip the `--presets` flag if working with Nanopore data, as the error profiles differ significantly from PacBio.
*   **Temporary Files:** The `detection` stage generates significant temporary data. Ensure the `<temp_dir>` is on a disk with sufficient space and high I/O performance.
*   **Genotype Tuning:** If the callset has too many false positives, consider raising the `--clipping_threshold` (default 0.5) in the calling stage to require cleaner realignment signals.

## Reference documentation
- [rMETL Main Repository](./references/github_com_tjiangHIT_rMETL.md)
- [Bioconda rMETL Package](./references/anaconda_org_channels_bioconda_packages_rmetl_overview.md)