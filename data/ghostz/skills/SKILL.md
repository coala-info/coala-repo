---
name: ghostz
description: GHOSTZ is a sequence homology search tool that uses a clustering-based algorithm for rapid protein and DNA alignments. Use when user asks to prepare sequence databases, perform high-throughput homology searches, or execute fast sequence alignments.
homepage: http://www.bi.cs.titech.ac.jp/ghostz/
---


# ghostz

## Overview

GHOSTZ is a specialized bioinformatics tool designed for rapid sequence homology searching. It bridges the gap between the sensitivity of BLAST and the requirement for massive-scale processing by utilizing a clustering-based algorithm. This skill provides the necessary procedural knowledge to prepare sequence databases and execute alignments, making it ideal for high-throughput annotation or comparative genomics workflows where standard BLAST is too slow.

## Database Preparation

Before searching, you must convert a FASTA file into the GHOSTZ binary format. This process divides the database into chunks to manage memory usage.

**Basic Command:**
`ghostz db -i <input_fasta> -o <database_name>`

**Optimization Options:**
- **Memory Management (`-l`)**: Set the chunk size in bytes. The default is 1GB. If working on a machine with limited RAM, decrease this value. Note that smaller chunks may slightly decrease search efficiency.
- **Clustering (`-C`)**: Enabled by default (`T`). Disabling this (`F`) will reduce the speed advantage of GHOSTZ.
- **Subsequence Length (`-L`)**: The length of the subsequence used for clustering (default: 10).

## Homology Search (Alignment)

Once the database is formatted, use the `aln` command to perform the search.

**Basic Command:**
`ghostz aln -i <query_fasta> -d <database_name> -o <output_file>`

**Key Parameters:**
- **Sequence Types**: Use `-q` for query type and `-t` for database type. Options are `p` (protein, default) or `d` (DNA).
- **Parallelization (`-a`)**: Specify the number of threads to use. Increasing this is the most effective way to speed up searches on multi-core systems.
- **Output Limits**:
  - `-v`: Maximum number of alignments for each subject (default: 1).
  - `-b`: Maximum number of output hits for a single query (default: 10).
- **Short Sequence Handling (`-n`)**: Queries shorter than this amino acid length will be skipped (default: 12). This helps prevent abnormal termination on very short sequences.

## Output Format

GHOSTZ produces a tab-delimited file compatible with BLAST-tabular format. The 12 columns are:
1. Query name
2. Subject name (homologue)
3. Percentage of identity
4. Alignment length
5. Number of mismatches
6. Number of gap openings
7. Start of alignment in query
8. End of alignment in query
9. Start of alignment in subject
10. End of alignment in subject
11. E-value
12. Bit score

## Expert Tips and Troubleshooting

- **Memory Allocation Errors**: If the program terminates with a "bad allocation" error, it is often due to processing massive amounts of extremely short sequences. Resolve this by:
  1. Reducing the query chunk size using the `-l` flag in the `aln` command.
  2. Splitting the input query file into smaller subsets.
- **Sensitivity vs. Speed**: The `-s` parameter in the `db` command controls the seed threshold (default: 39). Adjusting this can fine-tune the balance between sensitivity and processing speed.
- **Filtering**: The `-F` flag enables/disables the filtering of low-complexity query sequences (default: `T`). Disable this if you are looking for matches in repetitive regions.

## Reference documentation
- [GHOSTZ Overview](./references/anaconda_org_channels_bioconda_packages_ghostz_overview.md)
- [GHOSTZ Usage and Options](./references/www_bi_cs_titech_ac_jp_ghostz.md)
- [Version History and Bug Fixes](./references/www_bi_cs_titech_ac_jp_ghostz_history.md)