---
name: genomicrelatedness
description: This pipeline estimates genetic relatedness from low-coverage whole-genome sequencing data using FASTQ, SPRING, BAM, or CRAM inputs alongside a FASTA reference to produce genotype likelihoods and relatedness metrics. Use when analyzing non-model organisms or sparse data lacking high-confidence variant sets, as the workflow includes an automated bootstrapping process to iteratively refine SNPs for robust inference.
homepage: https://github.com/nf-core/genomicrelatedness
---

# genomicrelatedness

## Overview
nf-core/genomicrelatedness is designed for estimating genetic relatedness from low-coverage whole-genome sequencing (sWGS) data. It addresses the challenge of analyzing non-model organisms where high-confidence variant sets are often missing by providing an automated multi-round bootstrapping workflow to generate and refine them.

The pipeline handles the full analysis lifecycle from read mapping and base quality score recalibration to joint variant calling and multi-tool relatedness estimation. It produces standardized VCF files and comparative relatedness metrics from algorithms like NGSrelate, READ, and BREADR, enabling robust biological inference even from very sparse genomic data.

## Data preparation
The pipeline requires a CSV samplesheet and a reference genome.

**Samplesheet requirements:**
The CSV must contain a `sample` column and at least one data source column (`fastq_1`, `spring_1`, `bam`, or `cram`). Optional read-group information can be provided via `RGID`, `RGLB`, `RGPL`, `RGPU`, and `RGSM` columns.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
CONTROL_REP2,AEG588A1_S1_L003_R1_001.fastq.gz,AEG588A1_S1_L003_R2_001.fastq.gz
```

**Reference files:**
- A FASTA reference genome is required via `--fasta`.
- The pipeline automatically generates BWA-MEM2 indices, FASTA indices (.fai), and sequence dictionaries (.dict) if they are not provided via `--bwamem2_index`, `--fasta_fai`, or `--dict`.
- If a known variant set is available, provide it using `--known_variants_vcf` (and optionally `--known_variants_tbi`) to enable Base Quality Score Recalibration (BQSR).

## How to run
Run the pipeline by specifying the input samplesheet, reference genome, and an output directory. If no known variant set is provided, you must specify the number of bootstrapping rounds.

```bash
nextflow run nf-core/genomicrelatedness \
   -profile docker \
   --input samplesheet.csv \
   --fasta reference.fasta \
   --bootstrapping_rounds 1 \
   --outdir results
```

Key parameters:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`).
- `--bootstrapping_rounds`: An integer between 1 and 3 to generate a variant set if `--known_variants_vcf` is not used.
- `--include_scaffolds` / `--exclude_scaffolds`: Filter analysis to specific genomic regions.
- `-resume`: Use this to restart a pipeline run from the last successful step.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter.

- `multiqc/`: Contains the MultiQC report (`multiqc_report.html`), which should be the first file inspected for quality metrics across all stages.
- `variant_calling/`: Contains VCF files from GATK HaplotypeCaller and BCFtools, including joint discovery results.
- `relatedness/`: Contains relatedness estimates and metrics from tools such as NGSrelate, READ, and BREADR.
- `preprocessing/`: Contains aligned and indexed CRAM/BAM files.

For a complete description of the directory structure and file formats, refer to the official [output documentation](https://nf-co.re/genomicrelatedness/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)