---
name: hgtseq
description: This pipeline identifies horizontal gene transfer by performing metagenomic classification of paired-read alignments against a reference genome, requiring a CSV samplesheet, FASTQ or BAM files, and Kraken2/Krona databases to produce taxonomic reports and integration site inferences. Use when investigating the presence of non-host microbial sequences and potential host genome integration sites in NGS data where host-microbe interactions are suspected.
homepage: https://github.com/nf-core/hgtseq
---

## Overview
nf-core/hgtseq is designed to investigate horizontal gene transfer (HGT) events using next-generation sequencing data. It identifies non-host microbial sequences within read pairs and infers potential integration sites into the host genome by analyzing alignments against a reference.

The pipeline processes raw sequencing reads or existing alignments to perform taxonomic classification and quality control. It provides a comprehensive view of microbial presence and its relationship to the host genetic material through detailed reports and visualization tools like Krona and MultiQC.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file must contain a header and columns for the sample name and read files.

```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Key requirements and constraints:
- **Input Format**: If input files are BAMs instead of FASTQs, you must set the `--isbam` flag.
- **Reference Genome**: Specify a reference via `--genome` (e.g., GRCh38) or provide `--fasta` and `--gff` files.
- **Databases**: You must provide paths to a Kraken2 database (`--krakendb`) and a Krona taxonomy file (`--kronadb`).
- **Metadata**: A numeric NCBI taxonomy ID for the samples is required via the `--taxonomy_id` parameter.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to use a container profile such as `-profile docker` or `-profile singularity` for reproducibility.

```bash
nextflow run nf-core/hgtseq \
    --input samplesheet.csv \
    --outdir ./results \
    --genome GRCh38 \
    --taxonomy_id 9606 \
    --krakendb /path/to/kraken_db \
    --kronadb /path/to/krona_db/taxonomy.tab \
    -profile docker
```

Use `-r` to pin a specific pipeline release and `-resume` to continue a previous run from the last successful process. You can choose between `bwa-mem` or `bwa-mem2` using the `--aligner` parameter.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary results to inspect include:
- **MultiQC**: A summary report located in the output directory containing quality control metrics and Kraken2 classification summaries.
- **Krona**: Interactive HTML plots for visualizing taxonomic distributions.
- **Analysis Report**: An HTML report generated via RMarkdown providing a summary of the HGT analysis.

For a complete description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/hgtseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
