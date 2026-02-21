---
name: microbeannotator
description: MicrobeAnnotator is a specialized pipeline for the metabolic profiling of microbial genomes.
homepage: https://github.com/cruizperez/MicrobeAnnotator
---

# microbeannotator

## Overview

MicrobeAnnotator is a specialized pipeline for the metabolic profiling of microbial genomes. It transforms protein sequences (typically predicted by tools like Prodigal) into functional insights by using an iterative search strategy. The tool starts with high-confidence Kofam matches and progressively searches unannotated proteins against Swissprot, RefSeq, and Trembl. Its primary value lies in its ability to refine annotations by linking database identifiers (E.C. and InterPro) to KO numbers and producing visual summaries of KEGG module completion.

## Database Preparation

Before running annotations, you must build the local databases. There are two "flavors": Regular (Full) and Light.

### Building the Database
Use `microbeannotator_db_builder` to download and format the required data.

```bash
# Regular mode (Kofam, Swissprot, RefSeq, Trembl)
microbeannotator_db_builder -d MicrobeAnnotator_DB -m diamond -t 16

# Light mode (Kofam and Swissprot only - faster and requires less space)
microbeannotator_db_builder -d MicrobeAnnotator_DB -m diamond -t 16 --light
```

### Key Builder Arguments
- `-d`: Directory for database storage.
- `-m`: Search method (`blast`, `diamond`, or `sword`). Diamond is recommended for speed.
- `-t`: Number of threads.
- `--step`: Start from a specific step (1-5) if a previous run failed.
- `--no_aspera`: Use `wget` instead of Aspera Connect for downloads (slower but more compatible).

## Running Annotations

The main `microbeannotator` script processes protein FASTA files.

### Basic Command
```bash
microbeannotator -i proteins.fasta -d MicrobeAnnotator_DB -o output_dir -m diamond -t 16
```

### Advanced Usage Patterns
- **Light Annotation**: If you built a light database, you must use the `--light` flag during annotation.
- **Multiple Genomes**: Process multiple genomes by providing a directory or a list of files (check tool version for specific batch handling).
- **Refining Annotations**: The tool automatically attempts to convert E.C. and InterPro entries to KO numbers at the end of the run to maximize KEGG module coverage.

## Best Practices and Tips

- **Input Quality**: Ensure input files are protein sequences (ORF predictions). If you have genomic DNA, run a tool like Prodigal first.
- **Search Method**: Use `diamond` for most use cases. `sword` is faster but has specific hardware requirements. `blast` is the slowest but most sensitive.
- **Storage**: The full database is large (hundreds of GBs). Use the `--light` version if disk space is limited or if you only need core metabolic pathways.
- **Resuming**: If a database build fails, use the `--step` flag to avoid re-downloading data.
- **Aspera Connect**: If possible, install Aspera Connect to significantly speed up the initial database download from NCBI/UniProt.

## Reference documentation
- [MicrobeAnnotator GitHub README](./references/github_com_cruizperez_MicrobeAnnotator.md)
- [MicrobeAnnotator Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_microbeannotator_overview.md)