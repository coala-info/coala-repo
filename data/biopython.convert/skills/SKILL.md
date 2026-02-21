---
name: biopython.convert
description: The `biopython.convert` tool is a command-line utility that leverages BioPython's `SeqIO` capabilities to transform biological data between formats.
homepage: https://github.com/brinkmanlab/BioPython-Convert
---

# biopython.convert

## Overview
The `biopython.convert` tool is a command-line utility that leverages BioPython's `SeqIO` capabilities to transform biological data between formats. Beyond simple conversion, it integrates JMESPath, allowing for sophisticated data manipulation, such as filtering records based on feature qualifiers or reshaping sequence metadata into structured JSON or text.

## Command Syntax
The basic structure for the command is:
`biopython.convert [options] <input_file> <input_type> <output_file> <output_type>`

### Core Arguments
- **input_file / output_file**: Paths to the source and destination files.
- **input_type / output_type**: Format identifiers (e.g., `fasta`, `genbank`, `gff3`, `json`, `text`).

### Options
- `-s`: **Split** records into separate files.
- `-q <query>`: Apply a **JMESPath query** to filter or transform records.
- `-i`: **Inspect** details of records during the conversion process.

## Supported Formats
Commonly used formats include:
- **Sequence**: `fasta`, `fastq`, `genbank` (or `gb`), `embl`, `swiss`, `abi`.
- **Alignment/Structural**: `clustal`, `nexus`, `phylip`, `stockholm`, `pdb-atom`, `cif-atom`.
- **Data/Metadata**: `gff3`, `tab`, `json`, `text`.

## JMESPath Querying
The root node for any query is a list of `SeqRecord` objects.

### Common Patterns
- **Filter by Feature**: Keep only records that are not plasmids.
  `-q "[?!(features[?type=='source'].qualifiers.plasmid)]"`
- **Select Specific Record**: Keep only the first record in a multi-record file.
  `-q "[0]"`
- **Extract Metadata**: Output a list of IDs and molecule types to a JSON file.
  `biopython.convert input.gb genbank output.json json -q "[*].{id: id, type: annotations.molecule_type}"`
- **Custom Functions**:
  - `extract(Seq, SeqFeature)`: Accesses `SeqFeature.extract()`.
  - `split()` and `let()`: Available for complex logic within the query.

## Expert Tips
- **Text Output**: When converting to `text`, the result of the JMESPath query is dumped directly. This is useful for creating custom tab-delimited reports or coordinate lists.
- **Batch Splitting**: Use the `-s` flag when you have a large GenBank file and need each entry as a separate FASTA file. The output filename will be used as a template.
- **Debugging Queries**: Convert your dataset to `json` first to visualize the object structure. This makes it easier to write accurate JMESPath expressions for the `SeqRecord` attributes.

## Reference documentation
- [BioPython-Convert GitHub Repository](./references/github_com_brinkmanlab_BioPython-Convert.md)
- [biopython.convert Overview](./references/anaconda_org_channels_bioconda_packages_biopython.convert_overview.md)