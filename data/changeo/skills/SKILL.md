---
name: changeo
description: Change-O is a specialized bioinformatics suite designed for the post-alignment processing of B cell and T cell receptor repertoires.
homepage: http://changeo.readthedocs.io
---

# changeo

## Overview
Change-O is a specialized bioinformatics suite designed for the post-alignment processing of B cell and T cell receptor repertoires. It serves as the foundational toolkit for the Immcantation framework, transforming raw alignment data into standardized, analysis-ready databases. Its primary utility lies in its ability to handle large-scale sequencing data, providing robust methods for clonal clustering and germline inference while maintaining compliance with Adaptive Immune Receptor Repertoire (AIRR) standards.

## Core Workflows and CLI Patterns

### 1. Database Generation (MakeDb.py)
The first step in any Change-O pipeline is converting alignment tool output into the Change-O/AIRR database format.

*   **From IgBLAST:**
    `MakeDb.py igblast -i alignment.fmt7 -s sequences.fasta -o output.tsv`
*   **From IMGT/HighV-QUEST:**
    `MakeDb.py imgt -i imgt_output.zip -s sequences.fasta`
*   **Key Tip:** Always ensure your input FASTA headers match the IDs in the alignment output. Use the `--format airr` flag (default in v1.0+) to ensure compatibility with modern downstream tools.

### 2. Filtering and Manipulation (ParseDb.py / FilterDb.py)
Clean your data before clonal assignment to remove low-quality or irrelevant sequences.

*   **Filter by field value:**
    `FilterDb.py select -d database.tsv -f V_CALL -u "IGHV" --regex`
*   **Remove sequences with junctions not divisible by 3:**
    `FilterDb.py junction -d database.tsv`
*   **Split database by a column:**
    `ParseDb.py split -d database.tsv -f SAMPLE`

### 3. Clonal Assignment (DefineClones.py)
Assigning sequences to clonal lineages is typically based on V-gene, J-gene, and Junction length homology.

*   **Standard Hamming distance clustering:**
    `DefineClones.py -d database.tsv --act set --model ham --norm len --dist 0.1`
*   **Expert Tip:** The distance threshold (`--dist`) is critical. It is recommended to determine this threshold using the `shazam` R package's distance-to-nearest distribution analysis before running `DefineClones.py`.

### 4. Germline Reconstruction (CreateGermlines.py)
Reconstruct the unmutated ancestral sequences for each clone.

*   **Using a reference genome:**
    `CreateGermlines.py -d database.tsv -g references/ -r imgt_germlines.fasta`
*   **Note:** This requires the specific V, D, and J segment libraries used during the initial alignment.

## Best Practices
*   **Standardization:** Use the AIRR Community Rearrangement standard format for all outputs to ensure interoperability with other tools like TIgGER, SHazaM, and Alakazam.
*   **Memory Management:** For very large repertoires (millions of sequences), use `ParseDb.py split` to process samples or specific gene families in parallel to reduce memory overhead.
*   **Sequence Integrity:** Always run `FilterDb.py junction` before clonal assignment to ensure that non-functional or out-of-frame sequences do not skew clonal grouping.

## Reference documentation
- [Change-O Documentation](./references/changeo_readthedocs_io_en_stable.md)
- [Bioconda Change-O Overview](./references/anaconda_org_channels_bioconda_packages_changeo_overview.md)