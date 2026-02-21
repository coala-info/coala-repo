---
name: happer
description: happer is a lightweight bioinformatics tool designed to bridge the gap between a standard reference genome and individual-specific haplotype sequences.
homepage: https://github.com/bioforensics/happer/
---

# happer

## Overview

happer is a lightweight bioinformatics tool designed to bridge the gap between a standard reference genome and individual-specific haplotype sequences. By taking a reference FASTA file and a BED file containing phased alleles, it produces the mutated sequences representing each haplotype. This is essential for tasks such as variant simulation, creating personalized reference genomes, or validating phasing results in genomic studies.

## Command Line Usage

The primary way to use happer is via the command line to transform a reference sequence into a set of haplotype-specific sequences.

### Basic Syntax
```bash
happer --out <output_file.fasta> <reference.fasta> <alleles.bed>
```

### Input Requirements
*   **Reference FASTA**: Standard genomic reference file. Ensure the sequence IDs (e.g., `chr1`) match the first column of your BED file.
*   **Alleles BED**: A 4-column BED file where the 4th column contains the phased alleles separated by a pipe (`|`) character.

### BED Format Specification
The number of alleles in the 4th column defines the ploidy of the output.
*   **Diploid**: `C|T` (Generates two sequences: one with C, one with T)
*   **Tetraploid**: `A|G|T|C` (Generates four sequences)

**Example BED entry:**
`chr1    38827    38828    C|T`

## Python API Integration

For custom workflows, you can import happer directly into Python scripts. The `mutate` function acts as a generator, yielding labels and sequences.

```python
import happer

with open('refr.fasta', 'r') as seqfile, open('alleles.bed', 'r') as alleles:
    for label, haploseq in happer.mutate.mutate(seqfile, alleles):
        # label is the haplotype identifier
        # haploseq is the resulting mutated string
        print(f">{label}\n{haploseq}")
```

## Best Practices and Tips

*   **Coordinate System**: Ensure your BED file follows standard 0-based, half-open coordinates (the `Start` is 0-based and the `End` is 1-based).
*   **Consistency**: All loci in the BED file must have the same number of alleles (the same ploidy). If an individual is homozygous at a site, you must still provide both alleles (e.g., `A|A`).
*   **Memory Efficiency**: happer is designed to be minimal, but when working with large chromosomes, ensure you have sufficient RAM if processing sequences within Python strings.
*   **Installation**: The most reliable way to install the tool is via Bioconda:
    `conda install bioconda::happer`

## Reference documentation
- [happer GitHub README](./references/github_com_bioforensics_happer.md)
- [happer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_happer_overview.md)