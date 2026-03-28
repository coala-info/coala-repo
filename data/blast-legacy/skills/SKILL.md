---
name: blast-legacy
description: The blast-legacy tool provides guidance for using the original suite of BLAST programs to compare biological sequences against databases. Use when user asks to format sequence databases, perform homology searches using blastall, or retrieve sequences from formatted databases using fastacmd.
homepage: http://blast.ncbi.nlm.nih.gov
---

# blast-legacy

## Overview
The `blast-legacy` skill provides guidance for utilizing the original suite of BLAST tools (such as `blastall`, `formatdb`, and `fastacmd`) to compare biological sequences against databases. While modern research often uses BLAST+, legacy BLAST remains relevant for maintaining compatibility with older pipelines, specific database formats, or specialized research environments where the newer C++ toolkit is not available.

## Core CLI Patterns

### Database Preparation
Before searching, a FASTA file must be formatted into a BLAST-readable binary format.
- **Nucleotide**: `formatdb -i database.fasta -p F -n "db_name"`
- **Protein**: `formatdb -i database.fasta -p T -n "db_name"`
- **Note**: Use `-o T` if you need to create an index for sequence retrieval via `fastacmd`.

### Common Search Commands
The primary interface for legacy BLAST is the `blastall` executable, which uses the `-p` flag to define the program type.

| Program | Query Type | Database Type | Use Case |
| :--- | :--- | :--- | :--- |
| `blastn` | Nucleotide | Nucleotide | DNA-DNA homology |
| `blastp` | Protein | Protein | Protein-Protein homology |
| `blastx` | Translated Nucleotide | Protein | Finding genes in genomic DNA |
| `tblastn` | Protein | Translated Nucleotide | Finding proteins in uncharacterized DNA |
| `tblastx` | Translated Nucleotide | Translated Nucleotide | Cross-species DNA comparison |

**Example Syntax:**
```bash
blastall -p blastn -d db_name -i query.fasta -o results.txt -e 1e-5 -m 8
```

### Key Parameters
- `-e`: Expectation value (E-value) threshold (e.g., `1e-10`).
- `-m`: Output format. `8` is tabular (highly recommended for parsing); `0` is the standard pairwise alignment.
- `-v`: Number of database sequences to show one-line descriptions for.
- `-b`: Number of database sequences to show alignments for.
- `-a`: Number of processors to use (multithreading).

### Sequence Retrieval
Use `fastacmd` to extract specific sequences from a formatted database:
```bash
fastacmd -d db_name -s "accession_id"
```

## Expert Tips
- **E-value Sensitivity**: For short queries, increase the E-value (e.g., `-e 10`) to find matches that might otherwise be filtered out due to low statistical significance.
- **Tabular Parsing**: When using `-m 8`, the columns are: Query ID, Subject ID, % Identity, Alignment Length, Mismatches, Gap Openings, Q. Start, Q. End, S. Start, S. End, E-value, Bit Score.
- **Filtering**: Use `-F F` to disable complexity filtering if you are searching for repeats or low-complexity regions that BLAST usually masks.



## Subcommands

| Command | Description |
|---------|-------------|
| blastall | Legacy BLAST search tool |
| formatdb | Format protein or nucleotide databases for BLAST |
| megablast | megablast 2.2.26: a tool for fast alignment of highly similar sequences |

## Reference documentation
- [Basic Local Alignment Search Tool](./references/blast_ncbi_nlm_nih_gov_Blast.cgi.md)