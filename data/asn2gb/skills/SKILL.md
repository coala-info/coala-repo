---
name: asn2gb
description: The `asn2gb` tool is a specialized utility from the NCBI ToolBox designed to transform Abstract Syntax Notation One (ASN.1) formatted biological sequence data into standard flatfile formats.
homepage: https://www.ncbi.nlm.nih.gov/IEB/ToolBox/C_DOC/lxr/source/doc/asn2gb.txt
---

# asn2gb

## Overview
The `asn2gb` tool is a specialized utility from the NCBI ToolBox designed to transform Abstract Syntax Notation One (ASN.1) formatted biological sequence data into standard flatfile formats. While ASN.1 is the internal data storage format used by NCBI, most researchers and tools require GenBank (for DNA/RNA) or GenPept (for proteins) formats. This skill provides the necessary command-line patterns to perform these conversions efficiently, handling various input types such as single entries, submissions, or large sequence sets.

## Usage Patterns

### Basic Conversion
The most common use case is converting a single ASN.1 file to a GenBank flatfile.
```bash
asn2gb -i input.asn -o output.gb -f 1
```

### Format Selection (-f)
Specify the output format based on the data type:
- `-f 1`: GenBank (Default - used for nucleotide sequences)
- `-f 2`: GenPept (Used for protein sequences)
- `-f 3`: Feature Table (Used for annotation summaries)

### Input Mode (-m)
Match the input mode to the structure of your ASN.1 file:
- `-m 1`: Seq-entry (Single record)
- `-m 2`: Seq-submit (Submission package)
- `-m 3`: Seq-set (Multiple records/Batch)

### Style Selection (-s)
Control the layout of the output flatfile:
- `-s 1`: Normal (Standard GenBank/GenPept view)
- `-s 2`: Master (Used for segmented sequences)
- `-s 3`: Contig (Displays the assembly/contig information)

### Handling Gapped Sequences
For sequences containing gaps (e.g., large genomic scaffolds), use the `-g` flag:
- `-g T`: Show gaps in the output.
- `-g F`: Do not show gaps (Default).

## Best Practices
- **Batch Processing**: When dealing with large datasets, ensure `-m 3` is used if the input is a `Bioseq-set`.
- **File Extensions**: While `asn2gb` doesn't strictly enforce extensions, use `.asn` for input and `.gb` or `.gp` for output to maintain clarity in your pipeline.
- **Validation**: Always check the output file for "CONTIG" lines if you are converting large genomic records, as the `-s` style parameter significantly changes how assembly information is presented.
- **Binary vs. Text**: `asn2gb` typically expects text ASN.1. If you have binary ASN.1, you may need to convert it to text using `asndhuff` or `genev` first, though most modern NCBI downloads are provided in the appropriate text format.

## Reference documentation
- [asn2gb Overview](./references/anaconda_org_channels_bioconda_packages_asn2gb_overview.md)