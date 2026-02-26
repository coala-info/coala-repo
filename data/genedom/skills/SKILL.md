---
name: genedom
description: Genedom standardizes and domesticates genetic parts for DNA assembly by optimizing sequences and adding necessary flanking overhangs. Use when user asks to domesticate DNA sequences, generate assembly-compatible barcodes, or perform batch sequence optimization and reporting for synthetic biology projects.
homepage: https://github.com/Edinburgh-Genome-Foundry/genedom#
---


# genedom

## Overview
Genedom is a synthetic biology tool designed to standardize genetic parts for DNA assembly. It automates the process of "domestication"—the modification of a DNA sequence to ensure it is compatible with a specific laboratory standard (e.g., Golden Gate). The tool handles sequence optimization, the removal of internal restriction sites, and the addition of flanking overhangs. It is particularly useful for high-throughput workflows where large batches of sequences must be prepared, verified, and documented for synthesis or assembly.

## Core Workflows

### Single Part Domestication
To domesticate a single sequence, use the `GoldenGateDomesticator`. This allows you to define the required overhangs and the restriction enzyme used in the assembly.

```python
from genedom import GoldenGateDomesticator, write_record

# Define the domesticator with left/right overhangs and the assembly enzyme
domesticator = GoldenGateDomesticator("ATTC", "ATCG", enzyme='BsmBI')

# Perform domestication (set edit=True to allow sequence modifications)
results = domesticator.domesticate(sequence, edit=True)

# Export the domesticated GenBank record
write_record(results.record_after, 'domesticated_part.gb')
```

### Generating DNA Barcodes
Genedom can generate sets of unique barcodes that are compatible with specific assembly constraints (e.g., lacking specific restriction sites).

```python
from genedom import BarcodesCollection

# Generate 96 unique 20bp barcodes avoiding common Type IIS sites
barcodes = BarcodesCollection.from_specs(
    n_barcodes=96, 
    barcode_length=20, 
    forbidden_enzymes=('BsaI', 'BsmBI', 'BbsI')
)
barcodes.to_fasta('barcodes.fa')
```

### Batch Domestication and Reporting
For large projects, use `batch_domestication` to process multiple records simultaneously and generate a comprehensive report package (ZIP containing PDFs, FASTA, and Excel files).

```python
from genedom import BUILTIN_STANDARDS, load_record, batch_domestication

# Load multiple sequence files
records = [load_record(path) for path in list_of_paths]

# Run batch process using a built-in standard (e.g., EMMA)
batch_domestication(
    records, 
    'output_report.zip', 
    standard=BUILTIN_STANDARDS.EMMA
)
```

## Best Practices and Expert Tips

- **Sequence Editing**: Always set `edit=True` in the `domesticate` method if you want the tool to resolve constraint violations (like internal restriction sites) via synonymous mutations. If `edit=False`, the tool will only report whether the sequence is valid.
- **Traceability**: Use the `batch_domestication` routine even for small sets. The generated PDF reports provide essential traceability, showing exactly which nucleotides were changed and why, which is critical for troubleshooting failed assemblies.
- **Built-in Standards**: Check `genedom.BUILTIN_STANDARDS` before defining custom domesticators. Currently, it includes the EMMA standard, with more being added by the community.
- **Barcode Integration**: When generating barcodes for sequence verification, ensure the `forbidden_enzymes` list matches the enzymes used in your downstream assembly to prevent accidental cleavage.

## Reference documentation
- [Batch domestication of genetic parts with Python](./references/github_com_Edinburgh-Genome-Foundry_genedom.md)