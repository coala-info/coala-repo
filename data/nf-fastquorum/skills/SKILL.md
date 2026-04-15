---
name: fastquorum
description: The pipeline processes single-end, paired-end, or duplex sequencing FASTQ files using unique molecular indexes (UMIs) and a reference genome to generate filtered consensus reads and comprehensive quality control reports. Use when implementing fgbio best practices for UMI-based error correction in research or high-throughput production environments to improve the accuracy of downstream variant calling.
homepage: https://github.com/nf-core/fastquorum
---

# fastquorum

## Overview
nf-core/fastquorum implements the fgbio Best Practices FASTQ to Consensus Pipeline to produce high-accuracy consensus reads using unique molecular indexes (UMIs). It addresses the challenge of sequencing errors by grouping reads that originated from the same source molecule and calling a consensus sequence, which is particularly effective for detecting low-frequency variants.

The pipeline supports various data modalities including single UMI, multi-UMI, and Duplex Sequencing. Users can choose between a Research and Development (`rd`) mode for flexible parameter testing or a High Throughput (`ht`) mode optimized for production performance.

## Data preparation
The pipeline requires a comma-separated samplesheet and a reference genome. The samplesheet must include columns for sample identifiers, FASTQ file paths, and the fgbio-style read structure.

**Samplesheet columns:**
- `sample`: Unique identifier for the sample (no spaces).
- `fastq_1`: Path to the first FASTQ file (required).
- `fastq_2`: Path to the second FASTQ file (optional).
- `fastq_3`, `fastq_4`: Paths for additional index or UMI reads (optional).
- `read_structure`: String describing how bases are allocated (e.g., `5M2S+T 5M2S+T`).

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,read_structure
CONTROL_REP1,AEG588A1_R1.fastq.gz,AEG588A1_R2.fastq.gz,5M2S+T 5M2S+T
```

**Reference files:**
- Use `--genome` to specify an iGenomes identifier (e.g., `GRCh38`).
- Alternatively, provide a FASTA file via `--fasta`. The pipeline will automatically generate BWA indices and dictionary files if not provided.

## How to run
Run the pipeline using the `nextflow run` command. Specify the input samplesheet, reference genome, and an output directory. Use `-profile` to select the appropriate container engine (e.g., `docker` or `singularity`).

```bash
nextflow run nf-core/fastquorum \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --genome GRCh38 \
   --outdir ./results
```

**Key Parameters:**
- `--mode`: Set to `rd` (default) for flexibility or `ht` for performance.
- `--duplex_seq`: Enable this boolean flag when processing Duplex Sequencing data.
- `--call_min_reads`: Minimum number of reads required to call a consensus.
- `-resume`: Use this Nextflow flag to restart a pipeline from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include aligned consensus reads and quality metrics.

- `multiqc/`: The MultiQC report should be the first file inspected for a summary of QC metrics across all samples.
- `fgbio/`: Contains consensus BAM files and UMI grouping metrics.
- `samtools/`: Sorted and indexed BAM files.

For a complete description of the output structure and file formats, refer to the [official output documentation](https://nf-co.re/fastquorum/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)