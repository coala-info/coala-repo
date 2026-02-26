---
name: biocode
description: Biocode is a collection of bioinformatics scripts and Python modules designed for genomic data manipulation, format conversion, and coordinate-based analysis. Use when user asks to generate sequence statistics, convert between genomic formats like GFF3 and GTF, filter FASTA files, or interact with biological entities via a Python API.
homepage: http://github.com/jorvis/biocode
---


# biocode

## Overview
The biocode library is a specialized collection of bioinformatics utility scripts and Python modules designed to simplify the handling of genomic data. Unlike more abstract libraries, biocode provides a "biologically-focused" API that allows for intuitive interactions with biological entities (like genes and mRNAs) and their coordinates. It is particularly effective for rapid scripting, format conversion, and extracting specific metrics from common sequence files.

## Installation and Setup
Biocode can be installed via pip or conda. If using the GitHub source directly, ensure the library path is added to your environment.

```bash
# Installation
pip3 install biocode
# OR
conda install -c bioconda biocode

# Manual setup (if cloning from source)
export PYTHONPATH=/path/to/biocode/lib:$PYTHONPATH
```

## Command Line Usage Patterns
Biocode scripts are organized by functional category. Most scripts follow a standard execution pattern: `python3 [category]/[script_name].py [options]`.

### Sequence Manipulation (FASTA/FASTQ)
*   **Statistics**: Use `fastq_simple_stats.py` to generate quick quality and length metrics for FASTQ files.
*   **Filtering**: Use `filter_fasta_by_header_regex.py` to extract specific sequences based on naming patterns.
*   **Cleaning**: Use `strip_fasta_headers_after_regex.py` to truncate long headers that may break downstream tools.
*   **Validation**: Use the mate pairing scripts in the `fastq` directory to ensure paired-end files are synchronized.

### Genomic Format Handling (GFF3/GTF/GenBank)
*   **Conversion**: Biocode provides scripts to convert between GFF3, GTF, and NCBI TBL formats.
*   **Annotation**: Use `add_blast_results_to_gff3_product.py` to update GFF3 functional annotations based on BLAST hits.
*   **Extraction**: Scripts in the `gff` and `gtf` directories allow for the extraction of specific feature types (e.g., only CDS or mRNA) from large annotation files.

### BLAST and HMM Processing
*   **Massaging**: The `blast` directory contains utilities to reformat or filter BLAST output for easier parsing.
*   **HMM**: Use scripts in the `hmm` directory for merging or reading HMM libraries.

## Python API Best Practices
When writing custom scripts, leverage the `biocode` modules for cleaner code.

### Parsing GFF3
The `biocode.gff` module can parse complex GFF3 hierarchies into objects with a single call:
```python
import biocode.gff
(assemblies, features) = biocode.gff.get_gff3_features(input_file_path)
```

### Biological Object Interaction
Use `biocode.things` to interact with features using biological terminology rather than generic dictionary lookups:
```python
# Biocode approach
for gene in assembly.genes():
    for mRNA in gene.mRNAs():
        # Perform actions
```

### Coordinate Comparisons
Biocode simplifies spatial logic on the same molecule:
```python
# Check if thing1 is upstream of thing2
if thing1 < thing2:
    pass

# Check for overlaps
if thing1.overlaps(thing2):
    print(thing1.overlap_size_with(thing2))
```

## Expert Tips
*   **SO Compliance**: The `biocode.things` module follows the Sequence Ontology (SO). Ensure your input feature types match SO terms for the best results when using the Python API.
*   **Memory Management**: When processing very large GFF3 files, use the `features` dictionary returned by the parser to access specific IDs directly rather than iterating through the entire assembly tree.
*   **Progress Tracking**: Many newer biocode scripts (like `fastq_simple_stats.py`) support progress intervals; check `--help` for flags to enable stderr progress reporting during long runs.

## Reference documentation
- [biocode GitHub Repository](./references/github_com_jorvis_biocode.md)
- [biocode Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_biocode_overview.md)