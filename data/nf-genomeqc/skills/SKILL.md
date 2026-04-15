---
name: genomeqc
description: This pipeline compares the quality of multiple genome assemblies and their annotations by processing local FASTA/GFF files or NCBI accessions to generate assembly statistics, completeness evaluations, and contamination reports. Use when assessing genome assembly contiguity with QUAST, evaluating completeness via BUSCO, or screening for foreign organism contamination using FCS-GX and Tiara.
homepage: https://github.com/nf-core/genomeqc
---

# genomeqc

## Overview
nf-core/genomeqc is a bioinformatics pipeline designed to benchmark and compare the quality of multiple genome assemblies and their associated gene annotations. It supports two primary execution modes: a "Genome Only" mode for basic assembly assessment and a "Genome and Annotation" mode that includes functional feature analysis, protein isoform extraction, and orthology-based phylogenetics.

The pipeline integrates standard tools to provide a comprehensive view of genome integrity, including contiguity metrics, single-copy marker completeness, and repeat identification. For annotated genomes, it further identifies orthologous genes via Orthofinder and generates a phylogenetic tree summary to visualize relationships between the input species.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. This file defines the species names and the paths to local files or NCBI accessions.

**Samplesheet columns:**
- `species`: Unique identifier for the organism (required, no spaces).
- `refseq`: NCBI assembly accession (e.g., GCF_000000001.1) for automated download.
- `fasta`: Path to local genome assembly file (.fasta, .fa, .fna).
- `gff`: Path to local annotation file (.gff3, .gtf).
- `fastq`: Path to sequencing reads for Merqury evaluation (optional).
- `taxid`: NCBI taxonomy ID for contamination screening.

**Example samplesheet (`samplesheet.csv`):**
```csv
species,refseq,fasta,gff,fastq
human,GCF_000001405.40,,,
yeast,,./data/yeast.fna,./data/yeast.gff,
```

## How to run
The pipeline is executed using Nextflow. It is strongly recommended to specify a BUSCO lineage using `--busco_lineage` rather than relying on the default "auto" setting to ensure stability.

**Basic execution:**
```bash
nextflow run nf-core/genomeqc \
    -profile <docker/singularity/institute> \
    --input samplesheet.csv \
    --outdir ./results \
    --busco_lineage hymenoptera_odb10
```

**Common parameters:**
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`, or `test`).
- `--genome_only`: Forces the pipeline to ignore annotation-related steps even if GFF files are present.
- `--skip_tidk`: Disables telomeric repeat identification.
- `-resume`: Restarts the pipeline from the last cached step if a previous run was interrupted.
- `-r`: Specifies a specific version/release of the pipeline (e.g., `-r 1.0.0`).

## Outputs
Results are saved in the directory specified by `--outdir`. The primary summary is the MultiQC report, which aggregates statistics from all tools.

**Key deliverables:**
- `multiqc/`: Combined HTML report containing QUAST, BUSCO, and contamination statistics.
- `busco/`: Completeness reports and BUSCO Ideograms showing marker locations.
- `quast/`: Detailed assembly contiguity metrics (N50, GC%, etc.).
- `contamination/`: Reports from FCS-GX, FCS-adaptor, and Tiara.
- `orthofinder/`: (Annotation mode only) Orthologous group identification and phylogenetic trees.
- `agat/`: (Annotation mode only) Statistics on gene features and lengths.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/genomeqc/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)