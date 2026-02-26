---
name: blast-legacy
description: This tool provides guidance for using the original NCBI BLAST software suite to index databases and execute sequence searches. Use when user asks to format databases with formatdb, perform sequence searches using blastall, or utilize legacy megablast commands.
homepage: http://blast.ncbi.nlm.nih.gov
---


# blast-legacy

## Overview
The `blast-legacy` skill provides guidance for using the original NCBI BLAST software suite (version 2.2.x). While largely superseded by BLAST+, the legacy tools remain essential for maintaining older bioinformatics pipelines, reproducing historical research, or utilizing specific legacy output formats. This skill focuses on the core command-line utilities used to index databases and execute sequence searches.

## Database Preparation
Before searching, you must format your FASTA sequences into a BLAST-readable binary format using `formatdb`.

- **Nucleotide database**: `formatdb -i sequences.fasta -p F -n db_name`
- **Protein database**: `formatdb -i sequences.fasta -p T -n db_name`
- **Key Flags**:
  - `-o T`: Parse SeqID and create indexes (required for fetching sequences by ID).
  - `-v`: Set the chunk size in MB (default is 200).

## Common Search Patterns
The primary tool for searching is `blastall`. You must specify the program type using the `-p` flag.

- **blastn**: Search a nucleotide database using a nucleotide query.
  `blastall -p blastn -d db_name -i query.fasta -o results.txt`
- **blastp**: Search a protein database using a protein query.
  `blastall -p blastp -d db_name -i query.fasta -o results.txt`
- **blastx**: Search a protein database using a translated nucleotide query.
  `blastall -p blastx -d db_name -i query.fasta -o results.txt`
- **tblastn**: Search a translated nucleotide database using a protein query.
  `blastall -p tblastn -d db_name -i query.fasta -o results.txt`
- **tblastx**: Search a translated nucleotide database using a translated nucleotide query.
  `blastall -p tblastx -d db_name -i query.fasta -o results.txt`

## Expert Tips and Best Practices
- **Output Formats (`-m`)**: 
  - `-m 0`: Pairwise (default).
  - `-m 8`: Tabular format (highly recommended for parsing).
  - `-m 9`: Tabular with comment lines.
- **E-value Threshold**: Use `-e` to set the expectation value. A lower value (e.g., `1e-10`) increases stringency.
- **Performance**: Use `-a` to specify the number of processors/cores for multi-threaded execution.
- **Large Scale Searches**: For high-speed nucleotide searches of highly similar sequences, use the standalone `megablast` command instead of `blastall -p blastn`.
- **Effective Search Space**: If searching a small subset of a large database, use `-z` to manually set the effective database length to maintain consistent E-value statistics.

## Reference documentation
- [blast-legacy Overview](./references/anaconda_org_channels_bioconda_packages_blast-legacy_overview.md)