---
name: extract_fasta_seq
description: This tool retrieves specific sequences from FASTA files based on provided identifiers or query files. Use when user asks to extract specific records from a FASTA file, filter out sequences using a list of IDs, or isolate genes and scaffolds from a multi-FASTA file.
homepage: https://github.com/linzhi2013/extract_fasta_seq
---


# extract_fasta_seq

## Overview
The `extract_fasta_seq` tool is a specialized utility for retrieving specific records from FASTA-formatted files. It allows for flexible querying using either direct command-line arguments or external text files containing lists of target IDs. This skill is particularly useful when you need to isolate specific genes, proteins, or scaffolds from a multi-FASTA file without writing custom parsing scripts.

## Command Line Usage

### Basic Extraction
To extract sequences by providing IDs directly in the command:
```bash
extract_fasta_seq -q seqID1 seqID2 -s input.fasta -o output.fasta
```

### Extraction Using a Query File
When dealing with a large number of IDs, use a text file (one ID per line):
```bash
extract_fasta_seq -f ids_to_extract.txt -s input.fasta -o subset.fasta
```

### Inverted Extraction (Filtering Out)
To remove specific sequences from a file and keep everything else, use the `-v` flag:
```bash
extract_fasta_seq -f ids_to_remove.txt -s input.fasta -v -o filtered.fasta
```

## Advanced Patterns and Best Practices

### Handling Delimited Query Files
If your query file is a TSV or CSV where the ID is not in the first column, use `-d1` (0-based index) and `-s1` (separator):
```bash
# Extract IDs found in the second column (index 1) of a tab-separated file
extract_fasta_seq -f data.tsv -s1 $'\t' -d1 1 -s input.fasta -o output.fasta
```

### Optimizing Performance with --lazy
For very large FASTA files where you know each query ID appears only once, use the `--lazy` flag. This stops the search for a specific ID as soon as it is found, significantly reducing processing time:
```bash
extract_fasta_seq -f query.txt -s large_genome.fasta --lazy -o output.fasta
```

### Piping and Standard Input
The tool supports standard input, making it easy to chain with other bioinformatics tools:
```bash
cat input.fasta | extract_fasta_seq -q target_id > result.fasta
```

### Matching Specific Header Fields
By default, the tool matches the first word of the FASTA header. If the identifier you are matching against is located in a different part of the header (e.g., after a pipe or space), use `-d2` to specify the field index in the subject file:
```bash
# Match against the second field in the FASTA header (e.g., >gi|12345)
extract_fasta_seq -q 12345 -s2 "|" -d2 1 -s input.fasta
```

## Expert Tips
- **Case Sensitivity**: Ensure your query IDs exactly match the case in the FASTA file, as the tool performs exact string matching.
- **Memory Efficiency**: The tool is designed to handle large subject files efficiently, but using `--lazy` is the best way to optimize speed for non-inverted searches.
- **Invert Mode Limitation**: Note that `--lazy` cannot be used with the `-v` (invert) flag, as the tool must scan the entire file to ensure all non-matching sequences are captured.

## Reference documentation
- [GitHub README for extract_fasta_seq](./references/github_com_linzhi2013_extract_fasta_seq_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_extract_fasta_seq_overview.md)