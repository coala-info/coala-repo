---
name: folddisco
description: Folddisco is a bioinformatics tool that uses geometric hashing to search for discontinuous structural motifs across large protein structure databases. Use when user asks to search for specific motifs, identify functional sites, or perform whole structure searches across proteomes.
homepage: https://github.com/steineggerlab/folddisco
---

# folddisco

## Overview

Folddisco is a high-performance bioinformatics tool designed to locate structural motifs that are discontinuous in sequence but proximal in 3D space. By utilizing geometric hashing, it enables researchers to search through millions of protein structures or thousands of proteomes in seconds. This skill should be used for structural bioinformatics tasks including functional site discovery, structural annotation of uncharacterized proteins, and comparative structural analysis.

## CLI Usage and Patterns

### Building a Custom Index
Before querying, you must either download a pre-built index or generate one from a directory of PDB or mmCIF files.

```bash
folddisco index -p path/to/pdb_folder -i index/my_custom_index
```

### Querying a Specific Motif
To search for a specific motif, provide the query structure, the target index, and the specific residues forming the motif.

```bash
# Example: Searching for a catalytic triad (residues B57, B102, and C195)
folddisco query -i index/target_index -p query_structure.pdb -q B57,B102,C195
```

### Whole Structure Search
If the `-q` flag is omitted, Folddisco performs a "whole structure" search, identifying all possible motifs within the query protein and searching for them in the target index.

```bash
folddisco query -i index/target_index -p query_structure.pdb
```

## Motif Syntax and Substitutions

Folddisco supports a flexible syntax for defining query motifs:

*   **Residue Identification**: Use `ChainID` followed by `ResidueNumber` (e.g., `B57`).
*   **Ranges**: Inclusive ranges are supported (e.g., `1-10`).
*   **Lists**: Use comma-separated values for discontinuous residues (e.g., `A10,A50,B12`).
*   **Amino Acid Substitutions**: Use `:<ALT>` to allow alternative residues at a specific position:
    *   **Single alternative**: `164:H` (Position 164 must be Histidine).
    *   **Set of alternatives**: `247:ND` (Position 247 can be Asparagine or Aspartic Acid).

## Best Practices and Expert Tips

*   **Index Compatibility**: Ensure you are using the correct index version. Folddisco v2.0 requires `*.tar.lz4` indices. Legacy v1.0 indices (`*.tar.gz`) are incompatible with newer versions.
*   **Pre-built Resources**: For common tasks, leverage pre-built indices for the Human proteome, E. coli, Swiss-Prot, or AFDB50 to save significant computational time.
*   **Performance**: When building large indices, ensure sufficient disk space for the geometric hash tables. The tool is optimized for multi-threading and will utilize available CPU cores via the Rust `rayon` library.
*   **Input Formats**: The tool natively supports both `.pdb` and `.cif` formats. For high-throughput workflows, the `foldcomp` feature (if enabled during compilation) allows for compressed structure handling.



## Subcommands

| Command | Description |
|---------|-------------|
| folddisco index | Index PDB files for folddisco |
| folddisco query | Search for patterns in PDB files using an index. |

## Reference documentation
- [Folddisco GitHub README](./references/github_com_steineggerlab_folddisco_blob_master_README.md)
- [Bioconda Folddisco Overview](./references/anaconda_org_channels_bioconda_packages_folddisco_overview.md)