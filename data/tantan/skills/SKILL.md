---
name: tantan
description: tantan identifies and masks simple regions and tandem repeats in DNA or protein sequences. Use when user asks to mask repetitive regions, identify tandem repeats, or soft-mask sequences for homology searches.
homepage: http://cbrc3.cbrc.jp/~martin/tantan/
metadata:
  docker_image: "quay.io/biocontainers/tantan:51--h5ca1c30_1"
---

# tantan

## Overview

tantan is a specialized tool for identifying and masking "simple" regions in biological sequences. Unlike repeat maskers that rely on databases of known elements, tantan uses a statistical model to detect regions with low compositional complexity or periodic patterns (tandem repeats). Masking these regions is a standard best practice in bioinformatics to improve the specificity of homology searches and prevent computational resources from being wasted on non-functional repetitive alignments.

## Common CLI Patterns

### Basic DNA Masking
By default, tantan assumes DNA input and outputs the sequence with repetitive regions masked by the character 'N'.
```bash
tantan input.fasta > masked.fasta
```

### Protein Sequence Masking
When working with amino acid sequences, you must specify the protein option.
```bash
tantan -p protein.fasta > masked_protein.fasta
```

### Soft-Masking
Soft-masking preserves the original sequence characters but converts them to lowercase. This is often preferred for aligners like `LAST` that can utilize soft-masked information during the alignment extension phase while ignoring it during initial seeding.
```bash
tantan -c input.fasta > soft_masked.fasta
```

### Custom Masking Character
To use a specific character for hard-masking (e.g., 'X' for proteins or '?' for specific workflows):
```bash
tantan -x X protein.fasta > hard_masked.fasta
```

## Expert Tips and Best Practices

- **Integration with LAST**: tantan is designed to work seamlessly with the `LAST` aligner. If you are preparing a database for `lastdb`, it is common to pipe the output: `tantan sequence.fa | lastdb my_db -`.
- **Adjusting Sensitivity**: The `-r` option controls the probability of a repeat starting. The default is 0.005. If you find the tool is too aggressive (masking functional domains) or too lenient, you can adjust this value (e.g., `-r 0.01` for higher sensitivity).
- **Handling Large Files**: tantan is efficient and can process large genomes. It reads from standard input and writes to standard output, making it ideal for inclusion in Unix pipes to avoid creating large intermediate files.
- **Preserving Case**: If your input file already contains lowercase characters that you wish to ignore or treat differently, be aware that `tantan`'s default behavior or the `-c` flag will modify the case of the output.

## Reference documentation

- [tantan Overview](./references/anaconda_org_channels_bioconda_packages_tantan_overview.md)