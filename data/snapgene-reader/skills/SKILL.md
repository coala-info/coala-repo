---
name: snapgene-reader
description: The `snapgene-reader` skill enables the extraction of biological data from SnapGene's binary `.dna` format.
homepage: https://pypi.org/project/snapgene-reader/
---

# snapgene-reader

## Overview

The `snapgene-reader` skill enables the extraction of biological data from SnapGene's binary `.dna` format. This is essential for bioinformaticians who need to integrate SnapGene-designed plasmids or sequences into automated pipelines. The tool provides two primary pathways: a raw dictionary output for full metadata access and a Biopython-compatible SeqRecord output for immediate use with standard bioinformatics libraries.

## Installation

The package can be installed via pip or conda:

```bash
pip install snapgene_reader
# OR
conda install bioconda::snapgene-reader
```

## Python API Usage

The library is primarily used as a Python module. There are two main functions to import:

```python
from snapgene_reader import snapgene_file_to_dict, snapgene_file_to_seqrecord

file_path = 'my_plasmid.dna'

# 1. Convert to a Python Dictionary (Best for metadata/JSON export)
data_dict = snapgene_file_to_dict(file_path)

# 2. Convert to a Biopython SeqRecord (Best for sequence analysis)
seq_record = snapgene_file_to_seqrecord(file_path)
```

## Best Practices and Tips

### Choosing the Right Output
- **Use `snapgene_file_to_dict`** when you need to inspect the full internal structure of the SnapGene file, including specific formatting, notes, or custom metadata that might not map perfectly to the Biopython schema.
- **Use `snapgene_file_to_seqrecord`** when you intend to perform sequence alignments, translation, or export the file to other standard formats like GenBank or FASTA using `Bio.SeqIO`.

### Biopython Integration
Once converted to a `SeqRecord`, you can easily convert SnapGene files to other formats:

```python
from Bio import SeqIO
from snapgene_reader import snapgene_file_to_seqrecord

record = snapgene_file_to_seqrecord('input.dna')
with open('output.gbk', 'w') as f:
    SeqIO.write(record, f, 'genbank')
```

### Handling Large Batches
For high-throughput processing, use a standard Python glob pattern to convert directories of files:

```python
import glob
from snapgene_reader import snapgene_file_to_dict

for dna_file in glob.glob("*.dna"):
    data = snapgene_file_to_dict(dna_file)
    # Process data...
```

## Reference documentation
- [snapgene-reader PyPI Overview](./references/pypi_org_project_snapgene-reader_0.1.19.md)
- [Bioconda snapgene-reader Page](./references/anaconda_org_channels_bioconda_packages_snapgene-reader_overview.md)