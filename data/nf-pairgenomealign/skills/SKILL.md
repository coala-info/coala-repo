---
name: pairgenomealign
description: This pipeline aligns one or more query genomes to a target genome using the LAST aligner, accepting FASTA files via a samplesheet and a single target FASTA to produce MAF alignments, PNG dotplots, and optional exports like BAM or SAM. Use when performing whole-genome comparisons, self-alignments, or visualizing genomic rearrangements across multiple species or assemblies, supporting various alignment modes from many-to-many to one-to-one.
homepage: https://github.com/nf-core/pairgenomealign
---

## Overview
nf-core/pairgenomealign facilitates the comparison of genomic sequences by aligning multiple query assemblies against a common target reference. It addresses the need for visualizing large-scale synteny and structural variations through dotplots while providing standardized alignment formats for downstream analysis.

The pipeline processes FASTA inputs to generate alignments in Multiple Alignment Format (MAF), which can be further converted to formats like BAM, CRAM, or BED. Users receive both quantitative alignment data and qualitative visual reports to assess genome similarity and assembly quality.

## Data preparation
The pipeline requires a target genome FASTA and a samplesheet for query genomes. The samplesheet must be a CSV file with `sample` and `fasta` columns.

Example `samplesheet.csv`:
```csv
sample,fasta
query_1,path/to/genome1.fasta
query_2,path/to/genome2.fasta
```

The target genome is provided via the `--target` parameter and should be in FASTA format (e.g., `.fasta`, `.fna`, or `.fa`), which can be gzipped. You can optionally provide a name for the target using `--targetName`.

## How to run
Run the pipeline using the `nextflow run` command, specifying the input samplesheet, target genome, and output directory.

```bash
nextflow run nf-core/pairgenomealign \
    -profile <docker/singularity/conda> \
    --input samplesheet.csv \
    --target reference.fasta \
    --outdir ./results
```

Key parameters include:
- `-r`: Pin a specific version of the pipeline.
- `-resume`: Restart a run from the last successful step.
- `--seed`: Select the LAST seed for indexing (e.g., `YASS`, `MAM8`, `RY4`).
- `--m2m`: Enable many-to-many alignment mode.
- `--export_aln_to`: Specify additional output formats (e.g., `bam,bed,sam`).

## Outputs
Results are saved in the directory specified by `--outdir`. Key deliverables include:

- **MAF files**: Standard Multiple Alignment Format files for query-target pairs.
- **Dotplots**: PNG images visualizing the alignments in various modes (one-to-one, many-to-one, etc.).
- **MultiQC**: A summary report containing assembly statistics from `assembly-scan` and alignment metrics.
- **Converted Alignments**: If requested, alignments exported to formats such as BAM, SAM, BED, or GFF.

For a detailed description of all output files and reports, refer to the official [output documentation](https://nf-co.re/pairgenomealign/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
