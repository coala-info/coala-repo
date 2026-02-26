---
name: metawrap-kraken
description: MetaWRAP-Kraken performs taxonomic classification of metagenomic reads or contigs and generates interactive Krona visualizations. Use when user asks to assign taxonomic labels to sequencing data, profile microbial community composition, or generate Krona charts for metagenomic samples.
homepage: https://github.com/bxlab/metaWRAP
---


# metawrap-kraken

## Overview

MetaWRAP-Kraken is a specialized module within the MetaWRAP suite designed to streamline taxonomic classification. It acts as a wrapper for Kraken and Kraken2, allowing researchers to assign taxonomic labels to metagenomic data—either raw sequencing reads or assembled contigs. Beyond simple classification, it integrates visualization tools to produce Krona charts, providing an intuitive overview of the community composition. This tool is essential for the "Taxonomic Profiling" stage of genome-resolved metagenomics.

## Usage Patterns

The tool is typically invoked as a module of the main MetaWRAP executable. Depending on the version of the underlying algorithm required, use one of the following commands:

- `metawrap kraken` (for Kraken 1)
- `metawrap kraken2` (for Kraken 2)

### Common CLI Arguments

While specific flags may vary by version, the standard workflow follows this pattern:

- `-o OUTPUT_DIR`: Specifies the directory where results and Krona charts will be saved.
- `-t THREADS`: Sets the number of CPU cores (8+ recommended).
- `-i INPUT_FILES`: The input fastq reads or fasta contigs.
- `--unclassified-out`: (Optional) Saves reads that could not be assigned a taxonomy.

## Expert Tips and Best Practices

### Database Configuration
Before running the Kraken module, ensure the database paths are correctly defined in the MetaWRAP configuration file.
- Locate the config file: `yourpath/metaWRAP/bin/config-metawrap`.
- Ensure the `KRAKEN_DB` or `KRAKEN2_DB` variables point to the directory containing your indexed taxonomy databases.

### Hardware Requirements
Kraken is extremely memory-intensive because it loads the entire database index into RAM.
- **RAM**: Minimum 64GB is recommended for standard RefSeq databases.
- **Storage**: Ensure sufficient disk space for the intermediate classification files, which can be large.

### Input Flexibility
The module can handle different stages of the metagenomic pipeline:
- **Raw Reads**: Use this to get an initial profile of the community before assembly.
- **Assembled Contigs**: Use this to understand the taxonomic origin of your assembly before binning.
- **Binned Genomes**: While MetaWRAP has a specific `classify_bins` module, you can run Kraken on individual bins to verify consistency.

### Visualization
The primary output for interpretation is the Krona chart (`.html` file). This interactive file allows you to zoom into specific taxonomic ranks (e.g., from Phylum down to Species) to explore the relative abundance of organisms.

## Reference documentation

- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [Bioconda metawrap-kraken Overview](./references/anaconda_org_channels_bioconda_packages_metawrap-kraken_overview.md)