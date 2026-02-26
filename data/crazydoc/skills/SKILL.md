---
name: crazydoc
description: Crazydoc parses and converts stylized Microsoft Word documents into annotated Biopython records and GenBank files. Use when user asks to extract sequences from .docx files, convert Word documents to GenBank format, or visualize annotated sequences from text styling.
homepage: https://github.com/Edinburgh-Genome-Foundry/crazydoc
---


# crazydoc

## Overview
crazydoc is a specialized utility designed to bridge the gap between informal laboratory documentation and computational biology. It programmatically parses .docx files—a common but non-standard format for sequence storage—and interprets text styling (like background highlights or bolding) as sequence features. This allows for the automated conversion of human-readable notes into machine-readable Biopython records and annotated GenBank files.

## Installation
Install the library using pip or conda:

```bash
pip install crazydoc
# OR
conda install bioconda::crazydoc
```

## Core Workflows

### 1. Extracting Sequences from Word
To parse a document, initialize the parser by defining which styles should be treated as features.

```python
from crazydoc import CrazydocParser

# Define styles to track (e.g., highlight, bold, underline)
parser = CrazydocParser(['highlight_color', 'bold', 'underline'])

# Parse DNA sequences (default)
biopython_records = parser.parse_doc_file("sequences.docx")

# Parse Protein sequences
protein_records = parser.parse_doc_file("proteins.docx", is_protein=True)
```

### 2. Exporting to GenBank
Convert extracted records into standard annotated files.

```python
from crazydoc import records_to_genbank

# Saves DNA as .gbk or Protein as .gp
records_to_genbank(biopython_records)
```
*Note: Record names are automatically truncated to 20 characters to comply with GenBank standards.*

### 3. Visualizing Annotated Sequences
Generate plots of the sequences using the built-in sketcher.

```python
from crazydoc import CrazydocSketcher

sketcher = CrazydocSketcher()
for record in biopython_records:
    sketch = sketcher.translate_record(record)
    ax, _ = sketch.plot()
    ax.set_title(record.id)
```

### 4. Writing Stylized Word Documents
Create a "crazydoc" from an existing Biopython `SeqRecord`.

```python
from crazydoc import write_crazydoc

# Provide the record, the qualifier key for feature names, and the output path
write_crazydoc(my_record, 'label', 'annotated_output.docx')
```

## Best Practices
- **Explicit Style Definition**: When initializing `CrazydocParser`, explicitly include all styles used in the document (e.g., `font_color`, `italic`) to ensure no annotations are missed.
- **Protein Flagging**: Always set `is_protein=True` in both `parse_doc_file` and `records_to_genbank` when handling amino acids to ensure correct sequence types and file extensions.
- **Filename Safety**: Be aware that `records_to_genbank` automatically replaces slashes (`/`) with hyphens (`-`) in filenames.
- **Feature Mapping**: When writing documents, ensure your `SeqRecord` features have the qualifier key you specify in `write_crazydoc` (e.g., 'product' or 'note') to correctly label the styles in Word.

## Reference documentation
- [crazydoc GitHub Repository](./references/github_com_Edinburgh-Genome-Foundry_crazydoc.md)
- [crazydoc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crazydoc_overview.md)