---
name: coproid
description: This pipeline identifies the biological source of Illumina sequenced faecal samples by analyzing microbiome composition and endogenous host DNA using FASTQ inputs, reference genomes, and Kraken2 databases. Use when analyzing ancient or modern coprolites to distinguish between potential host species through combined host-DNA mapping ratios and machine learning-based metagenomic taxonomic profiling.
homepage: https://github.com/nf-core/coproid
---

# coproid

## Overview
nf-core/coproid (COPROlite host IDentification) solves the problem of identifying the "true maker" of faecal samples, particularly in archaeological contexts where host DNA may be degraded or contaminated. It integrates host DNA mapping against multiple candidate genomes with metagenomic profiling to provide a robust prediction of the sample's origin.

Users provide raw sequencing reads and a set of candidate host genomes. The pipeline calculates a host-DNA species ratio and estimates the host source from the microbial community structure using machine learning, ultimately producing a combined report that reconciles these two lines of evidence to predict the most likely host.

## Data preparation
The pipeline requires two primary CSV files and several external databases.

**Samplesheet**
A CSV file containing the paths to your FASTQ files.
```csv
sample,fastq_1,fastq_2
PAIRED_END,PAIRED_END_S1_L002_R1_001.fastq.gz,PAIRED_END_S1_L002_R2_001.fastq.gz
SINGLE_END,SINGLE_END_S4_L003_R1_001.fastq.gz,
```

**Genomesheet**
A CSV file containing reference genome information. Reference genomes must be from NCBI so that `sam2lca` can extract the taxid.
```csv
genome_name,taxid,genome_size,igenome,fasta,index
Escherichia_coli,562,5000000,,genome.fa,
```

**Required External Files**
*   **Kraken2 Database:** A directory or `.tar.gz` file provided via `--kraken2_db`.
*   **Sourcepredict Files:** A TAXID count table (`--sp_sources`) and a labels file (`--sp_labels`) in CSV format.
*   **Taxonomy Databases:** For offline runs, you may need to provide `--sam2lca_db`, `--taxa_sqlite`, and `--taxa_sqlite_traverse_pkl`.

## How to run
Run the pipeline using the `nextflow run` command. You must specify the input sheets, the Kraken2 database, and the Sourcepredict reference files.

```bash
nextflow run nf-core/coproid \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --genome_sheet genomesheet.csv \
   --kraken2_db 'PATH/TO/KRAKENDB' \
   --sp_sources 'PATH/TO/SOURCEPREDICT/SOURCES/FILE' \
   --sp_labels 'PATH/TO/SOURCEPREDICT/LABELS/FILE' \
   --outdir <OUTDIR>
```

Use `-resume` to restart a run from the last cached step. Pipeline parameters should be provided via the CLI or a `-params-file`; do not use `-c` for pipeline-specific parameters.

## Outputs
Results are saved in the directory specified by `--outdir`.

*   **Quarto Report:** A comprehensive report containing the final sample results and host predictions.
*   **MultiQC:** An aggregate report (`multiqc_report.html`) summarizing quality control metrics from FastQC, fastp, Bowtie2, and Kraken2.
*   **Analysis Results:** Includes host-DNA species ratios, ancient DNA damage estimations (pyDamage/DamageProfiler), and metagenomic taxonomic profiles.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/coproid/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)