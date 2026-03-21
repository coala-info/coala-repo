---
name: nf-core-chipseq
description: This pipeline processes single-end or paired-end ChIP-seq FASTQ data using a CSV samplesheet and reference genome to generate aligned BAM files, normalized bigWig tracks, and annotated MACS3 peak sets. Use when identifying transcription factor binding sites or histone modifications across experimental conditions, especially when requiring integrated quality control via MultiQC and differential binding analysis with DESeq2.
homepage: https://github.com/nf-core/chipseq
---

## Overview
nf-core/chipseq is a bioinformatics analysis pipeline used for Chromatin ImmunoPrecipitation sequencing (ChIP-seq) data. It automates the identification of genomic regions where proteins such as transcription factors or histone modifications interact with DNA, addressing the biological problem of mapping protein-DNA binding sites genome-wide.

The pipeline transforms raw sequencing data into high-quality peak calls and normalized signal tracks for visualization in genome browsers. It integrates multiple quality control steps, including read QC, alignment metrics, and peak-calling statistics, to ensure the reliability of the findings for downstream biological analysis and differential binding comparisons.

## Data preparation
Users must provide a comma-separated samplesheet (CSV) containing sample identifiers, FASTQ file paths, replicate numbers, and optional antibody or control information. A reference genome is required, which can be specified via the `--genome` parameter for iGenomes or by providing paths to a FASTA file and a GTF or GFF annotation file.

Example samplesheet (`samplesheet.csv`):
```csv
sample,fastq_1,fastq_2,replicate,antibody,control,control_replicate
WT_IP,S1_R1.fq.gz,,1,H3K4me3,WT_INPUT,1
WT_INPUT,S2_R1.fq.gz,,1,,,
```

Key constraints:
- The samplesheet must be a CSV file with a header row.
- FastQ files must be gzipped and have the extension `.fq.gz` or `.fastq.gz`.
- If `--genome` is not used, `--fasta` and either `--gtf` or `--gff` are mandatory.

## How to run
Execute the pipeline using the `nextflow run` command with the required `--input` and `--outdir` parameters. It is recommended to specify a pipeline release with `-r` and use a container profile such as `-profile docker` or `-profile singularity` for environment management.

```bash
nextflow run nf-core/chipseq \
  -r 2.1.0 \
  -profile docker \
  --input samplesheet.csv \
  --outdir results \
  --genome GRCh38
```

Common options:
- `--aligner`: Specify the alignment algorithm (default: `bwa`; options: `bwa`, `bowtie2`, `chromap`, `star`).
- `--narrow_peak`: Run MACS3 in narrowPeak mode (default is broad).
- `-resume`: Restart a run from the last successful step if it was interrupted.
- `-params-file`: Provide pipeline parameters via a YAML or JSON file.

## Outputs
Results are organized within the directory specified by `--outdir`. The primary quality control summary is found in the MultiQC report, while biological results include filtered BAM files, bigWig tracks for visualization, MACS3 peak files, and annotated consensus peak sets.

Key deliverables:
- `multiqc/`: Integrated QC report for raw reads, alignment, and peak calling.
- `bwa/merged_library/`: Final filtered and merged BAM files.
- `bwa/merged_library/bigwig/`: Normalized signal tracks for IGV.
- `bwa/merged_library/macs3/`: Peak calls in broad or narrow format.
- `bwa/merged_library/macs3/homer/`: Peak annotations relative to gene features.

For a comprehensive list of output files and interpretation guides, refer to the [official output documentation](https://nf-co.re/chipseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
