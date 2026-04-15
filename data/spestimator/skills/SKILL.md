---
name: spestimator
description: Spestimator identifies bacterial species in genomic data by aligning sequences against a 16S rRNA database and mapping hits to reference genome accessions. Use when user asks to identify organisms in FASTA files, download corresponding reference genomes, or update the local RefSeq database.
homepage: https://github.com/erinyoung/Spestimator
metadata:
  docker_image: "quay.io/biocontainers/spestimator:0.3.0.233--pyhdfd78af_0"
---

# spestimator

## Overview

Spestimator is a specialized Python-based command-line utility designed to streamline the identification of bacterial organisms within genomic data. By leveraging BLAST+ to align input sequences against a curated 16S rRNA database from NCBI RefSeq, it provides a high-confidence estimation of species present in a sample. Beyond simple identification, the tool automates the mapping of hits to specific RefSeq assembly accessions (GCF IDs), allowing researchers to move directly from raw sequences to downloaded reference genomes in a single step.

## Core Workflows

### Basic Species Identification
To identify organisms in one or more FASTA files and save the results to a CSV:
`spestimator -i sample1.fasta sample2.fasta -o identification_results.csv`

### Identification with Automated Genome Download
To identify species and immediately download the corresponding reference genomes into a specific directory:
`spestimator -i input.fasta -o results.csv -d reference_genomes/`

### Database Maintenance
RefSeq databases are updated quarterly. To ensure you are using the most current data:
`spestimator --update-db --db-dir ./custom_db_path --api-key YOUR_NCBI_API_KEY`

## Command Line Options and Filtering

### Performance and Connectivity
- **--api-key**: Always provide an NCBI API key when updating the database or downloading genomes to significantly increase request limits and prevent timeouts.
- **-t / --threads**: Increase the number of threads for the BLAST+ alignment phase to speed up processing of large input files.

### Refining Results
- **--min-identity**: Default is 90.0. For strict species-level identification, consider increasing this to 97.0 or 99.0.
- **--min-coverage**: Filter out short or partial hits by setting a minimum query coverage percentage.
- **--top-k-taxa**: Use this to limit the output to the top N unique organisms per file (default is 10), which is useful for filtering out low-abundance contaminants.
- **--min-hits**: Set the minimum number of reads required to report an organism, helping to reduce false positives in noisy data.

## Expert Tips and Best Practices

- **Handling Download Failures**: If the internal genome downloader encounters an `ApiException`, use the `refseq_assembly_accession` column from the output CSV to perform a manual bulk download using the NCBI `datasets` tool:
  `cut -f 4 -d , results.csv | grep GCF > accessions.txt`
  `datasets download genome accession --inputfile accessions.txt`
- **Input Flexibility**: Spestimator accepts both assembled contigs and raw reads. However, for raw read data, ensure you have sufficient depth and that the sequences cover the 16S region.
- **Database Persistence**: When using a custom database directory created via `--update-db`, you must point to it in subsequent runs using the `--db-dir` flag to avoid using the default internal database.

## Reference documentation
- [spestimator - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_spestimator_overview.md)
- [GitHub - erinyoung/Spestimator: Uses 16S to identify a range of possible species.](./references/github_com_erinyoung_Spestimator.md)