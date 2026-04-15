---
name: slamseq
description: This pipeline processes SLAMSeq sequencing datasets using Slamdunk to quantify nucleotide conversions and employs DESeq2 to identify direct transcriptional targets. Use when analyzing metabolic labeling data to measure RNA synthesis and degradation rates or to identify primary transcriptional responses through T-to-C conversion detection.
homepage: https://github.com/nf-core/slamseq
---

# slamseq

## Overview
The nf-core/slamseq pipeline is designed for the analysis of SLAMSeq (Thiol-linked Alkylation for the Metabolic Sequencing of RNA) data. It addresses the biological challenge of distinguishing between pre-existing and newly synthesized RNA by identifying characteristic T-to-C conversions introduced during metabolic labeling.

In practice, the workflow takes raw sequencing reads and maps them to a reference genome while specifically accounting for nucleotide conversions. It produces quantification matrices of labeled versus unlabeled transcripts and performs differential analysis to pinpoint direct transcriptional targets.

## Data preparation
Users must provide a design file and specify a reference genome. The documentation indicates the use of a TSV format for the input samplesheet.

- **Input design**: A TSV file (e.g., `design.tsv`) containing sample metadata and paths to sequencing data.
- **Reference genome**: Specified via the `--genome` parameter (e.g., `GRCh38`).
- **Constraints**: The specific column headers for the design TSV are not explicitly detailed in the provided text, but the file is required for execution.

## How to run
The pipeline is executed using Nextflow with the `-profile` flag to manage software dependencies via Docker, Singularity, or Conda.

```bash
# Run the pipeline with a design file and reference genome
nextflow run nf-core/slamseq \
    -profile <docker/singularity/conda> \
    --input design.tsv \
    --genome GRCh38 \
    --outdir <results_directory>
```

Use `-resume` to restart a run from the last successful step. A minimal test dataset can be run using `-profile test` to verify the installation and environment.

## Outputs
Results are saved to the directory specified by the `--outdir` parameter. Primary deliverables include:

- **Slamdunk results**: Processed alignments and T-to-C conversion quantifications.
- **DESeq2 analysis**: Statistical inference of direct transcriptional targets.
- **MultiQC report**: A summary report aggregating quality control metrics from the run.

Detailed descriptions of the output structure and interpretation are available in the `docs/output.md` file within the repository.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)