---
name: ericscript
description: EricScript is a bioinformatics pipeline designed to discover and score chimeric transcripts and gene fusions from transcriptomic data. Use when user asks to identify gene fusions, download Ensembl-based reference databases, or predict high-confidence chimeric transcripts using the EricScore.
homepage: https://github.com/databio/ericscript
metadata:
  docker_image: "quay.io/biocontainers/ericscript:0.5.5--pl5.22.0r3.3.2_1"
---

# ericscript

## Overview
EricScript is a specialized bioinformatics pipeline for discovering chimeric transcripts (gene fusions) in transcriptomic data. It integrates multiple tools—including BWA for alignment, BLAT for junction recalibration, and the "ada" R package for classification—to provide a list of predicted fusions. It is most effective when high-confidence fusion candidates are required, as it provides a specific "EricScore" to filter out potential false positives.

## Database Management
Before running the analysis, you must prepare the reference database. EricScript uses Ensembl-based references.

- **List available genomes**:
  `./ericscript.pl --printdb`
- **Download and build a database**:
  `./ericscript.pl --downdb --refid <species_id> -db /path/to/db_folder`
  *Example for Human (default)*: `./ericscript.pl --downdb --refid homo_sapiens -db ./ericdb`
- **Specify Ensembl version**:
  Use `--ensversion <number>` (must be >= 70) to pin a specific release.
- **Maintenance**:
  Check if your local database is current: `./ericscript.pl --checkdb`

## Running the Pipeline
The primary execution requires paired-end FASTQ files and a path to the prepared database.

### Basic Command Pattern
```bash
./ericscript.pl -db /path/to/db_folder \
                --refid <species> \
                -name <sample_name> \
                -o /path/to/output_dir \
                read1.fastq read2.fastq
```

### Key Parameters
- `-db`: Path to the directory containing the Ensembl databases built during the setup phase.
- `--refid`: The species identifier (e.g., `homo_sapiens`, `saccharomyces_cerevisiae`). Defaults to `homo_sapiens`.
- `-name`: A unique identifier for the sample, used to prefix output files.
- `-o`: The output directory where results and intermediate files will be stored.

## Interpreting Results
EricScript generates two primary result files in the output directory:

1.  **`<sample_name>.results.total.csv`**: Contains every predicted gene fusion identified by the pipeline.
2.  **`<sample_name>.results.filtered.csv`**: The high-confidence subset. This file only includes fusions with an **EricScore > 0.50**.

**Expert Tip**: Always prioritize the `.filtered.csv` file for initial biological validation. The EricScore is a classifier-based metric; scores closer to 1.0 indicate higher confidence in the fusion event.

## Troubleshooting and Requirements
- **Executable Permissions**: Ensure the main script is executable: `chmod +x ericscript.pl`.
- **Path Dependencies**: Ensure `bwa`, `samtools` (>0.1.17), `bedtools` (>2.15), `blat`, and `seqtk` are available in your system PATH.
- **R Dependencies**: The R package `ada` must be installed in your R environment for the scoring system to function.

## Reference documentation
- [EricScript Readme](./references/github_com_databio_ericscript.md)