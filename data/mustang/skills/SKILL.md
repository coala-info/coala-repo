---
name: mustang
description: Mustang performs multiple structural alignment of protein structures using spatial information to identify equivalent residues. Use when user asks to align three-dimensional protein structures, generate structural superpositions, or calculate RMSD tables for multiple PDB files.
homepage: http://lcb.infotech.monash.edu.au/mustang/
metadata:
  docker_image: "quay.io/biocontainers/mustang:3.2.4--h9948957_0"
---

# mustang

## Overview
Mustang (MUltiple STructural AligNment) is a specialized tool for comparing and aligning three-dimensional protein structures. Unlike sequence-only aligners, it uses spatial information to identify structurally equivalent residues across a set of proteins. This skill provides the necessary command-line patterns to execute alignments, manage input via description files, and generate various output formats including superposed PDB files and RMSD tables.

## Command Line Usage

### Basic Alignment
To align a set of PDB files located in the current directory:
```bash
mustang -i protein1.pdb protein2.pdb protein3.pdb -o my_alignment
```

### Using a Search Path
If structures are stored in a specific directory, use `-p` to define the path and `-i` for the filenames:
```bash
mustang -p /path/to/pdb_files/ -i struct1.pdb struct2.pdb -o results
```

### Managing Large Datasets (Description Files)
For many structures, use a description file (`-f`) to avoid command-line length limits. The file format requires specific prefixes:
- `>` for the directory path (optional)
- `+` for each filename

**Example `structures.txt`:**
```text
> /data/structures/pdbs/
+ 1abc.pdb
+ 2def.pdb
+ 3ghi.pdb
```
**Execution:**
```bash
mustang -f structures.txt -o large_alignment
```

## Output Configuration

### Alignment Formats
Specify the output format using `-F`. Supported formats include `html` (default), `fasta`, `pir`, and `msf`.
```bash
mustang -i s1.pdb s2.pdb -o aln_output -F fasta
```

### Structural Superposition
By default, Mustang generates a PDB file containing the optimal superposition of all input structures.
- To disable: `-s OFF`
- To generate an RMSD table, rotation matrices, and translation vectors: `-r ON`

### Quality Filtering
Use `-D` to highlight structural divergence in the HTML output. Residues where the C-alpha diameter exceeds the threshold will be reported in lower case with a grey background.
```bash
mustang -i s1.pdb s2.pdb -D 3.5
```

## Best Practices
- **Input Consistency**: Ensure all input files are in standard PDB format. Mustang relies on C-alpha atom coordinates.
- **Identifier Naming**: The `-o` flag acts as a prefix. If you set `-o my_run`, the tool will create `my_run.html`, `my_run.pdb`, etc.
- **Mutual Exclusion**: Do not combine `-f` with `-p` or `-i`. Use either the description file or the direct command-line arguments.

## Reference documentation
- [MUSTANG: Multiple protein structural alignment algorithm](./references/lcb_infotech_monash_edu_mustang.md)