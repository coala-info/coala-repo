---
name: nf-core-proteinannotator
description: This pipeline computes statistics for protein FASTA inputs and generates annotations for conserved domains, functional signatures, and secondary structure features like α-helices and β-strands. Use when you need to characterize amino acid sequences using databases such as Pfam, FunFam, and InterPro, or when performing sequence-level quality control and preprocessing including gap removal and length filtering.
homepage: https://github.com/nf-core/proteinannotator
---

# nf-core-proteinannotator

## Overview
nf-core/proteinannotator is designed to solve the problem of characterizing large sets of amino acid sequences by identifying their functional and structural properties. It automates the scanning of protein sequences against signatures of protein families, domains, and sites to provide a comprehensive view of the protein's potential roles and physical characteristics.

In practice, the pipeline takes protein FASTA files as input and performs a series of quality control, preprocessing, and annotation steps. The results include detailed reports on conserved domains, functional characteristics from the InterPro database, and predicted secondary structure compositional features, all summarized in a centralized quality control report.

## Data preparation
The pipeline requires a comma-separated samplesheet (CSV) to specify the input protein FASTA files. Each row represents a set of proteins, typically from a single species or sample.

*   **id**: A unique identifier for the sample (cannot contain spaces).
*   **fasta**: Path to the protein FASTA file. Supported extensions include `.fa`, `.fasta`, `.faa`, and `.fas`, which can optionally be compressed with `.gz`.

Example `samplesheet.csv`:
```csv
id,fasta
species1,species1_proteins.fasta
species2,species2_proteins.fasta
```

Users can also provide paths to pre-downloaded databases for Pfam (`--pfam_db`), FunFam (`--funfam_db`), or InterProScan (`--interproscan_db`) to avoid automatic downloads during the run.

## How to run
The pipeline is executed using Nextflow with the `--input` and `--outdir` parameters. It is recommended to use `-profile` to specify the container engine (e.g., docker, singularity) or institutional configuration.

```bash
nextflow run nf-core/proteinannotator \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results
```

Commonly used parameters include:
*   `-resume`: To restart a pipeline from the last cached step.
*   `--skip_preprocessing`: To skip gap trimming, length filtering, and duplicate removal.
*   `--min_seq_length` / `--max_seq_length`: To filter sequences by length (defaults are 30 and 5000).
*   `--interproscan_applications`: To specify which InterProScan member databases to use (e.g., `Hamap,PANTHER,PIRSF`).

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary deliverables include:

*   **MultiQC Report**: A summary of quality control statistics for input sequences before and after preprocessing.
*   **Annotation Results**: Files containing predicted domains (HMMER), functional signatures (InterProScan), and secondary structure predictions (s4pred).
*   **Processed Sequences**: Validated and filtered FASTA files used for the analysis.

For a detailed description of the output directory structure and file formats, refer to the [official output documentation](https://nf-co.re/proteinannotator/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)