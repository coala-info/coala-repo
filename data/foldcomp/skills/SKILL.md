---
name: foldcomp
description: Foldcomp compresses protein structure data by encoding backbone and side-chain torsion angles to significantly reduce file sizes. Use when user asks to compress PDB or mmCIF files, decompress structures, extract pLDDT scores or sequences, and calculate RMSD between structures.
homepage: https://github.com/steineggerlab/foldcomp
metadata:
  docker_image: "quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0"
---

# foldcomp

## Overview
Foldcomp is a specialized tool designed to compress protein structure data by encoding backbone and side-chain torsion angles rather than storing absolute 3D coordinates. This approach reduces file sizes to approximately 13 bytes per residue (around 6kb for an average protein), making it ideal for managing massive datasets like AlphaFoldDB or ESMAtlas. It supports single-chain PDB/mmCIF files and provides both a high-performance CLI and a Python API for rapid data retrieval.

## CLI Usage Patterns

### Compression
Compress individual files or entire directories into the `.fcz` format.
- **Single file**: `foldcomp compress <input.pdb|input.cif> [<output.fcz>]`
- **Batch (Directory/Tar)**: `foldcomp compress -t <threads> <input_dir|input.tar.gz> [<output_db>]`
- **Database Creation**: Use `-d` or `--db` to save the output as a Foldcomp database instead of individual files.

### Decompression
Restore compressed files to PDB format.
- **Single file**: `foldcomp decompress <input.fcz> [<output.pdb>]`
- **Subset extraction**: Use an ID list to extract specific entries from a database:
  `foldcomp decompress --id-list ids.txt <input.db> <output_dir>`

### Data Extraction
Extract metadata without full decompression to PDB.
- **pLDDT Scores**: `foldcomp extract --plddt <input.fcz> [<output.tsv>]`
  - Use `-p <1-4>` to control the precision/digits of the pLDDT output.
- **Sequences**: `foldcomp extract --amino-acid <input.fcz> [<output.fasta>]`

### Analysis and Validation
- **RMSD**: Calculate the Root Mean Square Deviation between two structures:
  `foldcomp rmsd <file1.pdb> <file2.pdb>`
- **Integrity Check**: Verify if a compressed file is valid:
  `foldcomp check <file.fcz>`

## Python API Best Practices

The Python interface is highly efficient for reading data directly into memory.

```python
import foldcomp

# Decompress to binary string
with open("protein.fcz", "rb") as f:
    fcz_data = f.read()
    name, pdb_content = foldcomp.decompress(fcz_data)

# Access structural properties as a dictionary
# Includes: phi, psi, omega, torsion_angles, residues, bond_angles, coordinates
data = foldcomp.get_data(fcz_data)
print(f"Sequence: {data['residues']}")
print(f"Phi angles: {data['phi']}")
```

## Expert Tips
- **Discontinuous Residues**: Foldcomp currently only supports single-chain structures. When batch processing, use `--skip-discontinuous` to avoid errors on complex PDB files.
- **Coordinate Anchors**: Use the `-b <number>` (break) option during compression to set the interval for saving absolute coordinates. A smaller interval increases accuracy and prevents error accumulation but slightly increases file size.
- **Prebuilt Databases**: Instead of compressing AlphaFoldDB yourself, use `foldcomp.setup('<dataset_name>')` in Python to download optimized pre-indexed versions (e.g., 'afdb_swissprot_v4', 'esmatlas').



## Subcommands

| Command | Description |
|---------|-------------|
| foldcomp | Command-line tool for compressing, decompressing, checking, and comparing protein structure files. |
| foldcomp | Compresses and decompresses biological structure files. |
| foldcomp | Command-line tool for compressing and decompressing protein structure files. |
| foldcomp | Command-line tool for manipulating PDB/CIF files, including compression, decompression, extraction, and comparison. |
| foldcomp | Compress and decompress protein structure files (PDB, CIF) and calculate RMSD. |

## Reference documentation
- [Foldcomp README](./references/github_com_steineggerlab_foldcomp_blob_master_README.md)
- [Python Examples Notebook](./references/github_com_steineggerlab_foldcomp_blob_master_foldcomp-py-examples.ipynb.md)