---
name: kakscalculator2
description: kakscalculator2 calculates the ratio of nonsynonymous to synonymous substitutions to estimate selective pressure on coding sequences. Use when user asks to calculate Ka/Ks ratios, perform sliding window selection analysis, or estimate evolutionary constraints on aligned sequences.
homepage: https://github.com/kullrich/kakscalculator2
---


# kakscalculator2

## Overview

`kakscalculator2` is a specialized toolkit designed for molecular evolution studies. It calculates the ratio of nonsynonymous to synonymous substitutions (Ka/Ks or ω), which serves as a primary indicator of selective pressure on coding sequences. This version (2.0) extends the original software by incorporating gamma series methods to account for variable substitution rates across sites and sliding window strategies to detect selection within specific regions of a gene. Use this skill when you need to process aligned coding sequences to understand their evolutionary constraints.

## Command Line Usage

The primary executable is `KaKs_Calculator`. It requires an input file in AXT format and produces a tabular output file.

### Basic Syntax
```bash
KaKs_Calculator -i <input_file> -o <output_file> -m <method>
```

### Common Parameters
- `-i`: Input file in AXT format.
- `-o`: Output file name.
- `-m`: Calculation method (e.g., YN, MYN, GY, LWL, MLWL, LPB, MLPB, NG, LWL, MS, MA, GYN).
- `-c`: Genetic code table (Default = 1, Standard Code).
- `-w`: Window size for sliding window analysis.
- `-s`: Step size for sliding window analysis.
- `-h`: Display help and all available methods.

### Example Command
To calculate Ka/Ks using the Yang-Nielsen (YN) method:
```bash
KaKs_Calculator -i example.axt -o results.kaks -m YN
```

## Input Format (AXT)

The tool requires sequences in AXT format. Each entry consists of three lines:
1. **Header**: Sequence name/ID.
2. **Sequence 1**: The first aligned coding sequence.
3. **Sequence 2**: The second aligned coding sequence.
Each entry is separated by a blank line.

**Note**: Sequences must be correctly aligned, in-frame, and their lengths must be multiples of three.

## Expert Tips and Best Practices

- **Method Selection**: While many methods are available, **MYN** (Modified Yang-Nielsen) is often preferred as it accounts for variable substitution rates and transition/transversion bias more effectively than simpler models like NG.
- **Sliding Window Analysis**: Use the `-w` and `-s` flags to identify specific domains under positive selection within a long gene, rather than averaging the signal across the entire sequence.
- **Genetic Codes**: If working with mitochondrial DNA or specific organisms (e.g., Ciliates, Yeast), ensure you specify the correct genetic code using the `-c` flag to avoid incorrect Ka/Ks calculations.
- **Data Cleaning**: Remove gaps and stop codons from your alignment before conversion to AXT, as these can lead to errors or biased estimates in the substitution rates.

## Reference documentation
- [kakscalculator2 GitHub Repository](./references/github_com_kullrich_kakscalculator2.md)
- [kakscalculator2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kakscalculator2_overview.md)