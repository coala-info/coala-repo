---
name: pymummer
description: "pymummer provides a Python 3 interface for the MUMmer alignment package to automate genomic sequence alignment and parse output files into structured objects. Use when user asks to run nucmer alignments, parse coordinate or SNP files, filter genomic hits, or calculate identity between sequences."
homepage: https://github.com/sanger-pathogens/pymummer
---


# pymummer

## Overview
The `pymummer` skill provides a streamlined Python 3 interface for the MUMmer alignment package. It automates the execution of command-line utilities such as `nucmer`, `delta-filter`, `show-coords`, and `show-snps`, while providing a robust API to parse the resulting output files. Instead of manually handling text-based alignment reports, this skill allows you to treat genomic hits as structured Python objects, facilitating tasks like filtering self-hits, calculating identity, and extracting variant information.

## Core Workflow
The standard procedure involves initializing a runner for the alignment, executing the process, and then using a reader to iterate through the results.

### Running an Alignment
Use the `nucmer.Runner` class to execute the alignment. This wraps the `nucmer` command and subsequent processing steps.

```python
from pymummer import nucmer

# Initialize the runner
# reference_file: Path to reference FASTA
# query_file: Path to query FASTA
# results_file: Path where the output coords/snps will be stored
runner = nucmer.Runner("reference.fasta", "query.fasta", "output.coords", maxmatch=True)

# Execute the alignment
runner.run()
```

### Parsing Results
Once the alignment is complete, use the `coords_file.reader` to process the output.

```python
from pymummer import coords_file

file_reader = coords_file.reader("output.coords")

# Iterate through alignment objects
for hit in file_reader:
    if hit.is_self_hit():
        continue
    
    # Access alignment attributes
    print(f"Ref: {hit.ref_name} | Query: {hit.qry_name}")
    print(f"Identity: {hit.percent_identity}%")
    print(f"Length: {hit.hit_length_ref}")
```

## Tool-Specific Best Practices

### Filtering Results
The `nucmer.Runner` class allows for integrated filtering during the execution phase, which is more efficient than post-processing large coordinate files.
- **`min_id`**: Set a minimum percentage identity (e.g., `95`) to ignore low-quality matches.
- **`min_length`**: Set a minimum alignment length to filter out short, spurious hits.
- **`maxmatch`**: Set to `True` if working with closely related sequences where you want to find all matches regardless of their uniqueness.

### Handling SNPs
If your analysis requires variant calling, enable the SNP caller within the runner:

```python
runner = nucmer.Runner(
    "ref.fa", 
    "query.fa", 
    "output.snps", 
    show_snps=True, 
    snps_header=True
)
runner.run()
```

### Alignment Object Utilities
The `alignment` objects returned by the reader provide several helper methods:
- **`hit.is_self_hit()`**: Quickly identify if the reference and query sequences are the same.
- **`hit.reverse_query()`**: Check if the query aligned in the reverse orientation.
- **Coordinate Translation**: Use the alignment objects to map specific positions from the query to the reference.

## Installation and Environment
- **Conda**: `conda install bioconda::pymummer`
- **Pip**: `pip install pymummer`
- **Dependency Note**: Ensure `MUMmer` (specifically version 3 or 4) is installed and available in your system PATH, as `pymummer` is a wrapper and does not include the binary executables.

## Reference documentation
- [pymummer GitHub Repository](./references/github_com_sanger-pathogens_pymummer.md)
- [pymummer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pymummer_overview.md)