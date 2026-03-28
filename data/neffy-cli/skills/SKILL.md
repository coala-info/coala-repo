---
name: neffy-cli
description: neffy-cli calculates the effective number of sequences in a multiple sequence alignment to measure alignment diversity while accounting for redundancy. Use when user asks to calculate NEFF values, quantify MSA diversity, or convert between different multiple sequence alignment file formats.
homepage: https://maryam-haghani.github.io/NEFFy
---

# neffy-cli

## Overview
NEFFy is a specialized bioinformatics tool used to quantify the effective number of sequences in a Multiple Sequence Alignment (MSA). By accounting for sequence similarity and redundancy, it provides a more accurate measure of alignment diversity than a simple sequence count. It supports protein, RNA, and DNA alphabets and includes a dedicated utility for converting between various MSA file formats.

## Core CLI Commands

### 1. NEFF Computation (`neff`)
The `neff` command calculates the effective number of sequences based on similarity thresholds and normalization options.

**Basic Usage:**
```bash
./neff --file=input.fasta --alphabet=0 --threshold=0.8
```

**Key Flags:**
- `--file=<files>`: Comma-separated list of input MSA files. If multiple files are provided, NEFFy integrates them for a single computation.
- `--alphabet=<0|1|2>`: Specifies the sequence type: `0` for Protein (default), `1` for RNA, `2` for DNA.
- `--threshold=<value>`: Similarity cutoff between 0 and 1 (default is `0.8`). Sequences with similarity above this value are clustered.
- `--norm=<0|1|2>`: Normalization method:
    - `0`: Normalize by the square root of sequence length (default).
    - `1`: Normalize by the sequence length.
    - `2`: No normalization.
- `--depth=<N>`: Limit computation to the first `N` sequences in the MSA.
- `--gap_cutoff=<value>`: Threshold (0 to 1) to remove gappy positions (default is `1`, no removal).
- `--pos_start` / `--pos_end`: Define a specific residue range (inclusive) for the calculation.

### 2. MSA Conversion (`converter`)
The `converter` utility allows for seamless format switching between supported MSA types.

**Basic Usage:**
```bash
./converter --file=input.fasta --format=fasta --out_format=stockholm
```

## Expert Tips and Best Practices

- **Handling Non-Standard Letters:** Use `--non_standard_option` to control how the tool treats ambiguous residues. Setting this to `1` or `2` is recommended when working with high-noise datasets to treat non-standard characters as gaps.
- **Query-Centric Analysis:** By default, `--omit_query_gaps=true` is active. This ensures the NEFF calculation is relative to the first sequence (the query), which is standard practice for MSA-based protein modeling.
- **Symmetry in Similarity:** If your workflow requires strict identity matching, consider setting `--is_symmetric=false` to change how gaps are weighted in the similarity cutoff calculation.
- **Validation:** Always use `--check_validation=true` when working with new datasets to ensure the sequences strictly adhere to the specified alphabet (Protein/RNA/DNA).
- **Performance:** For extremely large alignments, use the `--depth` flag to perform a representative calculation on the top sequences, which often provides a sufficient estimate of diversity while saving significant compute time.



## Subcommands

| Command | Description |
|---------|-------------|
| ./converter | This program converts the format of an input Multiple Sequence Alignment (MSA) file to that of an output MSA file. It supports various formats and can validate sequences against a specified alphabet. |
| ./neff | This program computes the Number of Effective Sequences (NEFF) for a given multiple sequence alignment (MSA). NEFF is used to assess the diversity of sequences by accounting for redundancy and sequence similarity. |

## Reference documentation
- [NEFFy README](./references/github_com_Maryam-Haghani_NEFFy_blob_main_README.md)
- [NEFFy Project Overview](./references/github_com_Maryam-Haghani_NEFFy.md)