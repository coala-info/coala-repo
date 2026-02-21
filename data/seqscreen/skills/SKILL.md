---
name: seqscreen
description: SeqScreen is a specialized genomic analysis pipeline designed to characterize short DNA sequences or open reading frames (ORFs).
homepage: https://gitlab.com/treangenlab/seqscreen/-/wikis/home
---

# seqscreen

## Overview
SeqScreen is a specialized genomic analysis pipeline designed to characterize short DNA sequences or open reading frames (ORFs). Unlike general classifiers, it focuses on identifying "Functions of Sequences of Concern" (FunSoCs), making it a critical tool for biosecurity and pathogen surveillance. It bridges the gap between knowing "what" an organism is (taxonomy) and "what it can do" (functionality/virulence).

## Core Workflows

### Initialization and Database Setup
Before running analyses, SeqScreen requires a set of reference databases.
```bash
# Download and initialize the required databases
seqscreen __download_databases__ --outpath ./seqscreen_db
```

### Running the Analysis Pipeline
The primary command for processing sequences is `seqscreen`. It accepts FASTA or FASTQ files.

**Standard Run:**
```bash
seqscreen -i input_sequences.fasta -o output_directory --database ./seqscreen_db
```

**Key Arguments:**
- `-i / --input`: Path to the input FASTA/FASTQ file.
- `-o / --outdir`: Directory where results and intermediate files will be stored.
- `-d / --database`: Path to the initialized SeqScreen database.
- `--threads`: Number of CPUs to utilize (default is usually 1).
- `--mode`: Choose between `fast` (sensitive) or `sensitive` (more exhaustive search).

### Interpreting FunSoC Results
The most unique output of SeqScreen is the FunSoC report.
- **Taxonomic Assignment**: Provides the most likely origin of the sequence.
- **Functional Annotation**: Assigns GO terms and protein functions.
- **FunSoC Flags**: Look for specific flags indicating potential virulence factors, toxins, or regulated pathogen sequences.

## Best Practices
- **Input Quality**: For short reads, ensure adapters are trimmed before running SeqScreen to prevent false functional assignments.
- **Resource Allocation**: SeqScreen is computationally intensive. Always specify `--threads` matching your environment's capacity to significantly reduce runtime.
- **Database Updates**: Biosecurity threats evolve; ensure you are using the latest version of the SeqScreen databases by periodically re-running the download command.
- **Output Review**: Focus on the `results/` subdirectory, specifically the tabular (.tsv) summaries, for high-level screening of large datasets.

## Reference documentation
- [SeqScreen Wiki Home](./references/gitlab_com_treangenlab_seqscreen_-_wikis_home.md)
- [SeqScreen Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqscreen_overview.md)