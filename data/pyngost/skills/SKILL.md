---
name: pyngost
description: pyngoST performs simultaneous multi-locus sequence typing of Neisseria gonorrhoeae genomic assemblies using the Aho-Corasick algorithm. Use when user asks to perform MLST, NG-STAR, or NG-MAST typing, identify antimicrobial resistance-associated lineages, or manage gonococcal allele databases.
homepage: https://github.com/leosanbu/pyngoST
metadata:
  docker_image: "quay.io/biocontainers/pyngost:1.1.3--pyh7e72e81_0"
---

# pyngost

## Overview

pyngoST is a high-performance bioinformatics tool designed for the simultaneous multi-locus sequence typing of *Neisseria gonorrhoeae* collections. It leverages the Aho-Corasick string-searching algorithm to rapidly match genomic assemblies against known allele databases. This skill enables the characterization of gonococcal isolates for epidemiological surveillance and antimicrobial resistance (AMR) profiling.

## Database Management

Before running analysis, you must initialize or specify a database containing the allele profiles.

- **Download and Build**: Create a fresh database from Public Health Agency of Canada (NG-STAR) and PubMLST (MLST/NG-MAST) sources.
  ```bash
  pyngoST.py -d
  ```
- **Custom Database Location**: Specify a name or path for the database.
  ```bash
  pyngoST.py -d -n custom_db_name
  ```
- **Update Existing Database**: Refresh an existing database with new alleles or incorporate Clonal Complex (CC) files.
  ```bash
  pyngoST.py -u -p /path/to/allelesDB -cc NGSTAR_CCs.csv
  ```

## Common CLI Patterns

### Standard Multi-Scheme Typing
To extract all three major typing schemes from a set of fasta files:
```bash
pyngoST.py -i sample1.fasta sample2.fasta -s NG-STAR,MLST,NG-MAST
```

### AMR-Focused Surveillance
To identify resistance-associated lineages, include Clonal Complexes and mosaic penA detection:
```bash
pyngoST.py -i *.fasta -c -m -s NG-STAR
```

### Processing Large Collections
For large datasets, use a file containing paths to assemblies and enable multi-threading:
```bash
pyngoST.py -r list_of_files.txt -t 8 -o results_table.tsv
```

## Parameter Reference

- `-i / --input`: Space-separated list of FASTA files.
- `-r / --read_file`: Text file containing one path per line for input assemblies.
- `-s / --schemes`: Comma-separated schemes (NG-STAR, MLST, NG-MAST). Default is NG-STAR.
- `-m / --mosaic_pena`: Reports if the penA allele is a mosaic or semi-mosaic (critical for cephalosporin resistance logic).
- `-c / --ngstarccs`: Appends NG-STAR Clonal Complex assignments to the output.
- `-g / --genogroups`: Calculates NG-MAST genogroups (Note: these are dataset-specific).
- `-b / --blast_new_alleles`: Uses BLASTn to find the closest known allele when a novel sequence is detected.
- `-a / --alleles_out`: Exports FASTA files containing any newly identified alleles.

## Expert Tips

- **Virtual Environments**: Always run pyngoST within a dedicated environment to manage the `pyahocorasick` dependency.
- **Novel Alleles**: If the tool reports "New" alleles, use the `-b` flag to determine how closely they relate to existing resistance markers.
- **Memory Efficiency**: The tool loads a pickle file of the allele dictionary into memory. For extremely large databases, ensure the execution environment has sufficient RAM.
- **Output Handling**: If `-o` is not specified, results are printed to the screen. Always use `-o` for batch processing to ensure data persistence.

## Reference documentation
- [pyngoST GitHub Repository](./references/github_com_leosanbu_pyngoST.md)
- [pyngoST Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyngost_overview.md)