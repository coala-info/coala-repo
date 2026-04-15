---
name: longraredisease
description: This pipeline performs structural variant detection, phasing, and clinical interpretation from Oxford Nanopore or PacBio long-read sequencing data using a multi-caller consensus approach. Use when analyzing rare disease cases requiring high-confidence variant discovery through family-based joint calling and phenotype-driven prioritization using HPO terms.
homepage: https://github.com/nf-core/longraredisease
---

# longraredisease

## Overview
nf-core/longraredisease addresses the challenge of identifying complex genetic causes in rare disease diagnostics by leveraging the superior resolution of long-read sequencing. It integrates multiple structural variant (SV) callers to produce a high-confidence consensus, while optionally incorporating single nucleotide variants, copy number variants, and methylation data to provide a comprehensive genomic profile.

The pipeline transforms raw or aligned sequencing data into prioritized clinical reports by cross-referencing variants against disease databases and patient phenotypes. Users receive annotated variant files and quality control metrics that facilitate the identification of pathogenic de novo or inherited mutations within family trios.

## Data preparation
The pipeline requires a CSV samplesheet and a reference genome FASTA file. For clinical prioritization, external databases for AnnotSV and SVANNA must be provided.

**Samplesheet Columns:**
- `sample`: Unique sample identifier.
- `bam`: Path to aligned BAM file (or FASTQ/uBAM depending on `--input_type`).
- `bai`: Path to BAM index file.
- `family`: Family identifier for trio analysis.
- `paternal_id` / `maternal_id`: Parental sample IDs (use `0` if not in study).
- `sex`: `1`=male, `2`=female, `0`=unknown.
- `phenotype`: `affected` or `unaffected`.
- `hpo_terms`: Comma-separated HPO terms (e.g., "HP:0001250,HP:0002066").

**Minimal Samplesheet Example:**
```csv
sample,bam,bai
sample1,/path/to/sample1.bam,/path/to/sample1.bam.bai
sample2,/path/to/sample2.bam,/path/to/sample2.bam.bai
```

**Trio Samplesheet Example:**
```csv
sample,bam,bai,family,paternal_id,maternal_id,sex,phenotype,hpo_terms
proband,proband.bam,proband.bam.bai,fam1,father,mother,1,affected,"HP:0001250"
father,father.bam,father.bam.bai,fam1,0,0,1,unaffected,
mother,mother.bam,mother.bam.bai,fam1,0,0,2,unaffected,
```

## How to run
Run the pipeline using `nextflow run`. Specify the sequencing platform (`ont`, `pacbio`, or `hifi`) to ensure correct tool presets are applied.

**Standard SV Analysis:**
```bash
nextflow run nf-core/longraredisease \
    --input samplesheet.csv \
    --outdir results \
    --fasta reference.fasta \
    --sequencing_platform ont \
    -profile docker
```

**Trio Analysis with Phenotype Prioritization:**
```bash
nextflow run nf-core/longraredisease \
    --input trio_samplesheet.csv \
    --outdir results \
    --fasta reference.fasta \
    --sequencing_platform ont \
    --trio_analysis true \
    --run_svanna true \
    --svanna_db /path/to/svanna_db \
    --annotsv_db /path/to/annotsv_db \
    -profile docker
```

**Enabling Optional Modules:**
Use `--snv true`, `--cnv true`, `--str true`, or `--methyl true` to enable additional variant calling and methylation profiling.

## Outputs
Results are saved in the directory specified by `--outdir`.

- `pipeline_info/multiqc_report.html`: Comprehensive quality control report including alignment and variant metrics.
- `structural_variants/merged/`: High-confidence consensus SV calls in VCF format (Jasmine/Survivor).
- `structural_variants/annotated/`: Clinical annotations from AnnotSV including gene overlaps and population frequencies.
- `structural_variants/svanna/`: HTML reports ranking variants by their relevance to the provided HPO terms.
- `phasing/haplotagged_bams/`: BAM files with haplotype tags for visual inspection of phased variants.
- `qc/`: Detailed metrics from NanoPlot, mosdepth, and cramino.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)