---
name: ac
description: "FAIL to generate CWL: ac not found in Singularity image. The image may not provide this executable."
homepage: https://github.com/cobilab/ac
---

# ac

## Overview
The `ac` tool is a specialized compressor optimized for the unique statistical properties of protein sequences. It employs a combination of multiple context models and substitutional tolerant models to achieve higher compression ratios than general-purpose utilities. The toolset consists of two main commands: `AC` for compressing raw sequences and `AD` for decompressing them back to their original state.

## Installation and Setup
Install the tool via Bioconda for the most stable environment:
```bash
conda install bioconda::ac
```
If building from source, ensure `cmake` is installed and run `cmake . && make` within the `src` directory.

## Compression (AC)
Use the `AC` command to compress amino acid files. By default, it generates a file with a `.co` extension.

### Basic Usage
```bash
AC [options] <input_file>
```

### Compression Levels
Adjust the compression intensity using the `-l` flag (1 to 7).
- **Level 1**: Fastest compression, lowest memory usage.
- **Level 2**: Balanced default for small to medium sequences.
- **Level 7**: Maximum compression, suitable for large proteomes or when storage is at a premium.

### Advanced Modeling
For expert users, `ac` allows fine-tuning of the context models using the `-tm` (target model) and `-rm` (reference model) flags.
- **Syntax**: `<context_size>:<alpha>:<gamma>/<mutations>:<estimator>:<gamma>`
- **Example**: `AC -tm 1:1:0.8/0:0:0 -tm 7:100:0.9/2:10:0.85 sequence.txt`

## Decompression (AD)
Use the `AD` command to restore compressed files. It typically outputs a file with a `.de` extension.

### Basic Usage
```bash
AD [options] <compressed_file>.co
```

## Common CLI Patterns
- **Verbose Mode**: Use `-v` to see compression statistics and model performance during the process.
- **Force Overwrite**: Use `-f` to overwrite existing output files without prompting.
- **Information Content**: Use `-e` to generate a `.iae` file containing the information content of the sequence, which is useful for bioinformatics analysis.
- **Multi-file Compression**: Separate multiple files using a colon (`:`) in the final argument.
  ```bash
  AC -l 4 file1.txt:file2.txt:file3.txt
  ```

## Expert Tips
- **Reference-based Compression**: If you have a similar protein sequence, use it as a reference with `-r <reference_file>` to significantly improve compression ratios for the target file.
- **Alphabet Threshold**: Use `-t <threshold>` to discard low-frequency characters from the alphabet if the dataset contains noise or non-standard amino acid codes that hinder compression.
- **Verification**: Always verify the integrity of the process by comparing the original file with the decompressed output using `cmp original.txt decompressed.de`.

## Reference documentation
- [ac - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ac_overview.md)
- [cobilab/ac: A lossless compression tool for Amino Acid sequences](./references/github_com_cobilab_ac.md)