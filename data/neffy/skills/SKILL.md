---
name: neffy
description: neffy calculates the effective number of sequences in multiple sequence alignments and performs format conversions between common biological sequence files. Use when user asks to calculate the NEFF metric, analyze sequence diversity, or convert between MSA formats like FASTA, A2M, and Stockholm.
homepage: https://github.com/Maryam-Haghani/NEFFy
metadata:
  docker_image: "quay.io/biocontainers/neffy:0.1.1--py311he264feb_1"
---

# neffy

## Overview
The `neffy` tool provides a high-performance C++ engine (with a Python interface) designed to analyze sequence diversity within Multiple Sequence Alignments. Its primary function is calculating the NEFF metric, which accounts for sequence similarity to determine the effective number of homologous sequences. Beyond computation, it serves as a robust utility for interconverting common MSA formats while maintaining sequence integrity across different biological alphabets.

## NEFF Computation
Calculate the effective number of sequences using the `neff` command.

### Basic Usage
```bash
neff --file=input.fasta --threshold=0.8 --alphabet=0
```

### Key Parameters
- `--file`: Comma-separated list of MSA files. If multiple are provided, they are integrated before computation.
- `--alphabet`: Set the sequence type: `0` (Protein - default), `1` (RNA), or `2` (DNA).
- `--threshold`: Similarity cutoff (0.0 to 1.0). Sequences with similarity above this value are clustered. Default is `0.8`.
- `--norm`: Normalization method:
  - `0`: Square root of sequence length (default).
  - `1`: Sequence length.
  - `2`: No normalization (raw effective count).
- `--gap_cutoff`: Filter gappy positions. Positions with a gap fraction higher than this value (0.0 to 1.0) are removed.

### Advanced Analysis
- **Per-Residue NEFF**: Use `--residue_neff=true` to get column-wise diversity scores.
- **Multimer Support**: For complex assemblies, use `--multimer_MSA=true` combined with `--stoichiom=A2B1` and `--chain_length=100 50`.
- **Sub-alignment Analysis**: Use `--pos_start` and `--pos_end` to restrict calculation to a specific residue range.
- **Query-Centric**: Use `--omit_query_gaps=true` (default) to ignore positions that are gaps in the first (query) sequence.

## MSA Format Conversion
Use the `converter` command to transform alignment files.

### Basic Conversion
```bash
converter --in_file=input.fasta --out_file=output.a2m --out_format=a2m
```

### Supported Formats
The tool typically handles standard formats including FASTA, A2M, CLUSTAL, and STOCKHOLM.

### Conversion Tips
- **Validation**: Always keep `--check_validation=true` enabled to ensure sequences match the specified `--alphabet`.
- **Header Cleaning**: Use `--skip_lines=N` if your input file contains non-standard metadata headers before the alignment data.

## Expert Tips
- **Symmetry Matters**: By default, `neffy` uses asymmetric similarity (considering gaps in the denominator). Set `--is_symmetric=true` for standard identity calculations where gaps are treated as mismatches in both directions.
- **Non-Standard Residues**: Use `--non_standard_option=1` to treat non-standard letters (like 'X' or 'Z') as gaps during similarity calculations, which is often more accurate for structural modeling inputs.
- **Large Alignments**: For extremely deep MSAs, use `--depth=N` to cap the number of sequences processed if you only need a representative sample of the diversity.

## Reference documentation
- [NEFFy GitHub Repository](./references/github_com_Maryam-Haghani_NEFFy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_neffy_overview.md)