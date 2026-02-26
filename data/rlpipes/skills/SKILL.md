---
name: rlpipes
description: RLPipes is a standardized upstream workflow that automates the processing of R-loop-mapping data from raw sequencing reads to downstream-ready coverage tracks and peak files. Use when user asks to build configuration files for R-loop modalities, validate workflow DAGs, or run the Snakemake pipeline for samples like DRIP, qDRIP, and R-ChIP.
homepage: https://github.com/Bishop-Laboratory/RLPipes
---


# rlpipes

## Overview

RLPipes is a standardized upstream workflow designed specifically for R-loop-mapping data. It automates the transition from raw sequencing reads (FASTQ) or alignments (BAM) to downstream-ready files like BigWig coverage tracks and BroadPeak files. Use this skill to guide the three-step execution process—build, check, and run—and to ensure proper configuration of the underlying Snakemake workflow for various R-loop modalities such as DRIP, qDRIP, and DRIPc.

## Core Workflow

The pipeline follows a strict sequential execution pattern.

### 1. Build Configuration
The `build` command initializes the run directory and generates a `config.json` file.

```bash
RLPipes build -m <MODE> -g <GENOME> <RUN_DIR> <SAMPLES_CSV>
```

*   **Modes**: Supported types include `DRIP`, `DRIPc`, `qDRIP`, `sDRIP`, `ssDRIP`, `R-ChIP`, `RR-ChIP`, `RDIP`, `S1-DRIP`, `DRIVE`, `RNH-CnR`, and `MapR`.
*   **Genomes**: Use UCSC genome builds (e.g., `hg38`, `mm10`). This is optional if using public SRA/GSM accessions as they are auto-detected.

### 2. Validation and DAG Generation
The `check` command verifies the configuration and generates a directed acyclic graph (DAG) of the jobs.

```bash
RLPipes check <RUN_DIR>
```

*   **Tip**: Always inspect the generated `dag.png` in the output directory before running to ensure the sample relationships and controls are correctly mapped.

### 3. Execution
The `run` command executes the actual bioinformatic rules.

```bash
RLPipes run -t <THREADS> <RUN_DIR>
```

## Sample Sheet (samples.csv) Requirements

The `samples.csv` is the most critical input. It must contain an `experiment` column.

*   **Local Files**: Provide the path to FASTQ or BAM files. For paired-end FASTQ, use a tilde separator: `read1.fq~read2.fq`.
*   **Public Data**: Provide SRX or GSM accessions (e.g., `SRX113814`). RLPipes will handle the download automatically.
*   **Controls**: Add a `control` column to specify the matching input or control sample for peak calling.
*   **Overrides**: You can include `genome` and `mode` columns in the CSV to specify different settings per sample, which overrides the global CLI flags.

## Expert Tips and Best Practices

*   **Performance Optimization**: Use the `--bwamem2` flag during `check` or `run` to utilize BWA-MEM2. This requires >70GB of RAM for index building but offers a 3x speed increase in alignment.
*   **Comparative Analysis**: Use the `-G` or `--groupby` flag to specify columns in your CSV (like "condition" or "tissue") for biologically meaningful groupings. If RNA-seq samples are included in these groups, the pipeline automatically performs expression-matched analysis.
*   **Resource Management**: If running on a cluster or high-core machine, always specify `-t` (threads) to parallelize the Snakemake rules.
*   **Troubleshooting**: If a run fails, check for `.failed` files in the output directory. You can pass custom Snakemake arguments using `-s` (e.g., `-s "{'keep_going': True}"`).
*   **Report Generation**: By default, the pipeline generates an RLSeq report (.html). If you only need the raw data files and want to save time, use the `--noreport` flag.

## Reference documentation
- [RLPipes GitHub Repository](./references/github_com_Bishop-Laboratory_RLPipes.md)
- [RLPipes Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rlpipes_overview.md)