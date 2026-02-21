---
name: selectfasta
description: The `selectfasta` tool is a C++ based utility designed for the efficient retrieval of biological sequences.
homepage: https://github.com/andvides/selectFasta/
---

# selectfasta

## Overview
The `selectfasta` tool is a C++ based utility designed for the efficient retrieval of biological sequences. It allows researchers to filter large FASTA or FASTQ files by providing a simple text file containing the identifiers (headers) of the sequences they wish to keep. This tool is a lightweight alternative to complex scripting for basic sequence selection tasks.

## Installation
The tool is available via Bioconda. It is recommended to install it within a dedicated environment:
```bash
conda install -c bioconda selectfasta
```

## Command Line Usage

### Basic Syntax
The tool uses specific flags to define the input list, the source sequence file, and the output destination.

**For FASTA files:**
```bash
selectFasta -list headers_to_extract.txt -fasta input.fasta -fasta_sel output.fasta
```

**For FASTQ files:**
```bash
selectFasta -list headers_to_extract.txt -fastq input.fastq -fasta_sel output.fastq
```

### Parameter Definitions
- `-list`: A text file containing the names of the headers you want to select (one per line).
- `-fasta`: The path to the source FASTA file.
- `-fastq`: The path to the source FASTQ file.
- `-fasta_sel`: The path/name for the resulting output file containing the selected sequences.

## Best Practices and Tips
- **Header Matching**: Ensure that the names in your list file match the sequence headers exactly. While the tool is robust, discrepancies in whitespace or hidden characters in the list file can lead to missed selections.
- **File Formats**: Note that the output flag `-fasta_sel` is used regardless of whether the input is FASTA or FASTQ.
- **Performance**: Because the tool is implemented in C++, it is significantly faster than equivalent Python or Perl scripts for processing multi-gigabyte files.
- **Header List Preparation**: You can generate a list of all headers in a FASTA file to use as a template for selection using standard Unix tools:
  ```bash
  grep "^>" input.fasta | sed 's/>//' > all_headers.txt
  ```

## Reference documentation
- [selectfasta - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_selectfasta_overview.md)
- [GitHub - andvides/selectFasta](./references/github_com_andvides_selectFasta.md)