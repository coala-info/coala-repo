---
name: ensembl-genomio
description: The ensembl-genomio toolset standardizes genomic sequences and annotations for compatibility with the Ensembl ecosystem. Use when user asks to convert GFF3 files to Ensembl core databases, format FASTA headers for Ensembl compliance, or generate manifest files for genomic data submission.
homepage: https://www.ensembl.org/
metadata:
  docker_image: "quay.io/biocontainers/ensembl-genomio:1.6.2--pyhdfd78af_0"
---

# ensembl-genomio

## Overview
The `ensembl-genomio` toolset provides a bridge between standard bioinformatics flatfiles and the Ensembl ecosystem. It is designed to standardize genomic data (sequences and annotations) to meet Ensembl's structural requirements. Use this skill to automate the preparation of genome assemblies for Ensembl ingestion or to extract data from Ensembl cores into portable formats.

## Core CLI Patterns
The tool is typically invoked via the `ensembl-genomio` command followed by specific subcommands.

### Data Conversion
*   **GFF3 to Ensembl Core**: Convert standard annotation files into the Ensembl database schema.
*   **FASTA Processing**: Standardize scaffold/chromosome names and headers to comply with Ensembl naming conventions.
*   **Flatfile Generation**: Export data from an existing Ensembl core database back into GFF3 or FASTA formats.

### Common Subcommands
*   `process_gff3`: Validates and cleans GFF3 files for Ensembl compatibility.
*   `process_fasta`: Formats genomic sequences.
*   `manifest_create`: Generates the required manifest files for data submission or pipeline processing.

## Best Practices
*   **Validation First**: Always run validation subcommands on GFF3 files before attempting a full conversion to catch common issues like overlapping features or invalid parent-child relationships.
*   **Metadata Consistency**: Ensure that the `genome.json` metadata file is present and correctly formatted, as many `ensembl-genomio` tools rely on this for species and assembly context.
*   **Environment Setup**: Since the tool is distributed via Bioconda, ensure the environment is active:
    ```bash
    conda install bioconda::ensembl-genomio
    ```

## Expert Tips
*   **Naming Conventions**: Ensembl is strict about sequence identifiers. Use the tool's renaming features to ensure your FASTA headers match the expected Ensembl "accession.version" or "chromosome" format.
*   **Back-and-Forth Workflows**: When round-tripping data (Flatfile -> Core -> Flatfile), use the tool's manifest system to track file checksums and ensure data integrity.

## Reference documentation
- [Ensembl GenomIO Overview](./references/anaconda_org_channels_bioconda_packages_ensembl-genomio_overview.md)