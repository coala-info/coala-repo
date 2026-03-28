---
name: biocode
description: Biocode provides a standardized library and CLI utilities for handling biological entities and performing common bioinformatics tasks like coordinate comparisons and format conversions. Use when user asks to handle genomic features, perform coordinate comparisons, convert between file formats like GFF3 and GenBank, or process FASTA and FASTQ files.
homepage: http://github.com/jorvis/biocode
---

# biocode

## Overview
The biocode library provides a standardized way to handle biological entities (referred to as "biothings") such as genes, mRNAs, and exons. It is designed to simplify common bioinformatics tasks—like coordinate comparisons and functional annotation—by providing a more biologically-intuitive API than general-purpose libraries. It also includes a vast repository of CLI utilities categorized by data format.

## Installation and Setup
To use the biocode Python libraries in your environment:
- **Pip**: `pip3 install biocode`
- **Manual**: Clone the repository and add the library path to your environment:
  ```bash
  export PYTHONPATH=/path/to/biocode/lib:$PYTHONPATH
  ```

## Python API Best Practices
Use the `biocode.things` module for object-oriented interaction with genomic features.

### Feature Navigation
Instead of generic sub-feature getters, use the direct biological methods:
```python
# Load features from a GFF3
import biocode.gff
(assemblies, features) = biocode.gff.get_gff3_features( "input.gff3" )

for assembly in assemblies:
    for gene in assembly.genes():
        for mrna in gene.mRNAs():
            # Access underlying CDS or Exons
            cds_list = mrna.CDSs()
```

### Coordinate Comparisons
Biocode supports intuitive operators for spatial relationships on the same molecule:
- `gene1 < gene2`: Checks if gene1 is upstream of gene2.
- `thing1.overlaps(thing2)`: Boolean check for any overlap.
- `thing1.contained_within(thing2)`: Boolean check for containment.
- `thing1.overlap_size_with(thing2)`: Returns the number of overlapping bases.

## CLI Utility Patterns
Scripts are organized by format-specific directories. Common tasks include:

| Directory | Common Tasks |
| :--- | :--- |
| **fasta** | Filtering by ID/regex, size distribution plots, and format conversion. |
| **fastq** | Validation of mate pairs and generating simple statistics. |
| **gff / gtf** | Conversions between GFF3, GTF, and BED; extracting specific feature types. |
| **blast** | Massaging or reformatting BLAST output; adding BLAST results to GFF3 products. |
| **genbank** | Converting GenBank flat files to GFF3 or other formats. |
| **sam_bam** | Parsing and basic analysis of alignment files. |

### Example: GFF3 Parsing
To quickly parse a GFF3 file into a dictionary of features keyed by ID:
```python
import biocode.gff
features = biocode.gff.get_gff3_features(input_file_path)[1]
```



## Subcommands

| Command | Description |
|---------|-------------|
| add_blast_results_to_gff3_product.py | Updates GFF3 files with gene products from BLAST |
| fastq_simple_stats.py | Provides simple quantitative statistics for a given FASTQ file |
| filter_fasta_by_header_regex.py | Filters a FASTA file by user-supplied regular expression to match the headers |
| strip_fasta_headers_after_regex.py | Modified the headers of a FASTA file based on user options |

## Reference documentation
- [Biocode GitHub Repository](./references/github_com_jorvis_biocode.md)