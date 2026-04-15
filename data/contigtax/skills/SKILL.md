---
name: contigtax
description: contigtax assigns taxonomic labels to metagenomic sequences by querying them against reference protein databases using rank-specific thresholds. Use when user asks to download reference data, build custom taxonomic databases, search contigs against a database, or assign taxonomic classifications to sequences.
homepage: https://github.com/NBISweden/contigtax
metadata:
  docker_image: "quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0"
---

# contigtax

## Overview

contigtax is a specialized tool for assigning taxonomic labels to metagenomic sequences. It operates by querying nucleotide or protein sequences against a reference protein database using Diamond. Unlike simple blast-top-hit approaches, it utilizes rank-specific thresholds to improve classification accuracy across different levels of the biological hierarchy. This skill should be used when you need to process raw assembly files (FASTA) into annotated taxonomic tables, or when you need to prepare custom taxonomic reference databases for metagenomic analysis.

## Workflow and CLI Patterns

### 1. Database Preparation
Before classification, you must download and format the reference data.

**Download Reference Data:**
```bash
# Download a protein database (uniref100, uniref90, uniref50, or nr)
contigtax download uniref100

# Download required NCBI taxonomy files
contigtax download taxonomy
```

**Format and Build:**
Diamond requires a specific format to include taxonomy.
```bash
# Reformat the fasta and create a taxonmap
contigtax format uniref100/uniref100.fasta.gz uniref100/uniref100.reformat.fasta.gz

# Build the Diamond database with taxonomy nodes
contigtax build uniref100/uniref100.reformat.fasta.gz uniref100/prot.accession2taxid.gz taxonomy/nodes.dmp
```

### 2. Taxonomic Assignment
The core workflow consists of a search step followed by an assignment step.

**Search:**
```bash
# Search contigs (assembly.fa) against the built database
contigtax search -p 4 assembly.fa uniref100/diamond.dmnd assembly.tsv.gz
```

**Assign:**
```bash
# Convert search hits into final taxonomic assignments
contigtax assign -p 4 assembly.tsv.gz assembly.taxonomy.tsv
```

## Expert Tips and Best Practices

- **Protein ID Limits:** Diamond has a hardcoded limit of 14 characters for protein IDs when building databases with taxonomy. The `contigtax format` command automatically handles remapping IDs that exceed this limit.
- **Resource Management:** Use the `-p` flag in `search` and `assign` steps to specify the number of threads. For large metagenomes, ensure sufficient RAM is available for Diamond.
- **Docker Usage:** If running via Docker, mount your current working directory to `/work` to ensure files are accessible:
  `docker run --rm -v $(pwd):/work nbisweden/contigtax <command>`
- **Temporary Directories:** When working on clusters with limited home directory space, use the `--tmpdir` flag during `download` and `format` steps to point to local scratch space.

## Troubleshooting Common Issues

- **ete3 SQLite Errors:** If you encounter `sqlite3.IntegrityError` during taxonomy download, it is a known issue with the `ete3` package. You may need to manually patch `ncbiquery.py` within your environment to change `INSERT OR REPLACE` to `INSERT OR IGNORE` for synonyms.
- **Ambiguous Series Errors:** In the `assign` step, a `ValueError` regarding truth values usually indicates a taxonomic ID in the database that has multiple entries for a single rank (e.g., two different "class" assignments for one ID). Check your reference database integrity if this occurs.



## Subcommands

| Command | Description |
|---------|-------------|
| contigtax | A tool for taxonomic assignment of contigs. |
| contigtax | A tool for taxonomic assignment of contigs. |
| contigtax build | Builds a Diamond database and taxon mapping for contigs. |
| contigtax format | Reformat a protein fasta file for contigtax. |
| contigtax search | Search for contigs in a Diamond database and assign taxonomy. |
| contigtax transfer | Assigns taxonomy to contigs based on ORF taxonomy and GFF file. |
| contigtax update | Update a prot.accession2taxid.gz file with new sequence IDs. |
| contigtax_assign | Assigns taxonomy to contigs based on Diamond blastx results. |
| contigtax_download | Download contigtax databases |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_NBISweden_contigtax.md)
- [Preparing the Database](./references/github_com_NBISweden_contigtax_wiki_Preparing-the-database.md)
- [Frequently Asked Questions](./references/github_com_NBISweden_contigtax_wiki_Frequently-Asked-Questions.md)
- [Installation Guide](./references/github_com_NBISweden_contigtax_wiki_Installation.md)