---
name: demultiplex
description: nf-core/demultiplex processes raw sequencing data from Illumina, Element Biosciences, 10x Genomics, and other platforms using a master samplesheet and vendor-specific run directories to generate demultiplexed FASTQ files and quality control reports. Use when automating the conversion of raw base call files into sample-specific outputs while performing optional adapter trimming with fastp and generating aggregate MultiQC summaries for data integrity verification.
homepage: https://github.com/nf-core/demultiplex
---

## Overview
nf-core/demultiplex is a bioinformatics pipeline designed to automate the conversion of raw binary data from next-generation sequencing machines into individual FASTQ files. It provides a unified interface for various vendor-specific tools, handling the complexities of barcode identification and sample separation across multiple sequencing technologies.

The pipeline accepts a master samplesheet that links flowcell IDs to their respective run directories and vendor-specific configuration files. Beyond simple demultiplexing, it performs essential primary analysis tasks including read quality control, adapter trimming, and the generation of MD5 checksums to ensure data integrity throughout the process.

## Data preparation
The pipeline requires a master samplesheet CSV file provided via the `--input` parameter. This file defines the relationship between flowcells and their metadata.

The master samplesheet must contain the following columns:
- `id`: A unique identifier for the flowcell or run.
- `samplesheet`: The path to the vendor-specific samplesheet (e.g., an Illumina SampleSheet.csv).
- `flowcell`: The path to the raw run directory containing the base call files.
- `lane` (optional): The specific lane number to process (1-8).
- `per_flowcell_manifest` (optional): Path to a manifest file specific to the flowcell.

**Minimal samplesheet example:**
```csv
id,samplesheet,flowcell
RUN_001,/path/to/Illumina_SampleSheet.csv,/path/to/run_directory/
```

For Illumina data, the pipeline supports both v1 and v2 samplesheet formats. If using Kraken2 for contamination screening, a path to a Kraken2 database must be provided via `--kraken_db`.

## How to run
The primary command to run the pipeline requires the input samplesheet and an output directory. You must specify a demultiplexer compatible with your data using the `--demultiplexer` parameter.

```bash
nextflow run nf-core/demultiplex \
    -profile <docker/singularity/conda> \
    --input samplesheet.csv \
    --outdir ./results \
    --demultiplexer bclconvert
```

Supported demultiplexers include:
- `bclconvert` (default) or `bcl2fastq` for Illumina.
- `bases2fastq` for Element Biosciences.
- `mkfastq` for 10x Genomics single-cell data.
- `sgdemux` for Singular Genomics.
- `mgikit` for MGI sequencers.
- `fqtk` for custom read structures.

Use `-r` to pin a specific pipeline version and `-resume` to restart a run from the last completed step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- **Demultiplexed FASTQs**: The main output files organized by sample.
- **MultiQC Report**: An aggregate report located in `multiqc/` (open `multiqc_report.html`) summarizing demultiplexing statistics and read quality.
- **QC Metrics**: Raw read quality reports from Falco and trimming statistics from fastp.
- **Checksums**: MD5 files for every generated FASTQ to verify file transfer integrity.
- **Reports**: Vendor-specific demultiplexing logs and reports (e.g., from BCL Convert or mkfastq).

For a complete description of the output structure, refer to the [official output documentation](https://nf-co.re/demultiplex/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/example_input.csv`](references/docs/example_input.csv)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
