---
name: madre
description: MADRe (Metagenomic Assembly-Driven Database Reduction) is a specialized tool for taxonomic classification that bridges the gap between fast but less precise k-mer methods and accurate but resource-intensive mapping methods.
homepage: https://github.com/lbcb-sci/MADRe
---

# madre

## Overview

MADRe (Metagenomic Assembly-Driven Database Reduction) is a specialized tool for taxonomic classification that bridges the gap between fast but less precise k-mer methods and accurate but resource-intensive mapping methods. It works by performing a preliminary assembly of long reads to identify a subset of the reference database that is actually supported by the sample data. By narrowing the search space before performing full read mapping, MADRe significantly reduces RAM usage and runtime while maintaining high precision at the strain level.

## Configuration and Setup

MADRe requires a `config.ini` file to manage paths to its dependencies (Flye, metaMDBG, minimap2, etc.) and the reference database.

### Essential config.ini Structure
```ini
[PATHS]
metaflye = flye
metaMDBG = metaMDBG
minimap = minimap2
hairsplitter = hairsplitter.py
seqkit = seqkit

[DATABASE]
predefined_db = /path/to/database.fna
strain_species_json = /path/to/taxids_species.json
```

## Common CLI Patterns

### Standard Execution
The primary way to run the full MADRe pipeline:
```bash
madre --reads sample_reads.fastq.gz --out-folder ./results --config config.ini
```

### Handling Different Sequencing Technologies
MADRe adjusts its internal assembly logic based on the sequencing platform. Use the `--reads_flag` to optimize performance:
*   **Oxford Nanopore (ONT):** Uses metaFlye by default.
    ```bash
    madre --reads ont_reads.fq --reads_flag ont --out-folder ./ont_out --config config.ini
    ```
*   **PacBio HiFi:** Uses metaMDBG by default.
    ```bash
    madre --reads hifi_reads.fq --reads_flag hifi --out-folder ./hifi_out --config config.ini
    ```

### Using Alternative Assemblers
If you prefer Myloasm for the assembly step regardless of the read type:
```bash
madre --reads reads.fq --use-myloasm True --out-folder ./output --config config.ini
```

## Database Preparation

### Recommended: Kraken2 Bacteria Database
The most effective way to use MADRe is with a pre-built Kraken2 bacterial library.
1. Build the Kraken2 database.
2. Point the `predefined_db` path in `config.ini` to the `library.fna` file within the Kraken2 directory.

### Using GTDB
If using the Genome Taxonomy Database (GTDB), use the provided helper script to format it for MADRe:
```bash
./database/gtdb_to_madre.sh --tar gtdb_genomes_reps.tar.gz --meta bac120_metadata.tsv --out MADRe_reference_database
```

## Expert Tips and Best Practices

*   **Memory Efficiency:** MADRe is specifically designed for "exploratory" settings. If you already know your sample contains only a few species, traditional mapping might be faster; use MADRe when the potential species list is in the thousands.
*   **Output Interpretation:**
    *   `read_classification.out`: Best for per-read analysis and filtering.
    *   `abundances.out`: The primary file for community composition analysis, providing normalized abundance values.
*   **Taxonomy Headers:** If building a custom database, ensure your FASTA headers follow the format `>|taxid|accession_number` to ensure the species-level voting logic functions correctly.
*   **JSON Index:** Always ensure the `taxids_species.json` file (found in the MADRe GitHub `database` folder) is correctly referenced in your config, as this maps strain-level hits to species-level classifications.

## Reference documentation
- [MADRe GitHub Repository](./references/github_com_lbcb-sci_MADRe.md)
- [MADRe Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_madre_overview.md)