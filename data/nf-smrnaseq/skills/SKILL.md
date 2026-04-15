---
name: smrnaseq
description: This pipeline performs Small RNA-Seq analysis using single-end FASTQ inputs via a samplesheet, requiring reference genomes and miRNA databases like miRBase or MirGeneDB to produce quantification matrices, isomiR annotations, and quality reports. Use when analyzing small RNA data to identify known and novel miRNAs, quantify expression with edgeR or mirtop, and filter contaminants like rRNA or tRNA.
homepage: https://github.com/nf-core/smrnaseq
---

# smrnaseq

## Overview
The nf-core/smrnaseq pipeline provides a best-practice analysis for Small RNA-Seq data, addressing the complexities of miRNA discovery and quantification. It handles the processing of short reads, including adapter trimming, UMI deduplication, and filtering of non-target RNA species like rRNA or tRNA.

In practice, users provide raw sequencing data and specify a target species to receive comprehensive expression profiles. The pipeline generates normalized count tables, identifies isomiRs, and can discover novel miRNAs while providing extensive quality control metrics across the entire workflow.

## Data preparation
Input data must be organized in a CSV samplesheet. While the pipeline primarily processes single-end reads, the schema supports an optional second FASTQ column for paired-end data.

`samplesheet.csv` example:
```csv
sample,fastq_1
Control_1,s3://path/to/sample1_R1.fastq.gz
Treatment_1,s3://path/to/sample2_R1.fastq.gz
```

Reference requirements include:
*   **Reference Genome**: Specified via `--genome` (for iGenomes) or `--fasta` (for custom files).
*   **miRNA Databases**: miRBase is used by default, but MirGeneDB can be enabled with the `--mirgenedb` flag.
*   **Species Identifiers**: The `--mirtrace_species` parameter (e.g., `hsa`, `mmu`) is required for miRTrace quality control.
*   **Contamination Files**: Optional FASTA files for rRNA, tRNA, cDNA, ncRNA, or piRNA can be provided to filter out unwanted sequences.

## How to run
The pipeline requires a protocol-specific profile (such as `illumina`, `nextflex`, `qiaseq`, or `cats`) to correctly handle adapter trimming and UMI extraction. If no protocol is indicated, the pipeline may fail.

```bash
nextflow run nf-core/smrnaseq \
  -profile docker,illumina \
  --input samplesheet.csv \
  --genome GRCh38 \
  --mirtrace_species hsa \
  --outdir ./results
```

Key execution flags:
*   `-r`: Pin a specific pipeline release version for reproducibility.
*   `-resume`: Restart a run from the last completed step.
*   `--with_umi`: Enable UMI-based read deduplication.
*   `--skip_mirdeep`: Disable the discovery of novel miRNAs to reduce processing time.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary summary is the MultiQC report, which aggregates quality metrics from FastQC, fastp, and miRTrace.

Key output locations include:
*   `edgeR/`: Contains TMM-normalized counts, MDS plots, and heatmaps of sample similarities.
*   `mirtop/`: Provides miRNA and isomiR annotations and quantification.
*   `mirdeep2/`: Results for known and novel miRNA discovery (if not skipped).
*   `mirtrace/`: Detailed miRNA-specific quality control reports.

For a full description of result files and how to interpret them, refer to the official [output documentation](https://nf-co.re/smrnaseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)