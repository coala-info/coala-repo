---
name: metaplex
description: MetaPlex processes dual-indexed metabarcoding data to prepare it for QIIME2 analysis and filters false reads caused by index jumping. Use when user asks to remultiplex raw reads, calculate index jump rates, or perform frequency and length-based quality filtering.
homepage: https://github.com/NGabry/MetaPlex
---


# metaplex

## Overview

MetaPlex is a specialized toolkit designed to handle the unique requirements of dual-indexed metabarcoding workflows. It is particularly effective for researchers using Ion Torrent sequencers with fusion primers. The tool streamlines the transition from raw sequencer outputs (BAM or FASTQ) to downstream analysis in QIIME2 by reorganizing barcodes into the `MultiplexedSingleEndBarcodeInSequence` format. Beyond simple data conversion, it provides a conservative statistical approach to estimate and filter "index jumps"—false reads caused by barcode switching during library preparation or sequencing.

## Installation and Environment

MetaPlex is designed to run within a QIIME2 environment (version 2021.11 or later).

```bash
# Recommended installation via Conda
conda install -c bioconda metaplex

# Alternative installation via Pip
pip install metaplex
```

## Core Workflows and CLI Patterns

### 1. Remultiplexing Raw Reads
Use this to prepare raw data for QIIME2. It trims 5' and 3' ends and moves the 3' index to follow the 5' index.

**Command:**
`Metaplex-remultiplex <sequenceFile> <indexFile>`

*   **Inputs:** Supports `.fastq`, `.fastq.gz`, or `.bam`.
*   **Index File (`.csv`):** Must contain three columns:
    1.  `ID`: Two-digit zero-padded identifier (e.g., `01`).
    2.  `seq`: The barcode sequence. **Note:** Reverse tags must be input as reverse complements.
    3.  `orientation`: `F` for Forward, `R` for Reverse.
*   **Output:** A single `remultiplexed_seqs.fastq.gz` file ready for QIIME2 import.

### 2. Calculating Index Jump Rates (IJR)
Use this to estimate the rate of barcode switching and identify potential false reads in your demultiplexed data.

**Command:**
`Metaplex-calculate-IJR <demultiplexed_seqs.qza> <sample_map.txt> <calibrator_tag_pairs>`

*   **Inputs:** 
    *   A QIIME2 `.qza` artifact of type `SampleData[SequencesWithQuality]`.
    *   A tab-delimited sample map containing all possible index combinations and a `True_False` indicator column.
*   **Calibrator Tags:** Specify pairs used exclusively with each other (e.g., `01,11`).
*   **Outputs:** 
    *   `Expected_False_Reads_Per_Index.csv`: Expected false reads per sample.
    *   `log.txt`: Summary statistics of the run.

### 3. Quality Filtering
MetaPlex provides two primary filtering mechanisms to clean the feature table:
*   **Frequency-based:** Removes reads based on the calculated expectancy from the IJR tool or user-defined thresholds.
*   **Length-based:** Removes sequences below a specific length threshold from QIIME2 `FeatureTable[Frequency]` and `FeatureData[Sequence]` artifacts.

## Expert Tips and Best Practices

*   **Barcode Orientation:** When preparing the `indexes.csv`, ensure that any index placed on the reverse end of the fragment is provided as its **reverse complement**. Failure to do this will result in the remultiplexer failing to identify valid dual-indexed pairs.
*   **Conservative Estimation:** The Index Jump Calculator provides a conservative estimate. It does not account for jumps that result in the same sample assignment (e.g., an index jumping between two replicates of the same sample).
*   **Calibrator Selection:** For the most accurate IJR calculation, use at least one "calibrator" pair—a forward and reverse index combination that was only used together in the lab. Using multiple calibrator pairs increases the robustness of the jump rate estimate.
*   **QIIME2 Integration:** The output of `Metaplex-remultiplex` is specifically formatted for the `MultiplexedSingleEndBarcodeInSequence` import type. Use this exact type when running `qiime tools import`.

## Reference documentation
- [MetaPlex GitHub Repository](./references/github_com_NGabry_MetaPlex.md)
- [Bioconda MetaPlex Overview](./references/anaconda_org_channels_bioconda_packages_metaplex_overview.md)