---
name: jaligner
description: JAligner performs local and global alignments of biological sequences using the Smith-Waterman algorithm with affine gap penalties. Use when user asks to align two sequences, apply substitution matrices, or configure gap opening and extension penalties.
homepage: https://github.com/ahmedmoustafa/JAligner
---


# jaligner

## Overview
JAligner provides a robust Java-based environment for aligning two biological sequences. It utilizes the Smith-Waterman algorithm with Gotoh’s improvement to support affine gap penalties while maintaining high memory efficiency. This skill enables the execution of local and global alignments, the application of standard or user-defined substitution matrices, and the management of Java Virtual Machine (JVM) resources for high-throughput tasks.

## Command Line Usage
Execute alignments using the following syntax:
`java -jar jaligner.jar <s1> <s2> <matrix> <open> <extend>`

### Parameters
- **s1 / s2**: Paths to the input sequence files (typically in FASTA format).
- **matrix**: The name of a built-in scoring matrix (e.g., `BLOSUM62`, `PAM250`) or a relative/absolute path to a custom matrix file.
- **open**: The penalty for opening a gap (e.g., `10.0`).
- **extend**: The penalty for extending an existing gap (e.g., `0.5`).

### Example
`java -jar jaligner.jar sequence1.fasta sequence2.fasta BLOSUM62 11.0 1.0`

## Custom Scoring Matrices
To use a custom matrix, ensure the path provided in the command line contains at least one file separator (e.g., `./matrix.txt`). The file must follow this structure:
1. Optional comment lines starting with `#`.
2. A header line containing the alphabet characters.
3. Subsequent lines starting with a character from the alphabet followed by its substitution scores corresponding to the header.

## Memory Optimization
For large sequences, the default JVM heap size (64MB) may be insufficient. Increase the allocation pool using the `-Xms` (initial) and `-Xmx` (maximum) flags to prevent `OutOfMemoryError`:
`java -Xms256m -Xmx2g -jar jaligner.jar s1.fa s2.fa BLOSUM62 10.0 0.5`

## Best Practices
- **Matrix Selection**: Use `BLOSUM62` for general protein alignments. For highly divergent sequences, consider `PAM250`.
- **Gap Penalties**: Start with an open penalty of 10.0 and an extend penalty of 0.5. Adjust based on the expected evolutionary distance between sequences.
- **GUI Access**: Launch the graphical interface for interactive alignment by running the JAR without arguments: `java -jar jaligner.jar`.
- **Traceback Efficiency**: Note that JAligner maps the 2D traceback matrix into a 1D array to speed up memory allocation in the JVM.

## Reference documentation
- [JAligner Wiki](./references/github_com_ahmedmoustafa_JAligner_wiki.md)
- [JAligner Repository Overview](./references/github_com_ahmedmoustafa_JAligner.md)