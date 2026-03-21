---
name: detaxizer
description: This pipeline identifies and filters specific taxonomic sequences from (meta)genomic FASTQ data using Kraken2, BBDuk, and optional BLASTn validation. Use when you need to decontaminate sequencing reads from host DNA or specific taxonomic subtrees before downstream metagenomic assembly or profiling.
homepage: https://github.com/nf-core/detaxizer
---

## Overview
nf-core/detaxizer addresses the challenge of taxonomic contamination in genomic and metagenomic datasets. It processes short and long reads to detect and optionally remove sequences belonging to a target taxon—defaulting to *Homo sapiens*—or an entire taxonomic subtree, producing "clean" FASTQ files ready for downstream analysis.

The pipeline integrates quality control, optional adapter trimming, and multi-method taxonomic classification. By combining k-mer based tools like Kraken2 and BBDuk with optional BLASTn validation, it provides a flexible framework for both assessing contamination levels and generating filtered datasets.

## Data preparation
Users must provide a CSV samplesheet containing paths to FASTQ files. The pipeline supports single-end, paired-end, and long-read data within the same run.

```csv
sample,short_reads_fastq_1,short_reads_fastq_2,long_reads_fastq_1
SAMPLE_01,S1_R1.fastq.gz,S1_R2.fastq.gz,S1_long.fastq.gz
```

Reference requirements depend on the selected analysis modules:
- **Kraken2**: Requires a database directory or tarball via `--kraken2db`.
- **BBDuk**: Requires a FASTA file of contaminant sequences via `--fasta_bbduk`.
- **BLASTn**: Requires a FASTA file via `--fasta_blastn` to construct a local database for read validation.
- **Taxon Selection**: The target for removal is specified via `--tax2filter` (e.g., "Mammalia" or "Homo sapiens").

## How to run
Run the pipeline using the `nextflow run` command, specifying the input samplesheet and the desired classification methods. It is recommended to use `-r` to pin a specific version and `-profile` for containerized execution.

```bash
nextflow run nf-core/detaxizer \
  -r 1.1.0 \
  -profile docker \
  --input samplesheet.csv \
  --classification_kraken2 \
  --tax2filter "Homo sapiens" \
  --outdir ./results
```

Additional flags can enable optional steps: `--preprocessing` activates fastp for quality trimming, `--validation_blastn` enables secondary verification of classified reads, and `--skip_filter` allows for taxonomic assessment without generating new FASTQ files.

## Outputs
Results are organized within the directory specified by `--outdir`.
- **Filtered Reads**: Cleaned FASTQ files ready for assembly or profiling; if `--output_removed_reads` is enabled, the discarded sequences are also saved.
- **Reports**: A MultiQC report provides a consolidated view of FastQC, fastp, and taxonomic classification statistics.
- **Downstream Samplesheets**: The pipeline automatically generates new samplesheets in the `downstream_samplesheets/` folder, formatted specifically for immediate use with `nf-core/mag` or `nf-core/taxprofiler`.

For a complete list of output files and their formats, refer to the official [output documentation](https://nf-co.re/detaxizer/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
