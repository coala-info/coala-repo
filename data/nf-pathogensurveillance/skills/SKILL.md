---
name: pathogensurveillance
description: This pipeline performs pathogen identification and biosurveillance by accepting raw genomic reads to generate interactive HTML reports, multi-gene phylogenies, and SNP-based variant analyses. Use when analyzing unknown prokaryotic or eukaryotic gDNA samples that require automated NCBI RefSeq reference selection, but avoid using it for viral sequences, mixed samples, or non-gDNA modalities like RNA-seq.
homepage: https://github.com/nf-core/pathogensurveillance
---

# pathogensurveillance

## Overview
Pathogensurveillance is a population genomics pipeline designed for identifying unknown samples and detecting variants without requiring a pre-defined reference genome. It automates the process of selecting the best reference by generating k-mer sketches from assembled reads and matching them against NCBI RefSeq libraries using sourmash.

The pipeline is suitable for both prokaryotic and eukaryotic genomic DNA from various sequencing technologies, including Illumina, Nanopore, PacBio, and BGISEQ. It produces publication-quality figures and interactive reports that place samples within a phylogenetic context, making it accessible for users with limited bioinformatics training.

## Data preparation
The primary input is a CSV or TSV samplesheet specified with `--input`. At minimum, it requires a column for the path to sequencing reads, but additional metadata can be provided to customize reports or group samples.

**Samplesheet columns:**
* `sample_id`: Unique identifier for the sample.
* `path`: Path to the first FASTQ file (must end in `.fq.gz` or `.fastq.gz`).
* `path_2`: Path to the second FASTQ file for paired-end data.
* `sequence_type`: Sequencing platform (e.g., `illumina`, `nanopore`, `pacbio`, `bgiseq`).
* `report_group_ids`: Semicolon-separated IDs to group samples in the final report.
* `ploidy`: Integer representing the ploidy of the organism (default is 1).

Example `samplesheet.csv`:
```csv
sample_id,path,path_2,sequence_type
SAMPLE1,reads_1.fastq.gz,reads_2.fastq.gz,illumina
SAMPLE2,long_reads.fastq.gz,,nanopore
```

Users can also provide a `reference_data` CSV to specify known references manually. If using Bakta for annotation, the database path must be provided via `--bakta_db` or downloaded automatically using `--download_bakta_db`.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific version with `-r` and a container profile like `docker` or `singularity`.

```bash
nextflow run nf-core/pathogensurveillance \
    -r 1.1.0 \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    -resume
```

For testing, several profiles are available such as `-profile test_bacteria` or `-profile test_serratia`. Use `--max_depth` to subsample high-coverage data and `--max_parallel_downloads` to manage NCBI API rate limits during reference retrieval.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary deliverable is an interactive HTML report containing identification results and phylogenies.

* `interactive_report.html`: The main interactive document for exploring sample identification and phylogeny.
* `MultiQC/`: Quality control reports for the entire run.
* `path_surveil_data/`: Default location for downloaded reference genomes and databases (configurable via `--data_dir`).

For more details about the output files and reports, refer to the official output documentation at `https://nf-co.re/pathogensurveillance/output`.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)