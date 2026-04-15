---
name: sarek
description: The pipeline processes FASTQ, BAM, or CRAM inputs through alignment with BWA or DragMap and variant calling with tools like GATK, DeepVariant, or Mutect2 to produce annotated VCFs and comprehensive MultiQC reports. Use when analyzing whole genome or targeted sequencing data for germline or somatic variants, including tumor-normal pairs and relapses, across human, mouse, or other species with a reference genome.
homepage: https://github.com/nf-core/sarek
---

# sarek

## Overview
nf-core/sarek is a comprehensive workflow for detecting variants in whole genome or targeted sequencing data. It handles germline analysis as well as somatic analysis of tumor/normal pairs, supporting various species beyond its initial human and mouse focus.

The pipeline manages the full analysis lifecycle from raw reads or pre-aligned BAMs to annotated variant calls. It integrates quality control, read trimming, alignment, post-alignment processing, and multiple variant calling algorithms for SNPs, indels, structural variants, and copy-number changes.

## Data preparation
Input is defined via a samplesheet (CSV, TSV, YAML, or JSON) containing metadata and file paths. For FASTQ input, each row represents a sequencing lane for a sample.

Minimal `samplesheet.csv` example:
```csv
patient,sample,lane,fastq_1,fastq_2,sex,status
ID1,S1,L001,ID1_S1_L001_R1.fastq.gz,ID1_S1_L001_R2.fastq.gz,XY,0
ID1,T1,L001,ID1_T1_L001_R1.fastq.gz,ID1_T1_L001_R2.fastq.gz,XY,1
```

*   **patient**: Unique identifier for the individual.
*   **sample**: Unique identifier for the sample (e.g., normal, tumor).
*   **status**: 0 for normal, 1 for tumor.
*   **sex**: XX, XY, or NA.
*   **lane**: Identifier to distinguish different sequencing runs.

Reference requirements include a FASTA genome, FAI index, and dictionary file. For targeted sequencing (WES/Panels), a BED file must be provided via `--intervals` and the `--wes` flag should be enabled.

## How to run
Run the pipeline by specifying the input samplesheet and a configuration profile. Use `--tools` to select specific variant callers (e.g., `haplotypecaller`, `mutect2`, `strelka`).

```bash
nextflow run nf-core/sarek \
  -r 3.5.0 \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  --genome GATK.GRCh38 \
  --tools haplotypecaller,mutect2
```

*   **--step**: Start from `mapping` (default), `markduplicates`, `prepare_recalibration`, `recalibrate`, `variant_calling`, or `annotate`.
*   **--wes**: Enable for exome or panel data.
*   **--intervals**: Path to BED or interval list for parallelization and targeting.
*   **-resume**: Restart a previous run from the last successful step.

## Outputs
Results are organized within the directory specified by `--outdir`.

*   `multiqc/`: Integrated quality control reports; open `multiqc_report.html` first.
*   `preprocessing/`: Mapped reads in CRAM (default) or BAM format.
*   `variant_calling/`: VCF files from selected callers, organized by tool and patient.
*   `annotation/`: Annotated VCFs if `--tools snpeff` or `--tools vep` was used.

Detailed output descriptions are available in the [official documentation](https://nf-co.re/sarek/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/abstracts/2016-09-KICR.md`](references/docs/abstracts/2016-09-KICR.md)
- [`references/docs/abstracts/2017-05-ESHG.md`](references/docs/abstracts/2017-05-ESHG.md)
- [`references/docs/abstracts/2018-05-PMC.md`](references/docs/abstracts/2018-05-PMC.md)
- [`references/docs/abstracts/2018-06-EACR25.md`](references/docs/abstracts/2018-06-EACR25.md)
- [`references/docs/abstracts/2018-06-NPMI.md`](references/docs/abstracts/2018-06-NPMI.md)
- [`references/docs/abstracts/2018-07-JOBIM.md`](references/docs/abstracts/2018-07-JOBIM.md)
- [`references/docs/abstracts/2020-06-ESHG.md`](references/docs/abstracts/2020-06-ESHG.md)
- [`references/docs/abstracts/2020-10-VCBS.md`](references/docs/abstracts/2020-10-VCBS.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/variantcalling/interpretation.md`](references/docs/usage/variantcalling/interpretation.md)
- [`references/docs/usage/variantcalling/introduction.md`](references/docs/usage/variantcalling/introduction.md)
- [`references/docs/usage/variantcalling/sarek.md`](references/docs/usage/variantcalling/sarek.md)
- [`references/docs/usage/variantcalling/theory.md`](references/docs/usage/variantcalling/theory.md)