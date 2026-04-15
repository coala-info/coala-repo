---
name: rnasplice
description: This pipeline performs alternative splicing analysis from RNA-seq data using FASTQ, BAM, or Salmon results alongside reference genome annotations and a contrasts sheet. Use when identifying differential exon usage, differential transcript usage, or event-based splicing variations across experimental conditions in organisms with a reference genome.
homepage: https://github.com/nf-core/rnasplice
---

# rnasplice

## Overview
nf-core/rnasplice is designed for the comprehensive analysis of alternative splicing in RNA-seq datasets. It addresses the complexity of transcriptomic variation by offering multiple analysis paths, including exon-level, transcript-level, and event-based splicing detection.

The pipeline processes raw sequencing reads or intermediate alignment files to generate quantification data and statistical comparisons between conditions. Users receive detailed reports on splicing events, such as skipped exons or intron retention, along with quality control metrics to validate the results.

## Data preparation
The pipeline requires a samplesheet (CSV) and a contrastsheet (CSV). The samplesheet must define the sample names, FASTQ file paths, library strandedness (`forward`, `reverse`, or `unstranded`), and experimental conditions.

`samplesheet.csv` example:
```csv
sample,fastq_1,fastq_2,strandedness,condition
CONTROL_REP1,ctrl_1_R1.fastq.gz,ctrl_1_R2.fastq.gz,forward,CONTROL
TREAT_REP1,treat_1_R1.fastq.gz,treat_1_R2.fastq.gz,forward,TREATED
```

Technical replicates with the same sample identifier are automatically merged. For reference data, provide a genome name via `--genome` (e.g., `GRCh38`) or paths to `--fasta` and `--gtf` (or `--gff`). If performing differential analysis, a `--contrasts` file is mandatory to define the comparisons.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to use a specific version with `-r` and a container profile like `-profile docker` or `-profile singularity`.

```bash
nextflow run nf-core/rnasplice \
   -r 1.0.0 \
   --input samplesheet.csv \
   --contrasts contrastsheet.csv \
   --genome GRCh38 \
   --outdir ./results \
   -profile docker
```

Key parameters include `--source` to specify input types (default is `fastq`, but supports `genome_bam`, `transcriptome_bam`, or `salmon_results`) and specific workflow flags like `--rmats`, `--dexseq_exon`, or `--suppa` to enable different splicing analysis modules. Use `-resume` to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary summary of the run, including alignment statistics and tool-specific QC, is found in the `multiqc/` folder.

Key deliverables include:
- Quantification matrices from STAR, Salmon, or featureCounts.
- Differential splicing results from DEXSeq, edgeR, rMATS, or SUPPA2 depending on the enabled modules.
- Optional sashimi plots for visualizing splicing events using MISO.
- BigWig coverage files for genome browser visualization (if not skipped).

For a complete list of output files, refer to the official [output documentation](https://nf-co.re/rnasplice/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)