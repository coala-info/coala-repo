---
name: genbank
description: The `genbank` tool provides a Python API and a command-line interface for interacting with Genbank genomic data.
homepage: https://github.com/deprekate/genbank
---

# genbank

## Overview
The `genbank` tool provides a Python API and a command-line interface for interacting with Genbank genomic data. It simplifies the hierarchical relationship between files, loci, and features, allowing for programmatic manipulation of genomic records. Use this skill to perform rapid format conversions, isolate specific genomic coordinates, or perform bulk updates to feature metadata without manual text editing.

## Command Line Usage

### Format Conversions
The `-f` flag determines the output format. Common patterns include:
- **Tabular Summary**: `genbank.py <file.gbk> -f tabular` (Extracts feature types and coordinates).
- **Full FASTA**: `genbank.py <file.gbk> -f fasta` (Whole genome sequence).
- **Nucleotide Features (FNA)**: `genbank.py <file.gbk> -f fna` (Extracts sequences for all features, e.g., CDS).
- **Amino Acid Features (FAA)**: `genbank.py <file.gbk> -f faa` (Translates features to protein sequences).

### Genomic Slicing
To isolate a specific region while maintaining feature context:
```bash
genbank.py <file.gbk> --slice <start>..<end>
```
*Note: Slicing can be combined with format flags (e.g., `--slice 1..500 -f coverage`).*

### Feature Editing Workflow
To update feature qualifiers (like renaming genes) in bulk:
1. **Export existing tags**: `genbank.py <file.gbk> -k <feature_type>:<tag> > labels.tsv`
2. **Modify the TSV**: Use standard text processing tools (sed, awk, or Excel) to update the second column.
3. **Apply updates**: `genbank.py <file.gbk> -e <feature_type>:<tag> < labels.tsv > updated.gbk`

### Coverage Analysis
To calculate the percentage of the genome covered by specific features:
```bash
genbank.py <file.gbk> -f coverage
```

## Python API Patterns

### Reading and Iterating
```python
from genbank.file import File

file = File('genome.gbk')
for locus in file:
    print(f"Locus: {locus.name()}")
    for feature in locus:
        print(feature)
```

### Programmatic Locus Creation
You can build records from scratch or add features manually:
```python
from genbank.locus import Locus

locus = Locus('my_locus', 'ATGC...')
# Add via Genbank-style string
locus.read_feature('CDS 1..9')
# Add via explicit parameters (type, strand, coordinates)
locus.add_feature('CDS', +1, [['10', '20']])
locus.write('genbank')
```

## Expert Tips
- **Coordinate Handling**: When using `add_feature`, coordinates are passed as a list of lists to support multi-segment features (joins).
- **Piping**: The CLI supports standard input/output, making it ideal for bioinformatics pipelines involving `grep` or `perl` for rapid metadata cleaning.
- **Integrity**: Use the tool to verify that feature locations align correctly with the underlying ORIGIN sequence after manual edits.

## Reference documentation
- [Genbank GitHub Repository](./references/github_com_deprekate_genbank.md)
- [Bioconda Genbank Package Overview](./references/anaconda_org_channels_bioconda_packages_genbank_overview.md)