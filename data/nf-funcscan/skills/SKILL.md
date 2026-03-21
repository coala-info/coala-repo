---
name: nf-core-funcscan
description: This pipeline screens assembled nucleotide contigs for functional components including antimicrobial peptides, antibiotic resistance genes, and biosynthetic gene clusters using FASTA inputs and optional protein or GenBank annotations. Use when performing functional annotation of metagenomic assemblies or prokaryotic genomes to identify bioactive compounds and resistance elements through integrated tools like antiSMASH, RGI, and Macrel.
homepage: https://github.com/nf-core/funcscan
---

## Overview
nf-core/funcscan is designed for the automated discovery of functional genes within genomic and metagenomic sequences. It provides a unified framework to run multiple specialized screening tools simultaneously, handling the complexities of taxonomic classification, gene prediction, and result aggregation.

The pipeline processes assembled contigs to identify three primary categories of functional elements: antimicrobial peptides (AMPs), antibiotic resistance genes (ARGs), and biosynthetic gene clusters (BGCs). It produces standardized, aggregated reports for each category alongside a comprehensive MultiQC summary of the entire run.

## Data preparation
Users must provide a CSV samplesheet containing at least the sample ID and the path to the FASTA file. Optional columns for pre-existing protein (`.faa`) or GenBank (`.gbk`) annotations can be included if available; if provided, both `protein` and `gbk` must be present for that row.

Example `samplesheet.csv`:
```csv
sample,fasta,protein,gbk
SAMPLE1,contigs.fasta,,
SAMPLE2,assembly.fna,proteins.faa,features.gbk
```

Input FASTA files should contain assembled contigs. The pipeline is optimized for prokaryotic sequences and can perform taxonomic classification using MMseqs2 if the source organisms are unknown.

## How to run
Execute the pipeline using the `nextflow run` command, specifying the desired screening modules with boolean flags. It is recommended to pin a specific version using `-r`.

```bash
nextflow run nf-core/funcscan \
    -r 2.0.0 \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    --run_amp_screening \
    --run_arg_screening \
    --run_bgc_screening
```

Key parameters include:
- `--run_taxa_classification`: Enables taxonomic assignment of contigs.
- `--annotation_tool`: Choose between `pyrodigal` (default), `prodigal`, `prokka`, or `bakta`.
- `-resume`: Restarts a run from the last successful step.

## Outputs
Results are organized within the directory specified by `--outdir`. Primary deliverables include:
- `reports/`: Aggregated summary tables from `AMPcombi` (AMPs), `hAMRonization` (ARGs), and `comBGC` (BGCs).
- `multiqc/`: The final HTML report summarizing tool versions, sequence quality, and screening hits.
- `annotation/`: Predicted coding sequences and functional annotations if `--save_annotations` is used.

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/funcscan/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
