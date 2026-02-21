---
name: censtats
description: `censtats` is a specialized bioinformatics toolkit designed for the statistical characterization of centromeres.
homepage: https://github.com/logsdon-lab/CenStats
---

# censtats

## Overview

`censtats` is a specialized bioinformatics toolkit designed for the statistical characterization of centromeres. It provides a suite of tools to quantify the physical dimensions of centromeric arrays and the sequence complexity of these highly repetitive regions. Use this skill to automate the estimation of HOR array lengths, identify non-redundant centromere sets, and analyze sequence identity or entropy across centromeric regions, particularly in the context of high-quality genome assemblies like T2T (Telomere-to-Telomere).

## Command Line Usage

The `censtats` utility uses a subcommand-based interface: `censtats [subcommand] [options]`.

### Estimating HOR Array Length
The `length` subcommand estimates the length of Higher-Order Repeat (HOR) arrays. It typically requires input from `HumAS-HMMER` and a `.stv.bed` file.

```bash
censtats length --stv [file.stv.bed] --humas [humas_output.txt] --out [output_prefix]
```

**Key Parameters:**
- `-r`: Use with a RepeatMasker BED file to avoid merging across non-centromeric repeat regions.
- `-s`: Output individual array lengths in addition to the summary.
- `--min_arr_len`: Filter for a minimum array length.
- `--min_arr_prop`: Filter for a minimum proportion of HOR units within the array.

### Sequence Entropy Analysis
`censtats` provides two ways to calculate Shannon entropy (complexity) for centromeric regions.

**1. RepeatMasker-based Entropy:**
Calculates the Shannon index across a region based on annotated repeats.
```bash
censtats entropy --rm [repeatmasker.out] --region [chr:start-end]
```

**2. K-mer-based Entropy:**
Calculates windowed Shannon entropy directly from a FASTA file using k-mer sets.
```bash
censtats kmer-entropy --fasta [input.fasta] --window [size] --step [size] --kmer [k-size]
```

### Self-Identity Analysis
The `self-ident` subcommand calculates 1D or 2D average nucleotide identity (ANI) using a k-mer-based containment index. This is an efficient alternative to traditional dot plots for visualizing centromere periodicity.

```bash
censtats self-ident --fasta [input.fasta] --window [size] --kmer [k-size]
```

### Managing Redundancy
If you have multiple lists of centromere HOR array lengths (e.g., from different assembly versions or tools), use `nonredundant` to generate a consolidated list.

```bash
censtats nonredundant --list1 [lengths1.txt] --list2 [lengths2.txt] --out [output.txt]
```

## Best Practices and Tips

- **Input Preparation**: Ensure your `.stv.bed` files are correctly formatted according to the Logsdon Lab standards, as the `length` command is sensitive to the column structure of these files.
- **Window Selection**: When using `self-ident` or `kmer-entropy`, choose a window size that reflects the expected size of the HOR unit (e.g., ~2kb for many human alpha-satellite HORs) to capture meaningful periodicity.
- **Filtering**: Use the `--min_arr_prop` flag in the `length` command to exclude "noisy" regions where the HOR structure is fragmented or poorly defined.
- **Performance**: For large assemblies, `self-ident` is significantly faster than alignment-based ANI tools because it utilizes k-mer containment logic derived from ModDotPlot.

## Reference documentation
- [CenStats GitHub Repository](./references/github_com_logsdon-lab_CenStats.md)
- [CenStats Wiki](./references/github_com_logsdon-lab_CenStats_wiki.md)