---
name: gamma
description: GAMMA (Gene Allele Mutation Microbial Assessment) is a specialized tool for identifying gene matches in microbial genomic assemblies.
homepage: https://github.com/rastanton/GAMMA
---

# gamma

## Overview
GAMMA (Gene Allele Mutation Microbial Assessment) is a specialized tool for identifying gene matches in microbial genomic assemblies. Unlike standard alignment tools that rely solely on nucleotide similarity, GAMMA evaluates matches based on protein-coding identity. It automatically translates and annotates sequences to identify specific changes such as nonsynonymous mutations, truncations, insertions/deletions (indels), and nonstop mutations. This makes it an essential tool for researchers needing to distinguish between known alleles and novel variants in genomic data.

## Command Line Usage

The basic syntax for running GAMMA requires a genome assembly, a gene database, and a prefix for the output files:

```bash
GAMMA.py <genome.fasta> <gene_db.fasta> <output_name> [options]
```

### Common Options and Flags
- `-i, --identity`: Set the minimum nucleotide sequence identity percentage (integer). Default is `90`.
- `-e, --extended`: Use this to return a full list of all mutations. By default, GAMMA only lists the first 10 mutations.
- `-f, --fasta`: Writes the sequences of all identified gene matches to a multifasta file.
- `-g, --gff`: Produces a General Feature Format (.gff) file, allowing you to visualize the gene matches in a genome browser.
- `-a, --all`: Includes all matches, including those that overlap on the same contig.
- `-n, --name`: Prepends the output name to every line in the `.gamma` file, which is useful when concatenating results from multiple runs.
- `-l, --headless`: Removes the header row from the tab-delimited output file.

## Output Interpretation
The primary output is a `.gamma` tab-delimited file containing 15 columns. Key columns to monitor include:
- **Match_Type**: Classifies the match (e.g., Native, Mutant, Truncation, Indel, Contig Edge).
- **Description**: Provides specific details, such as "Y190S mutant" or "truncation at residue 110."
- **Codon_Changes / BP_Changes**: Quantitative counts of non-degenerate codon and basepair differences.
- **Percent_Length**: Indicates how much of the target gene is covered (1.0 = 100% coverage).

## Best Practices
- **Database Selection**: GAMMA is optimized for use with curated AR gene databases such as ResFinder, ARG-ANNOT, or AMRFinderPlus.
- **Environment Setup**: Ensure `blat` is installed and available in your system `$PATH`, as GAMMA relies on it for the initial sequence search.
- **Visualization**: Always use the `-g` flag if you intend to verify the genomic context of a match (e.g., checking if a gene is located on a plasmid or the chromosome).
- **Handling Truncations**: Pay close attention to "Contig Edge" matches; these indicate the gene was cut off by the end of a sequence assembly rather than a biological stop codon.

## Reference documentation
- [GAMMA Overview](./references/anaconda_org_channels_bioconda_packages_gamma_overview.md)
- [GAMMA GitHub Repository and Usage](./references/github_com_rastanton_GAMMA.md)