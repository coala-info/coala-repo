---
name: msi
description: MSI is a bioinformatics pipeline that transforms raw sequencing reads into polished taxa tables through clustering, consensus generation, and taxonomic assignment. Use when user asks to process Nanopore or Illumina metabarcoding data, generate polished consensus sequences, remove primers and adapters, or perform taxonomic binning via BLAST.
homepage: http://github.com/nunofonseca/msi/
---


# msi

## Overview

MSI (Metabarcoding Sequences Identification) is a specialized bioinformatics pipeline designed to transform raw sequencing reads into polished taxa tables. While it is particularly effective for handling the higher error rates associated with Nanopore sequencing, it is also compatible with high-accuracy Illumina data. The tool automates a multi-step workflow: clustering raw reads, generating polished consensus sequences (centroids), removing primers/adapters, and performing taxonomic assignment via BLAST alignment against reference databases.

## Installation and Setup

### Conda (Recommended)
Install MSI from the Bioconda channel:
```bash
conda install -c bioconda msi
conda activate base
```

### Docker
Use the pre-built image to avoid dependency conflicts:
```bash
docker pull nunofonseca/msi:latest
```

### Manual Environment Setup
If installed manually, you must source the environment file in every new shell session:
```bash
source $HOME/msi_env.sh
```

## Database Preparation

MSI requires the NCBI taxonomy database and an optional BLAST database for taxonomic binning.

1.  **NCBI Taxonomy**: By default, the installation script places this in `$MSI_DIR/db`.
2.  **BLAST Database**:
    *   Download the NCBI `nt` database: `./scripts/msi_install.sh -i $MSI_DIR -x blast_db`
    *   Create a custom database from a FASTA file: `metabinkit_blastgendb -i sequences.fasta` (Ensure headers contain `taxids=xxxxx;`).

## Running the Pipeline

### Basic Command Structure
The primary interface for MSI requires a configuration file, an input directory containing gzipped FASTQ files, and an output directory.

```bash
msi [options] -c params.cfg -i /path/to/fastq_folder -o /path/to/results
```

### Docker Execution
Use the `msi_docker` wrapper script for non-interactive runs. Note that all input files must reside within the directory (or subdirectories) where the script is executed:
```bash
scripts/msi_docker -c params.cfg -i ./data -o ./results
```

## Configuration Best Practices

MSI uses a simple `key=value` format for its configuration file (`.cfg`).

### Essential Parameters
| Parameter | Description | Default/Example |
| :--- | :--- | :--- |
| `THREADS` | Maximum CPU threads to utilize. | `5` |
| `METADATAFILE` | TSV file containing metadata about each FASTQ file. | `samplesheet.tsv` |
| `SKIP_BLAST` | Set to "Y" to stop the pipeline before taxonomic alignment. | `N` |
| `CLUSTER_MIN_READS` | Minimum number of reads required to form a cluster. | `1` |
| `CD_HIT_CLUSTER_THRESHOLD` | Similarity threshold for clustering (0.0 to 1.0). | `0.99` |
| `MIN_LEN` | Minimum read length to retain. | `40` |
| `PRIMER_MAX_ERROR` | Maximum error rate allowed for primer matching. | `0.2` |

### Input Requirements
*   **File Format**: MSI searches recursively for files with the `.fastq.gz` extension.
*   **Primers**: To perform adapter/primer removal, provide a TSV file containing primer sequences.

## Expert Tips

*   **Recursive Search**: MSI automatically scans all subfolders within the input directory (`-i`) for data. Ensure your input directory only contains the samples you intend to process to avoid accidental inclusion of unrelated data.
*   **Taxonomy Pathing**: If you move your taxonomy database, update the `TAXONOMY_DATA_DIR` variable in your `.cfg` file to point to the new location.
*   **Cluster Polishing**: The output FASTA file contains polished centroids. The header of each sequence includes the read count for that cluster, which is critical for downstream abundance analysis.
*   **Troubleshooting R**: If the pipeline complains about R versions, ensure R 3.6.0 or higher is installed. Recent versions (4.x+) are supported and should not trigger version warnings.

## Reference documentation
- [MSI GitHub README](./references/github_com_nunofonseca_msi_blob_master_README.md)
- [Bioconda MSI Overview](./references/anaconda_org_channels_bioconda_packages_msi_overview.md)