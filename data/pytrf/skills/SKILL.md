---
name: pytrf
description: "pytrf detects perfect and imperfect tandem repeats within genomic sequences using a fast Python C extension. Use when user asks to find microsatellites, identify generic or approximate tandem repeats, or extract repeat sequences with flanking regions."
homepage: https://github.com/lmdu/pytrf
---


# pytrf

## Overview
The `pytrf` skill enables the rapid detection of tandem repeats within genomic sequences. Unlike the original TRF tool, `pytrf` is a lightweight Python C extension designed for speed and ease of integration into bioinformatics pipelines. It supports the identification of Simple Sequence Repeats (SSRs), generic tandem repeats with motifs up to 100 bp, and imperfect (approximate) repeats. Use this skill when you need to perform microsatellite discovery, characterize repetitive regions in a genome, or extract flanking sequences for primer design.

## Command Line Interface (CLI)
The `pytrf` CLI provides several subcommands for different repeat discovery tasks.

### Finding Perfect Short Tandem Repeats (SSRs)
Use `findstr` for standard microsatellite discovery where motifs are short and repeats are exact.
```bash
pytrf findstr input.fasta > output.tsv
```

### Finding Generic Tandem Repeats
Use `findgtr` for repeats with longer motifs (up to 100 bp).
```bash
pytrf findgtr input.fasta --min-motif 7 --max-motif 100 > output.tsv
```

### Finding Imperfect Tandem Repeats
Use `findatr` to identify approximate tandem repeats that may contain substitutions or indels.
```bash
pytrf findatr input.fasta > output.tsv
```

### Extracting Sequences
Use `extract` to retrieve the repeat sequence along with its flanking regions, which is essential for downstream applications like PCR primer design.
```bash
pytrf extract input.fasta repeats.tsv --flank 50 > sequences_with_flanks.tsv
```

## Python API Usage
For custom workflows, `pytrf` can be used directly within Python scripts. It is highly recommended to use `pyfastx` for efficient sequence parsing.

```python
import pytrf
import pyfastx

# Load genomic sequences
fa = pyfastx.Fastx('genome.fa', uppercase=True)

for name, seq in fa:
    # Find Short Tandem Repeats
    for ssr in pytrf.STRFinder(name, seq):
        print(ssr.as_string())
```

## Best Practices and Tips
- **Input Normalization**: Ensure sequences are in uppercase if your parser doesn't handle case sensitivity automatically, as repeat detection is often case-sensitive in C extensions.
- **Performance**: For large-scale genomic data, the CLI is generally faster for bulk processing, while the Python API is better for interactive filtering or complex logic.
- **Output Handling**: The tool typically outputs tab-delimited data. Redirect output to `.tsv` or `.bed` files for compatibility with other bioinformatics tools like Bedtools.
- **Motif Lengths**: Use `findstr` for motifs 1-6 bp (microsatellites) and `findgtr` for motifs >6 bp (minisatellites/VNTRs).

## Reference documentation
- [pytrf GitHub Repository](./references/github_com_lmdu_pytrf.md)
- [pytrf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pytrf_overview.md)