---
name: rnafusion
description: This pipeline detects and visualizes fusion genes from RNA-seq data using multiple callers like Arriba, STAR-Fusion, and FusionCatcher, accepting FASTQ, BAM, or CRAM inputs alongside a GRCh38 reference. Use when analyzing human RNA-seq datasets for oncogenic fusions or splicing aberrations, particularly when high-confidence consensus across multiple detection tools is required.
homepage: https://github.com/nf-core/rnafusion
---

## Overview
nf-core/rnafusion is a bioinformatics analysis pipeline designed for the comprehensive detection and visualization of fusion genes from RNA sequencing data. It integrates several specialized tools to identify fusion events, provides transcript assembly with StringTie, and detects cancer-related splicing aberrations via CTAT-SPLICING.

The pipeline processes raw or aligned reads to produce aggregated results, most notably a PDF visualization document for manual inspection, a VCF file for data integration, and summary reports in HTML and TSV formats. It is specifically optimized for the GRCh38 human reference genome and benefits significantly from paired-end sequencing data.

## Data preparation
The pipeline requires a samplesheet (CSV, YAML, or JSON) and a set of reference files. The samplesheet must contain at least a `sample` ID and `strandedness` (forward, reverse, unstranded, or unknown), along with paths to data files.

**Samplesheet structure:**
The CSV should include headers for the data types being provided:
- `sample,fastq_1,fastq_2,strandedness` (for raw reads)
- `sample,bam,bai,strandedness` (for aligned BAMs)

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,strandedness
sample1,sample1_1.fastq.gz,sample1_2.fastq.gz,reverse
sample2,sample2.bam,,forward
```

**References:**
The pipeline only supports the GRCh38 reference. Users must provide a path to a reference folder using `--genomes_base`. These references can be downloaded from the nf-core AWS S3 bucket or built locally using the `--references_only` flag. Note that Fusioncatcher and Arriba references cannot be built automatically and must be provided manually or downloaded.

## How to run
The pipeline should be run using Nextflow with Docker or Singularity, as Conda is not supported. Use the `--tools` parameter to specify which fusion callers to execute (e.g., `arriba,starfusion,fusioncatcher`).

```bash
nextflow run nf-core/rnafusion \
   -r 3.0.1 \
   -profile <docker/singularity> \
   --input samplesheet.csv \
   --outdir ./results \
   --genomes_base /path/to/references \
   --tools arriba,starfusion
```

To build references before a full analysis run:
```bash
nextflow run nf-core/rnafusion \
   -profile <docker/singularity> \
   --references_only \
   --genomes_base /path/to/references
```

Use `-resume` to restart a run from the last successful step and `-stub` for testing setup with dummy files.

## Outputs
Results are saved in the directory specified by `--outdir`. Key deliverables include:
- `multiqc/`: Quality control reports for raw reads and alignment metrics.
- `fusion_report/`: Aggregated HTML and TSV reports containing fusions detected by multiple tools.
- `fusioninspector/`: Detailed fusion evidence and visualization.
- `vcf/`: A summarized VCF file containing detected fusion events.
- `visualisation/`: PDF documents for visual inspection of fusion candidates (primarily from Arriba).

For a complete list of output files and their formats, refer to the official [output documentation](https://nf-co.re/rnafusion/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
