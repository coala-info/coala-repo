---
name: fastg2protlib
description: The `fastg2protlib` tool facilitates the creation of custom protein databases from genomic assembly graphs (FASTG format).
homepage: https://github.com/galaxyproteomics/fastg2protlib
---

# fastg2protlib

## Overview
The `fastg2protlib` tool facilitates the creation of custom protein databases from genomic assembly graphs (FASTG format). Unlike standard FASTA-based translation, this tool performs a depth-first search (DFS) on the assembly graph to capture all possible DNA traversals, ensuring that potential protein-coding sequences spanning across assembly edges are preserved. 

The workflow operates in two distinct phases:
1.  **Discovery Phase**: Converting FASTG graphs into a comprehensive SQLite database of potential peptides and an initial FASTA file for MSMS searching.
2.  **Refinement Phase**: Using MSMS-verified peptides to filter the SQLite database and generate a high-confidence final protein library with coverage scoring.

## Usage Instructions

### Installation
Install the tool via Bioconda:
```bash
conda install bioconda::fastg2protlib
```

### Phase 1: Generating the Initial Peptide Library
In this phase, the tool parses the FASTG file into a directed graph and performs a DFS traversal to concatenate DNA sequences.
- **Process**: DNA is translated to mRNA, split into proteins at stop codons, and cleaved into peptides.
- **Input**: A `.fastg` assembly file.
- **Output**: 
    - A SQLite database containing the relationships between traversals, proteins, and peptides.
    - A peptide FASTA file intended for searching against MSMS data.

### Phase 2: Refining the Library with Verified Peptides
Once MSMS search results are available, use the verified peptides to filter the candidate library.
- **Process**: The tool matches verified peptides against the SQLite database to identify the source proteins. It calculates a coverage score (verified vs. total peptide association).
- **Input**: 
    - The SQLite database from Phase 1.
    - A list or FASTA file of MSMS-verified peptide sequences.
- **Output**:
    - A filtered protein FASTA file.
    - A comma-delimited protein score text file.
    - An updated SQLite database.

### Best Practices and Expert Tips
- **Graph Complexity**: Because the tool uses DFS on all connecting edges, highly complex or fragmented FASTG files may result in a very large number of traversals. Monitor the size of the resulting SQLite database.
- **Filtering Parameters**: The tool automatically filters protein sequences based on length and amino acid redundancy. Ensure your assembly quality is sufficient to avoid excessive short, redundant fragments.
- **Database Persistence**: The SQLite database is the "source of truth" for the relationship between the genomic graph and the proteomic output. Always retain this file if you plan to perform the Phase 2 refinement later.
- **MSMS Verification**: For Phase 2, ensure the verified peptide list uses the exact sequences produced in Phase 1 to ensure successful database matching.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_galaxyproteomics_fastg2protlib.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fastg2protlib_overview.md)