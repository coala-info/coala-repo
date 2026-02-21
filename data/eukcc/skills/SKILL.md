---
name: eukcc
description: EukCC is a specialized tool for assessing the quality of microbial eukaryotic genomic data.
homepage: https://github.com/Finn-Lab/EukCC/
---

# eukcc

## Overview
EukCC is a specialized tool for assessing the quality of microbial eukaryotic genomic data. It addresses the unique challenges of eukaryotic genomes—such as larger sizes and complex gene structures—by using a phylogenetically aware approach based on conserved marker genes. Use this skill to determine if a eukaryotic bin or genome is of sufficient quality for downstream analysis.

## Database Setup
EukCC requires a specific database to function. You must download and extract it before running analyses.

```bash
# Create directory and download EukCC2 database
mkdir eukccdb && cd eukccdb
wget http://ftp.ebi.ac.uk/pub/databases/metagenomics/eukcc/eukcc2_db_ver_1.2.tar.gz
tar -xzvf eukcc2_db_ver_1.2.tar.gz

# Set environment variable for the database path
export EUKCC2_DB=$(realpath eukcc2_db_ver_1.2)
```

## Common CLI Patterns

### Analyzing a Single Genome
Use the `single` command for individual FASTA files.
```bash
eukcc single --db $EUKCC2_DB --outdir output_dir input_genome.fasta
```

### Analyzing Multiple Bins (Batch Mode)
Use the `folder` command to process a directory containing multiple FASTA files (bins).
```bash
eukcc folder --db $EUKCC2_DB --outdir output_dir path/to/bins_folder
```

### Adjusting Stringency
In EukCC v2, you can adjust the prevalence threshold for marker sets. The default is often 98%, but you can increase it for higher stringency.
```bash
eukcc single --db $EUKCC2_DB --prevalence 100 --outdir output_dir input.fasta
```

## Interpreting Outputs
The primary results are stored in CSV format:
*   **eukcc.csv**: The main results table. Key columns include:
    *   `completeness`: Estimated percentage of the genome present.
    *   `contamination`: Estimated percentage of foreign/redundant DNA.
    *   `lineage`: The taxonomic level used for the marker set.
*   **bad_quality.csv**: Contains bins where the marker gene set was supported by less than half of the alignments.
*   **merged_bins.csv**: Results for refined/merged bins if the tool attempted to improve quality.

## Expert Tips and Best Practices
*   **Avoid Training Data Bias**: Do not use EukCC to validate genomes that were used to train the EukCC database (check `db_base/backbone/base_taxinfo.csv` in the database folder for accessions).
*   **Debug Mode**: If a run fails or produces unexpected "zero proteins predicted" errors, use the `--debug` flag to generate a detailed log for troubleshooting.
*   **Resource Management**: EukCC relies on several heavy dependencies (MetaEuk, HMMER, pplacer). Ensure these are in your PATH. If using Conda, the `bioconda::eukcc` package handles these requirements automatically.
*   **Exit Codes**:
    *   `201`: No marker gene set could be defined (common for very fragmented or non-eukaryotic data).
    *   `204`: Predicted zero proteins (check if the input file is valid FASTA or if the genetic code is unusual).

## Reference documentation
- [EukCC GitHub Repository](./references/github_com_EBI-Metagenomics_EukCC.md)
- [EukCC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_eukcc_overview.md)