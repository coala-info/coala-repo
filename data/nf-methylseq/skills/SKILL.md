---
name: methylseq
description: This pipeline processes raw bisulfite-treated or TAPS sequencing data from FastQ inputs using aligners like Bismark or bwa-meth to generate methylation call strings, deduplicated BAM files, and comprehensive quality control reports. Use when analyzing DNA methylation patterns across various library types including RRBS, PBAT, EM-seq, or single-cell bisulfite sequencing to identify cytosine modification states.
homepage: https://github.com/nf-core/methylseq
---

## Overview
nf-core/methylseq is a bioinformatics analysis pipeline used for Methylation (Bisulfite) sequencing data. It provides a standardized workflow that pre-processes raw data from FastQ inputs, performs read alignment, and executes extensive quality control. The pipeline supports multiple alignment strategies, including the default Bismark (using Bowtie2 or HISAT2), bwa-meth with MethylDackel, and specialized TAPS data processing using BWA-Mem and rastair.

The workflow is designed to handle various biological and technical contexts, such as TET-assisted pyridine borane sequencing (TAPS), Reduced Representation Bisulfite Sequencing (RRBS), and Post Bisulfite Adapter Tagging (PBAT). It produces actionable results including methylation bias plots, strand-specific cytosine reports, and integrated MultiQC summaries to evaluate the success of the sequencing run and library preparation.

## Data preparation
The pipeline requires a comma-separated samplesheet and a reference genome. The samplesheet must contain a header and define sample names and paths to FastQ files.

*   **Samplesheet format**: A CSV file with columns `sample`, `fastq_1`, `fastq_2`, and `genome`.
*   **Reference Genome**: Specify a reference using iGenomes (`--genome <ID>`) or provide a FASTA file (`--fasta <path>`). If using bwa-meth, a FASTA index (`.fai`) is also required.
*   **Library Presets**: Specific flags adjust trimming and alignment for different kits:
    *   `--rrbs`: For MspI digested material; skips deduplication.
    *   `--pbat`: For Post Bisulfite Adapter Tagging; sets specific trimming and alignment flags.
    *   `--em_seq`: For EM-seq libraries with 10bp clipping.
    *   `--taps`: For TAPS libraries.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,genome
SRR389222_sub1,SRR389222_sub1.fastq.gz,,
Ecoli_paired,Ecoli_R1.fastq.gz,Ecoli_R2.fastq.gz,
```

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific release version with `-r` and a container profile like `docker` or `singularity`.

```bash
# Default run with Bismark
nextflow run nf-core/methylseq \
    --input samplesheet.csv \
    --outdir ./results \
    --genome GRCh38 \
    -profile docker

# Run using the bwa-meth aligner
nextflow run nf-core/methylseq \
    --input samplesheet.csv \
    --outdir ./results \
    --genome GRCh38 \
    --aligner bwameth \
    -profile docker

# Run with TAPS preset and BWA-Mem
nextflow run nf-core/methylseq \
    --input samplesheet.csv \
    --outdir ./results \
    --genome GRCh38 \
    --aligner bwamem \
    --taps \
    -profile docker
```

Use `-resume` to continue a previous run from the last successful step.

## Outputs
Results are organized within the directory specified by `--outdir`.

*   **MultiQC**: Aggregated quality control reports found in `multiqc/`. This is the primary file to review for run-wide statistics.
*   **Methylation Calls**: Depending on the aligner, results are stored in `bismark/methylation_calls/` or `methyldackel/`. These include bedGraph and coverage files.
*   **Alignments**: Deduplicated BAM files and alignment logs.
*   **Reports**: Bismark-specific HTML reports and M-bias plots for assessing methylation bias across read lengths.

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/methylseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/bs-seq-primer.md`](references/docs/usage/bs-seq-primer.md)
