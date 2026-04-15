---
name: crisprseq
description: This pipeline analyzes CRISPR edited data from targeted NGS or pooled screening experiments, processing FASTQ inputs to perform edit calling, UMI clustering, or gene ranking using tools like MAGeCK and BAGEL2. Use when evaluating the quality of gene editing experiments (KO, KI, BE, PE) or discovering essential genes from large-scale CRISPR-Cas9 screens.
homepage: https://github.com/nf-core/crisprseq
---

# crisprseq

## Overview
nf-core/crisprseq is a bioinformatics pipeline designed for the analysis of CRISPR gene editing experiments. It supports two distinct analysis modes: `targeted` for evaluating specific genomic edits such as knockouts, knock-ins, base editing, and prime editing, and `screening` for identifying essential genes in pooled CRISPR-Cas9, CRISPRa, or CRISPRi screens.

The pipeline processes raw sequencing data to produce comprehensive reports on editing efficiency or gene essentiality. It integrates quality control, alignment to reference genomes or libraries, and statistical modeling to provide reproducible results across various compute environments using Nextflow and containerization.

## Data preparation
Input requires a CSV samplesheet specified with the `--input` parameter. The structure of the samplesheet depends on the analysis mode chosen.

For **targeted** analysis, the samplesheet must include columns for sample names, FASTQ files, and DNA sequences for the reference, protospacer, and template:
```csv
sample,fastq_1,fastq_2,reference,protospacer,template
SAMPLE1,SAMPLE1_R1.fastq.gz,SAMPLE1_R2.fastq.gz,ACTG,ACTG,ACTG
```

For **screening** analysis, the samplesheet requires sample names, FASTQ files, and experimental conditions:
```csv
sample,fastq_1,fastq_2,condition
SAMPLE1,SAMPLE1_R1.fastq.gz,SAMPLE1_R2.fastq.gz,control
```

Additional requirements:
- **Reference Genome:** Specify a reference FASTA via `--reference_fasta` or use an iGenomes identifier with `--genome`.
- **Screening Library:** A tab-separated library file (`--library`) containing sgRNA and targeting genes is required for screening mode.
- **UMIs:** If using UMI molecular identifiers, the `--umi_clustering` parameter must be enabled.

## How to run
The pipeline is executed using `nextflow run`. You must specify the analysis mode using the `--analysis` flag.

```bash
nextflow run nf-core/crisprseq \
  --input samplesheet.csv \
  --analysis targeted \
  --outdir <OUTDIR> \
  -profile <docker/singularity/conda>
```

Key parameters:
- `--analysis`: Set to either `targeted` or `screening`.
- `--outdir`: Path to the results directory.
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `test`).
- `-r`: Pin a specific pipeline release version.
- `-resume`: Restart a run from the last cached step.

Note: When using Apptainer or Singularity for screening, you may need to set `export NXF_SINGULARITY_HOME_MOUNT=true` to allow MAGeCKFlute write access to the HOME directory.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- **MultiQC Report:** An aggregate quality control report located in the `multiqc/` folder, which should be the first file inspected.
- **Targeted Results:** Edit calling reports, CIGAR parsing results, and optional UMI consensus sequences.
- **Screening Results:** sgRNA and gene rankings, count tables, and optional hit selection visualizations.
- **Alignment Files:** Mapped reads in BAM format from aligners like `minimap2`, `bwa`, or `bowtie2`.

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/crisprseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/output/screening.md`](references/docs/output/screening.md)
- [`references/docs/output/targeted.md`](references/docs/output/targeted.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/screening.md`](references/docs/usage/screening.md)
- [`references/docs/usage/targeted.md`](references/docs/usage/targeted.md)