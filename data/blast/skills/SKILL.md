---
name: blast
description: BLAST finds regions of local similarity between biological sequences to identify matches and calculate statistical significance. Use when user asks to search sequences against a database, identify unknown sequences, or perform comparative genomics.
homepage: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
---


# blast

## Overview
The Basic Local Alignment Search Tool (BLAST) is the industry standard for finding regions of local similarity between biological sequences. This skill enables the execution of various BLAST+ applications (like blastn, blastp, blastx) to calculate the statistical significance of matches between a query sequence and a database. It is essential for tasks involving sequence identification, comparative genomics, and functional annotation.

## Core CLI Patterns

### Database Preparation
Before searching, format your subject FASTA file into a BLAST-searchable database:
```bash
makeblastdb -in subject_sequences.fasta -dbtype prot -out my_db_name
```
*Use `-dbtype nucl` for nucleotide sequences.*

### Common Search Commands
- **blastn**: Nucleotide query vs. nucleotide database.
- **blastp**: Protein query vs. protein database.
- **blastx**: Translated nucleotide query vs. protein database.
- **tblastn**: Protein query vs. translated nucleotide database.

Example search:
```bash
blastp -query query.fasta -db my_db_name -out results.txt -evalue 1e-5 -outfmt 6
```

### Output Formats (-outfmt)
- `0`: Pairwise (default)
- `6`: Tabular (most useful for downstream parsing)
- `7`: Tabular with comment lines
- `11`: BLAST archive (allows re-formatting later using `blast_formatter`)

### Expert Tips
- **E-value Threshold**: Use `-evalue` (e.g., `1e-10`) to filter out statistically insignificant hits and reduce noise.
- **Performance**: Use `-num_threads` to utilize multiple CPU cores for faster processing.
- **Max Hits**: Limit results using `-max_target_seqs` or `-max_hsps` to keep output files manageable.
- **Custom Tabular Fields**: When using `-outfmt 6`, you can specify columns: `-outfmt "6 qseqid sseqid pident length evalue bitscore"`.

## Reference documentation
- [BLAST+ Overview](./references/anaconda_org_channels_bioconda_packages_blast_overview.md)