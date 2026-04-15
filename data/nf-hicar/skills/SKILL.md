---
name: hicar
description: Processes paired-end FASTQ files and reference annotations to analyze HiCAR, HiChIP, or ChIA-PET data, generating chromatin contact maps, ATAC-seq peak calls from R2 reads, and genomic interaction loops. Use when investigating simultaneous chromatin accessibility and cis-regulatory interactions, especially for low-input samples or when antibodies for IP-based methods are unavailable.
homepage: https://github.com/nf-core/hicar
---

# hicar

## Overview
nf-core/hicar is designed for HiC on Accessible Regulatory DNA (HiCAR) data, a method that combines Transposase-Accessible Chromatin assays with Hi-C to map regulatory interactions without antibodies. It provides a comprehensive suite for mapping reads, filtering pairs, and calling peaks, loops, TADs, and A/B compartments.

The pipeline produces standard interaction formats like `.mcool` and `.hic` for visualization, alongside statistical reports and annotated loop calls. It is also compatible with related assays like HiChIP and PLAC-Seq if provided with appropriate anchor peaks.

## Data preparation
The pipeline requires a samplesheet (CSV, TSV, or YAML) and reference genome information. The samplesheet must contain columns for group, replicate, and the paths to paired-end FASTQ files.

Example `samplesheet.csv`:
```csv
group,replicate,fastq_1,fastq_2
CONTROL,1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Reference requirements:
*   **Genome**: Specify a genome using `--genome` (e.g., `GRCh38`) or provide paths to `--fasta` and `--gtf` (or `--gff`).
*   **Mappability**: A bigWig file provided via `--mappability` is highly recommended to avoid memory-intensive calculations.
*   **Enzymes**: The default digestion enzyme is `CviQI`. Other supported enzymes include `MboI`, `DpnII`, `BglII`, `HindIII`, and `MseI`.
*   **Anchor Peaks**: If running non-HiCAR methods like HiChIP, provide a peak file via `--anchor_peaks` in `.narrowPeak` or `.broadPeak` format.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific version with `-r` and a container profile.

```bash
nextflow run nf-core/hicar \
    -profile docker \
    --input samplesheet.csv \
    --genome GRCh38 \
    --outdir ./results
```

Key parameters:
*   `--method`: Set to `HiCAR` (default), `HiChIP`, `ChIA-PET`, or `PLAC-Seq`.
*   `--interactions_tool`: Choose between `maps` (default), `hicdcplus`, or `peakachu`.
*   `--qval_thresh`: Set the FDR cutoff for MACS2 peak calling (default: 0.01).
*   `--res_tads`: Set the resolution for TAD calling (default: 10000).
*   `-resume`: Use this flag to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. 

*   **MultiQC**: The `multiqc/` folder contains the primary HTML report summarizing QC metrics from FastQC, cutadapt, and pairtools.
*   **Contact Maps**: Interaction matrices are provided in `.mcool` (Cooler) and `.hic` (Juicer) formats for visualization in Higlass or Juicebox.
*   **Analysis Results**: Includes peak calls from MACS2, loop/interaction calls, TAD boundaries, and A/B compartment files.
*   **Visualization**: Circos plots and virtual 4C tracks may be generated depending on parameters.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/hicar/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)