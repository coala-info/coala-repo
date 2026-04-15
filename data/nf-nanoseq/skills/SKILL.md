---
name: nanoseq
description: This pipeline performs basecalling, demultiplexing, QC, and alignment for Nanopore DNA or RNA data, supporting aligners like minimap2 and downstream tasks like variant calling or transcript quantification. Use when analyzing Oxford Nanopore Technologies datasets using DNA, cDNA, or directRNA protocols to produce coordinate-sorted BAM files, coverage tracks, and comprehensive MultiQC reports.
homepage: https://github.com/nf-core/nanoseq
---

# nanoseq

## Overview
The pipeline provides a comprehensive suite of tools for the analysis of Nanopore sequencing data. It handles the initial processing of raw reads, including optional demultiplexing and cleaning, through to alignment and specialized downstream analyses for both DNA and RNA modalities.

In practice, users provide raw or basecalled Nanopore data and receive processed results ranging from quality control metrics to biological insights such as structural variants for DNA or transcript isoforms and RNA modifications for RNA. The pipeline is designed to be portable and reproducible using Nextflow and containerization.

## Data preparation
The pipeline requires a comma-separated samplesheet and a specified protocol. The samplesheet defines the relationship between sample names and their corresponding FastQ files.

**Samplesheet Requirements:**
- A CSV file with a header row.
- Columns: `sample` (unique name), `fastq_1` (path to gzipped FastQ), and `fastq_2` (optional second FastQ for paired data).
- Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
sample1,path/to/reads_1.fastq.gz,
sample2,path/to/reads_2.fastq.gz,
```

**Mandatory Parameters:**
- `--input`: Path to the samplesheet CSV.
- `--protocol`: The sequencing type, which must be one of `DNA`, `cDNA`, or `directRNA`.

**Optional Inputs:**
- `--barcode_kit`: Required if performing demultiplexing with `qcat` (e.g., `SQK-PBK004`).
- `--input_path`: Path to a Nanopore run directory or basecalled FastQ for demultiplexing.
- `--nanolyse_fasta`: Reference FASTA for filtering reads with NanoLyse.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to use a specific release version with `-r` and a container profile for reproducibility.

```bash
nextflow run nf-core/nanoseq \
    -r 3.1.0 \
    --input samplesheet.csv \
    --protocol DNA \
    --outdir ./results \
    -profile docker
```

**Common Options:**
- `-profile`: Choose between `docker`, `singularity`, `podman`, `conda`, or an institutional profile.
- `--aligner`: Choose between `minimap2` (default) or `graphmap2`.
- `--call_variants`: Enable DNA variant calling (requires `--protocol DNA`).
- `--quantification_method`: Choose `bambu` (default) or `stringtie2` for RNA protocols.
- `-resume`: Restart a pipeline run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **MultiQC**: A summary report located in `multiqc/` that aggregates QC metrics from FastQC, NanoPlot, and alignment steps.
- **Alignment**: Coordinate-sorted BAM files and their indices.
- **Visualisation**: `bigWig` and `bigBed` coverage tracks for genome browsers.
- **DNA Analysis**: Small variants (VCF) from `medaka` or `deepvariant`, and structural variants from `sniffles` or `cutesv`.
- **RNA Analysis**: Transcript quantification matrices, differential expression results (DESeq2/DEXSeq), and RNA modification or fusion detections.

For a detailed description of all output files, refer to the official [nf-core/nanoseq output documentation](https://nf-co.re/nanoseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)