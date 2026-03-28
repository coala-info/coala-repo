---
name: tango
description: tango assigns taxonomic classifications to metagenomic contigs by querying nucleotide sequences against protein databases using rank-specific thresholds. Use when user asks to download taxonomy data, format protein databases, build Diamond indices, or assign taxonomy to assembly sequences.
homepage: https://github.com/johnne/tango
---

# tango

## Overview

tango (based on the contigtax framework) is a specialized tool for assigning taxonomy to metagenomic sequences. It operates by querying contig nucleotide sequences against protein databases using Diamond blastx/blastp. Unlike simple best-hit approaches, it utilizes rank-specific thresholds to improve classification accuracy. The workflow is modular, covering everything from raw database acquisition to final taxonomic assignment in tab-separated formats.

## Core Workflow

### 1. Database Preparation
Before processing contigs, you must prepare the reference environment.

*   **Download Taxonomy**: Required for all operations.
    `tango download taxonomy`
*   **Download Protein DB**: Choose between UniRef (50, 90, 100) or NCBI NR.
    `tango download uniref100`
*   **Format Fasta**: Reformat the database to handle Diamond's 14-character ID limit and map protein IDs to TaxIDs.
    `tango format uniref100/uniref100.fasta.gz uniref100/uniref100.reformat.fasta.gz`
*   **Build Index**: Create the Diamond database.
    `tango build uniref100/uniref100.reformat.fasta.gz uniref100/prot.accession2taxid.gz taxonomy/nodes.dmp`

### 2. Sequence Classification
Once the database is built, process your assembly files.

*   **Search**: Run the Diamond search against your assembly.
    `tango search -p 8 assembly.fa uniref100/diamond.dmnd assembly.tsv.gz`
*   **Assign**: Parse the search hits into final taxonomic assignments.
    `tango assign -p 8 assembly.tsv.gz assembly.taxonomy.tsv`

## Expert Tips and Best Practices

*   **Thread Optimization**: Always use the `-p` flag in both `search` and `assign` steps to utilize multi-core processing, as Diamond and pandas-based parsing are resource-intensive.
*   **ID Length Limits**: Diamond has a hardcoded limit of 14 characters for protein IDs. If using custom databases, always run the `format` command to ensure IDs are truncated or remapped correctly to avoid build failures.
*   **Temporary Directories**: When working on clusters or systems with limited home space, use `--tmpdir` during the `download` and `format` steps to point to high-speed local scratch space.
*   **Memory Management**: The `assign` step uses `pandas` and can be memory-intensive for very large search results. Ensure your environment has sufficient RAM relative to the size of your `assembly.tsv.gz`.

## Troubleshooting Common Issues

*   **ETE3 SQLite Errors**: If you encounter `sqlite3.IntegrityError` during taxonomy downloads, it is usually due to a known bug in the `ete3` package regarding duplicate synonyms. You may need to manually patch `ncbiquery.py` to use `INSERT OR IGNORE` instead of `REPLACE`.
*   **Ambiguous Rank Entries**: If `tango assign` fails with a `ValueError` regarding truth values, check if your database contains taxa with multiple entries for the same rank (e.g., multiple "class" definitions for a single TaxID). This typically requires cleaning the input taxonomy mapping.



## Subcommands

| Command | Description |
|---------|-------------|
| tango | Tango is a tool for mapping and analyzing genomic data. |
| tango | tango: error: invalid choice: 'valid' (choose from 'download', 'format', 'update', 'build', 'search', 'assign', 'transfer') |
| tango assign | Assigns taxonomy to Diamond blastx results. |
| tango build | Builds the Tango database. |
| tango download | Download databases for tango. |
| tango format | Reformat protein fasta files. |
| tango search | Search for query sequences in a Diamond database. |
| tango transfer | Transfer taxonomy from ORFs to contigs. |
| tango update | Updates a prot.accession2taxid.gz file based on a mapping of sequence IDs. |

## Reference documentation

- [Contigtax Main Documentation](./references/github_com_NBISweden_contigtax.md)
- [Preparing the Database](./references/github_com_NBISweden_contigtax_wiki_Preparing-the-database.md)
- [Frequently Asked Questions](./references/github_com_NBISweden_contigtax_wiki_Frequently-Asked-Questions.md)