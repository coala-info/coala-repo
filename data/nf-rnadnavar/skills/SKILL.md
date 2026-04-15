---
name: rnadnavar
description: This pipeline performs somatic mutation detection by integrating RNA and DNA sequencing data through parallelized alignment, variant calling with Mutect2, Strelka2, or SAGE, and consensus-based filtering. Use when analyzing cancer samples where RNA-seq provides additional evidence for somatic variants or when a consensus approach across multiple callers is required for high-confidence mutation discovery.
homepage: https://github.com/nf-core/rnadnavar
---

# rnadnavar

## Overview
nf-core/rnadnavar is a bioinformatics pipeline designed for somatic mutation detection using a combination of RNA and DNA sequencing data. It addresses the challenge of identifying high-confidence variants in cancer research by employing multiple variant calling algorithms and a consensus approach to filter out background noise, particularly in RNA data.

The pipeline processes raw reads or pre-aligned data, performs GATK-based preprocessing, and generates annotated somatic variants. Users receive comprehensive reports and filtered mutation files that facilitate downstream biological interpretation of somatic landscapes.

## Data preparation
The pipeline requires a comma-separated samplesheet (CSV) to define input files and metadata. RNA tumor samples must be associated with a DNA normal sample using the same patient ID.

**Samplesheet columns:**
- `patient`: Unique patient identifier.
- `sample`: Unique sample identifier.
- `status`: Sample type (0 for normal DNA, 1 for tumor DNA, 2 for tumor RNA).
- `lane`: Sequencing lane identifier (required for FASTQ input).
- `fastq_1`, `fastq_2`: Paths to paired-end FASTQ files.
- `bam`, `bai` / `cram`, `crai`: Paths to pre-aligned files and their indices.
- `caller`, `maf`: Required if starting from the `consensus` step.

**Example samplesheet (starting from mapping):**
```csv
patient,sample,status,lane,fastq_1,fastq_2
PT1,DNA_NORMAL,0,L1,DNA_N_R1.fastq.gz,DNA_N_R2.fastq.gz
PT1,DNA_TUMOUR,1,L1,DNA_T_R1.fastq.gz,DNA_T_R2.fastq.gz
PT1,RNA_TUMOUR,2,L1,RNA_T_R1.fastq.gz,RNA_T_R2.fastq.gz
```

Reference requirements include a FASTA genome, GTF/GFF annotations, and optional resource files like dbSNP, germline resources, or Panels of Normals (PoN).

## How to run
The pipeline is executed using Nextflow. You must specify the tools to be used for variant calling or annotation via the `--tools` parameter.

**Basic execution:**
```bash
nextflow run nf-core/rnadnavar \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results \
   --genome GRCh38 \
   --tools mutect2,strelka,vep,consensus
```

**Key parameters:**
- `--step`: Defines the entry point (e.g., `mapping`, `variant_calling`, `annotate`, `consensus`).
- `--tools`: Comma-separated list of tools (e.g., `mutect2`, `strelka`, `sage`, `vep`, `realignment`, `filtering`).
- `--wes`: Enable this flag when using exome or panel data to adjust tool settings for targeted sequencing.
- `-resume`: Use this Nextflow flag to restart a pipeline from the last successful process.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **MultiQC**: Combined quality control reports located in `multiqc/`.
- **Variant Calling**: VCF and MAF files from individual callers (e.g., Mutect2, Strelka2) and consensus results.
- **Annotation**: VEP-annotated variant files if annotation tools were enabled.
- **Preprocessing**: Alignment statistics from `samtools` and `mosdepth`.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/rnadnavar/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)