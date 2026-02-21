---
name: mustang-testdata
description: MUSTANG (MUltiple STructural AligNment) is a specialized tool for aligning multiple protein structures by analyzing the spatial coordinates of C-alpha atoms.
homepage: http://lcb.infotech.monash.edu.au/mustang/
---

# mustang-testdata

## Overview
MUSTANG (MUltiple STructural AligNment) is a specialized tool for aligning multiple protein structures by analyzing the spatial coordinates of C-alpha atoms. Unlike sequence-only aligners, MUSTANG uses a progressive pairwise heuristic followed by refinement passes to produce high-quality structural superpositions. This skill provides the necessary command-line patterns to manage input structures, configure output formats, and generate RMSD tables for structural comparison.

## Command Line Usage

### Basic Alignment
To align a set of PDB files located in the current directory:
```bash
mustang -i protein1.pdb protein2.pdb protein3.pdb -o my_alignment
```

### Using a Search Path
If your structures are stored in a specific directory, use the `-p` flag to define the path and `-i` to list the filenames:
```bash
mustang -p /path/to/pdb_files/ -i struct1.pdb struct2.pdb struct3.pdb -o output_prefix
```

### Batch Processing with Description Files
For large datasets, use a description file (`-f`) to avoid long command lines. This option is mutually exclusive with `-p` and `-i`.

**Description File Format:**
- Use `>` to specify the directory path.
- Use `+` to specify filenames.

*Example `structures.txt`:*
```text
> /home/user/data/pdbs/
+ 1abc.pdb
+ 2def.pdb
+ 3ghi.pdb
```

*Execution:*
```bash
mustang -f structures.txt -o batch_results
```

## Output Configuration

### Alignment Formats
Specify the alignment output format using `-F`. Supported formats include `html` (default), `fasta`, `pir`, and `msf`.
```bash
mustang -i s1.pdb s2.pdb -F fasta -o alignment_output
```

### Structural Superposition
By default, MUSTANG generates a PDB file containing the optimal superposition of all input structures.
- To disable: `-s OFF`
- To enable (default): `-s ON`

### RMSD and Rotation Matrices
To generate a detailed report containing the RMSD table, rotation matrices, and translation vectors for each structure:
```bash
mustang -i s1.pdb s2.pdb s3.pdb -r ON -o structural_data
```

## Best Practices
- **C-alpha Focus**: Remember that MUSTANG relies on C-alpha atom spatial information; ensure your PDB files contain valid ATOM records for C-alpha positions.
- **Output Identifiers**: Always provide a clear identifier with `-o`. MUSTANG will append appropriate extensions (e.g., `.html`, `.pdb`, `.msf`) to this prefix.
- **HTML Visualization**: Use the `-D` option to set a CA-CA diameter threshold. Residues exceeding this distance in the superposition will be highlighted in the HTML output, helping identify structurally divergent regions.

## Reference documentation
- [MUSTANG Home and Documentation](./references/lcb_infotech_monash_edu_mustang.md)
- [Bioconda Mustang Package Overview](./references/anaconda_org_channels_bioconda_packages_mustang_overview.md)