---
name: shortreadconnector
description: Short Read Connector compares two high-throughput sequencing read sets to identify shared k-mers or link similar reads using a resource-frugal indexing approach. Use when user asks to count k-mer occurrences between datasets, link similar reads across sequencing files, or perform fast k-mer-based similarity assessments with low memory usage.
homepage: https://github.com/GATB/short_read_connector
---


# shortreadconnector

## Overview

Short Read Connector (SRC) is a resource-frugal tool designed for the comparison of two high-throughput sequencing read sets, typically referred to as the "Bank" (B) and the "Query" (Q). It operates in two primary modes: counting k-mer occurrences and linking similar reads. The tool is particularly useful for bioinformatics workflows that require fast, k-mer-based similarity assessments between datasets while maintaining a low memory footprint through the use of probabilistic dictionaries.

## Core Workflows

The tool follows a two-step process: indexing the reference "bank" and then querying that index with one or more read sets.

### 1. K-mer Counting (short_read_connector_counter)
Use this mode to determine how many k-mers from each query read are present in the bank.

**Indexing the Bank:**
```bash
sh short_read_connector_counter.sh index -b bank_reads.fasta.gz -i bank_index.dumped
```

**Querying the Index:**
The query command requires a "File of Files" (fof) containing the paths to the query read sets.
```bash
# Create the file of files
ls query_reads.fasta.gz > query_list.fof

# Run the query
sh short_read_connector_counter.sh query -i bank_index.dumped -q query_list.fof
```

### 2. Read Linking (short_read_connector_linker)
Use this mode to find specific reads in the bank that share a significant number of k-mers with the query reads.

**Indexing the Bank:**
```bash
sh short_read_connector_linker.sh index -b bank_reads.fasta.gz -i linker_index.dumped
```

**Querying the Index:**
```bash
sh short_read_connector_linker.sh query -i linker_index.dumped -q query_list.fof
```

## Command Line Options and Best Practices

### Indexing Parameters
- `-k <int>`: K-mer length. The default is 31. Note that the maximum value is 31.
- `-a <int>`: Minimum k-mer abundance. K-mers occurring fewer than this many times in the bank are ignored (default is 2). Increase this to filter out sequencing errors in the bank.
- `-t <int>`: Number of threads. Set to 0 to use all available cores.

### Query and Filtering Parameters
- `-w <int>`: Window size. If set to 0 (default), the full read is considered. If specified, the tool looks for similarity within windows of this size.
- `-s <int>`: K-mer threshold. The minimal percentage of shared k-mer span required to report a match.
- `-p <string>`: Output prefix. All result files will begin with this string (default is "short_read_connector_res").

## Expert Tips
- **Input Format**: SRC supports both FASTA and FASTQ formats, including gzipped files.
- **Memory Efficiency**: The tool uses a Minimal Perfect Hash Function (MPHF). If you encounter false positives, increase the fingerprint size using the `-f` option (default is 12).
- **Low Complexity**: By default, low complexity regions are filtered. Use the `-l` flag in both index and query steps if you need to retain these regions for your analysis.
- **Output Interpretation**: The output text file provides mean, median, min, and max k-mer occurrences. A `percentage_shared_positions` of 100% indicates that every base in the best window of the query read is covered by at least one k-mer found in the bank.

## Reference documentation
- [Short Read Connector GitHub Repository](./references/github_com_GATB_short_read_connector.md)
- [Bioconda shortreadconnector Overview](./references/anaconda_org_channels_bioconda_packages_shortreadconnector_overview.md)