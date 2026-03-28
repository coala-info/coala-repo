---
name: pxblat
description: PxBLAT is a Python binding library for the Blast-Like Alignment Tool that performs rapid DNA and protein sequence alignments. Use when user asks to align sequences, convert between FASTA and 2bit formats, build precomputed genomic indices, or run a BLAT server.
homepage: https://pypi.org/project/pxblat/
---

# pxblat

## Overview
PxBLAT is a high-performance Python binding library for the Blast-Like Alignment Tool (BLAT). It provides an ergonomic interface for bioinformaticians to perform rapid DNA and protein sequence alignments. This skill enables the use of PxBLAT's specialized features, such as precomputed indexing and FASTA-to-2bit conversion, which are essential for scaling alignment workflows beyond standard BLAT capabilities.

## Command Line Usage and Best Practices

### Index Management
PxBLAT improves alignment speed by using precomputed indices. Use the built-in indexing function to prepare your reference genome.

*   **Building an Index**: Generate a precomputed index for your reference sequence to significantly reduce startup time for multiple queries.
*   **Format Conversion**: Use the included utility scripts to convert genomic data into the optimized formats required by the tool.
    *   `fa2twobit.py`: Converts FASTA files to the .2bit format, which is the native compressed format for BLAT reference sequences.

### Common CLI Patterns
While PxBLAT is primarily a Python binding, it includes utility scripts for environment management and data preparation:

*   **Library Discovery**: Use `find_lib.py` to locate the compiled BLAT shared libraries if you encounter import errors in custom environments.
*   **Environment Setup**: Ensure `libhts` and `libssl` are present on the system (especially on Ubuntu/Linux environments) as they are core dependencies for the underlying C++ bindings.

### Expert Tips
*   **Memory Mapping**: PxBLAT leverages memory-mapped files for .2bit references. When working with large genomes (like human or mouse), ensure your system has sufficient virtual memory address space.
*   **macOS Compatibility**: For macOS users, ensure `MACOSX_DEPLOYMENT_TARGET` is set to 13.0 or higher if building from source to maintain compatibility with OpenSSL 3.x requirements.
*   **Performance**: Always prefer using a precomputed index (`build_index`) when the reference genome is static and you are performing batch queries.



## Subcommands

| Command | Description |
|---------|-------------|
| pxblat client | A client for the genomic finding program that produces a .psl file. |
| pxblat fatotwobit | Convert DNA from fasta to 2bit format. |
| pxblat server | Make a server to quickly find where DNA occurs in genome |
| pxblat twobittofa | Convert all or part of .2bit file to fasta. |

## Reference documentation
- [PxBLAT README](./references/github_com_ylab-hi_pxblat_blob_main_README.md)
- [PxBLAT Changelog](./references/github_com_ylab-hi_pxblat_blob_main_CHANGELOG.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pxblat_overview.md)