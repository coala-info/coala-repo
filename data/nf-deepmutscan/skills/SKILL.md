---
name: deepmutscan
description: This pipeline processes deep mutational scanning data from FASTQ or BAM inputs using a reference FASTA and reading frame coordinates to produce variant count tables, QC reports, and fitness estimates. Use when performing shotgun sequencing-based DMS studies on long open reading frames to infer fitness landscapes or classify variants in protein architecture and viral evolution research.
homepage: https://github.com/nf-core/deepmutscan
---

# deepmutscan

## Overview
nf-core/deepmutscan is a workflow designed for the analysis of deep mutational scanning (DMS) data, specifically optimized for shotgun sequencing of long open reading frames (ORFs). It standardizes the complex bioinformatics steps required to measure the fitness effects of thousands of gene variants simultaneously, helping to classify disease-causing mutants and learn rules of protein architecture or viral evolution.

The pipeline transforms raw sequencing reads into variant count tables and provides multiple QC metrics to evaluate experimental success. It supports various mutagenesis strategies and can optionally perform fitness landscape inferences using integrated statistical tools like DiMSum, Enrich2, or rosace.

## Data preparation
The pipeline requires a samplesheet, a reference genome, and specific coordinate information.

### Samplesheet
Provide a CSV file via the `--input` parameter. The file must contain the following columns:
- `sample`: Unique identifier for the sample.
- `type`: The experimental role of the sample (`input`, `output`, or `quality`).
- `replicate`: Positive integer representing the replicate number.
- `file1`: Path to the first FASTQ or BAM file.
- `file2`: Path to the second FASTQ file (optional for single-end).

Example `samplesheet.csv`:
```csv
sample,type,replicate,file1,file2
ORF1,input,1,/reads/forward1.fastq.gz,/reads/reverse1.fastq.gz
ORF1,output,1,/reads/forward2.fastq.gz,/reads/reverse2.fastq.gz
```

### Reference and Coordinates
- **FASTA**: A reference FASTA file must be provided via `--fasta`.
- **Reading Frame**: You must specify the start and stop codon positions using `--reading_frame` in the format `start-stop` (e.g., `1-300`).
- **Mutagenesis**: Specify the strategy using `--mutagenesis_type` (default is `nnk`; others include `nns`, `nnh`, `nnn`, or `custom`). If using `custom`, a `--custom_codon_library` CSV must be provided.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific release version with `-r` and a container profile.

```bash
nextflow run nf-core/deepmutscan \
   -profile docker \
   -r 1.0.0 \
   --input ./samplesheet.csv \
   --fasta ./ref.fa \
   --reading_frame 1-300 \
   --outdir ./results
```

Key parameters:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`).
- `--fitness`: Enable basic fitness calculation and data preparation for DiMSum.
- `--dimsum`: Run the DiMSum tool for fitness/functionality scores.
- `-resume`: Restart a pipeline from the last cached step if it was interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **MultiQC**: A summary report (`multiqc_report.html`) containing quality control metrics from across the pipeline.
- **Variant Counts**: Tables containing the counts of identified variants (e.g., `counts_merged.tsv`).
- **Fitness Estimates**: If enabled, results from statistical tools like DiMSum or Enrich2.
- **Pipeline Info**: Reports on resource usage, including CPU, memory, and CO₂ emissions.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/deepmutscan/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/pipeline_steps.md`](references/docs/pipeline_steps.md)
- [`references/docs/usage.md`](references/docs/usage.md)