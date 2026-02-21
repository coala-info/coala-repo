---
name: sativa
description: SATIVA (Semi-Automatic Taxonomy Improvement and Validation Algorithm) is a specialized pipeline for bioinformaticians to audit and refine taxonomic metadata.
homepage: https://github.com/amkozlov/sativa
---

# sativa

## Overview
SATIVA (Semi-Automatic Taxonomy Improvement and Validation Algorithm) is a specialized pipeline for bioinformaticians to audit and refine taxonomic metadata. By leveraging the Evolutionary Placement Algorithm (EPA) and RAxML, it evaluates whether a sequence's taxonomic label matches its phylogenetic position. If a discrepancy is found, SATIVA identifies the sequence as a "mislabel" and provides a confidence score along with a suggested taxonomic correction.

## Command Line Usage

### Basic Execution
To run a standard validation, you must provide an alignment file, a taxonomy file, and a nomenclature code.

```bash
sativa.py -s alignment.phy -t taxonomy.tax -x BAC -T 2
```

### Core Arguments
- `-s <file>`: Input sequence alignment in FASTA or PHYLIP format.
- `-t <file>`: Taxonomic annotations in a text file. Sequence names must match those in the alignment file.
- `-x <code|file>`: Nomenclature code. Use `BAC` for Bacteria and Archaea, or provide a custom rank file.
- `-T <int>`: Number of threads. If omitted, SATIVA uses all available logical CPUs.
- `-n <string>`: Prefix for output files.

### Handling Synonyms
If your dataset contains equivalent taxonomic names (e.g., non-preferred synonyms), use a synonym file to group them. The first name in each line is treated as the primary/preferred name.

```bash
sativa.py -s test.phy -t test.tax -x BAC -Y synonyms.txt
```

## Best Practices and Expert Tips

- **Thread Management**: On shared high-performance computing (HPC) clusters, always specify `-T`. SATIVA's default behavior of using all logical CPUs can lead to significant performance degradation if the system is oversubscribed.
- **Nomenclature Codes**: Ensure the `-x` parameter matches your target domain. While `BAC` is standard for prokaryotes, custom rank files are necessary for other domains to ensure the algorithm understands the taxonomic hierarchy.
- **Input Validation**: Ensure sequence IDs in the alignment file (`-s`) and the taxonomy file (`-t`) are identical. Discrepancies in naming will cause the sequences to be ignored or the process to fail.
- **Interpreting Results**: The primary output is a text file listing mislabeled sequences. Focus on entries with high confidence scores; low-confidence suggestions may indicate "dark matter" sequences or areas of the tree with poor phylogenetic resolution rather than simple mislabeling.
- **Memory Optimization**: For very large alignments, ensure your environment has sufficient RAM for RAxML likelihood computations, as memory usage scales with the number of sequences and alignment length.

## Reference documentation
- [SATIVA GitHub Repository](./references/github_com_amkozlov_sativa.md)
- [Bioconda SATIVA Overview](./references/anaconda_org_channels_bioconda_packages_sativa_overview.md)