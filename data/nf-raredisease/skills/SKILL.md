---
name: raredisease
description: This pipeline performs comprehensive variant calling and scoring for SNVs, SVs, CNVs, and repeat expansions from WGS, WES, or mitochondrial data using Illumina paired-end FASTQ or BAM inputs. Use when investigating rare genetic disorders to identify potentially causative variants through a clinical-grade workflow that supports pedigree information and extensive annotation via VEP and CADD.
homepage: https://github.com/nf-core/raredisease
---

## Overview
nf-core/raredisease is a bioinformatic pipeline designed for the analysis of whole genome or whole exome sequencing data from rare disease patients. It automates the process of alignment, variant calling, and clinical prioritization, heavily inspired by the Mutation Identification Pipeline (MIP).

The workflow handles nuclear and mitochondrial analysis, providing researchers and clinicians with a prioritized list of variants based on frequency, conservation, and predicted impact. It requires paired-end Illumina data and supports both GRCh37 and GRCh38 reference builds, delivering annotated VCFs and comprehensive quality control reports.

## Data preparation
The pipeline requires a samplesheet and a set of reference files. The samplesheet is a CSV file that defines the input data and pedigree information.

**Samplesheet requirements:**
- `sample`: Unique sample identifier.
- `lane`: Sequencing lane number.
- `fastq_1`, `fastq_2`: Paths to paired-end FASTQ files (or `bam`/`bai` for existing alignments).
- `sex`: 1 (male), 2 (female), or 0 (unknown).
- `phenotype`: 1 (unaffected) or 2 (affected).
- `paternal_id`, `maternal_id`: IDs of parents (use 0 if unknown).
- `case_id`: Identifier for the family or case group.

Example `samplesheet.csv`:
```csv
sample,lane,fastq_1,fastq_2,sex,phenotype,paternal_id,maternal_id,case_id
child1,1,c1_R1.fastq.gz,c1_R2.fastq.gz,1,2,father1,mother1,family1
father1,1,f1_R1.fastq.gz,f1_R2.fastq.gz,1,1,0,0,family1
mother1,1,m1_R1.fastq.gz,m1_R2.fastq.gz,2,1,0,0,family1
```

**Reference files:**
Mandatory parameters include `--fasta`, `--intervals_wgs`, and `--intervals_y`. For full clinical annotation, users should provide paths to a VEP cache (`--vep_cache`), CADD resources (`--cadd_resources`), and variant scoring configurations for GENMOD.

## How to run
The pipeline is executed using Nextflow with a specified profile and input samplesheet. It is recommended to use `-r` to pin a specific version and `-resume` for incremental runs.

```bash
nextflow run nf-core/raredisease \
   -profile docker \
   -r 2.1.0 \
   --input samplesheet.csv \
   --outdir ./results \
   --genome GRCh38
```

**Key Parameters:**
- `--analysis_type`: Set to `wgs` (default), `wes`, or `mito` to adjust tool selection.
- `--variant_caller`: Choose between `deepvariant` (default) or `sentieon`.
- `--aligner`: Choose between `bwamem2` (default), `bwa`, `bwameme`, or `sentieon`.
- `--skip_tools`: Disable specific modules like `vcf2cytosure` or `gens` if not required.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter.

- **MultiQC:** The `multiqc/` folder contains the `multiqc_report.html` file, which should be the first file inspected for data quality and alignment metrics.
- **Variants:** Annotated and ranked VCF files are located in the subfolders for SNV and SV calling.
- **Reports:** Quality metrics from FastQC, Mosdepth, and Picard are provided to evaluate coverage and library complexity.

For a complete description of the directory structure and file contents, refer to the official [output documentation](https://nf-co.re/raredisease/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
