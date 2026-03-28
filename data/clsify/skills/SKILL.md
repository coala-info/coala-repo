---
name: clsify
description: The clsify tool automates the haplotyping of Candidatus Liberibacter solanacearum by analyzing Sanger sequencing reads against validated reference sequences. Use when user asks to identify Lso haplotypes, classify sequence files, or process Sanger reads using the DP 21 standard.
homepage: https://github.com/holtgrewe/clsify
---

# clsify

## Overview

The `clsify` tool (now transitioning to the name `hlso` or Haplotype-LSO) is a specialized bioinformatics utility designed for the automated haplotyping of *Candidatus Liberibacter solanacearum*. It processes Sanger sequencing reads—specifically those generated using the primers defined in the International Plant Protection Convention (IPPC) standard DP 21—and compares them against validated reference sequences. The tool calculates sequence identity to confirm the species and identifies specific haplotypes based on sequence variations, including support for indels.

## CLI Usage and Best Practices

The primary executable is `hlso` (formerly `clsify`). It accepts FASTA or FASTQ files as input and generates a TSV report.

### Basic Command Pattern

Process one or more sequence files into a single result table:

```bash
hlso -o result.tsv input_sequence.fasta
```

### Handling Multiple Samples

If you have a directory of individual Sanger reads (one per file), use wildcards. By default, the tool uses the sequence ID inside the file for the sample name. Use the `--use-file-name` flag to use the actual filename as the sample identifier instead:

```bash
hlso --use-file-name -o results.tsv samples/*.fasta
```

### Input Requirements

*   **Supported Formats**: FASTA, FASTQ, AB1, and SCF.
*   **Primer Regions**: The tool is optimized for the 16S, 16S-23S (ISR), and 50S (rplJ/rplL) regions specified in DP 21.
*   **Sample Mapping**: While sample names can be inferred from read names, you can provide a separate mapping TSV file if your naming convention is complex.

### Expert Tips

*   **Indel Normalization**: The tool automatically normalizes indels according to established standards (Tan et al., 2015), which is critical for accurate haplotyping in the Lso complex.
*   **Reference Alignment**: `hlso` performs alignment-based haplotyping using BLAST matches rather than simple SNP calling, making it more robust to the typical noise found at the ends of Sanger reads.
*   **Phylogenetic Analysis**: For advanced users, the tool can compute region-wise phylogenetic trees from the input data to visualize the relationship between your samples and known haplotypes.



## Subcommands

| Command | Description |
|---------|-------------|
| clsify cli | Classify sequence files and extract sample information using regular expressions. |
| clsify web | Start the clsify web server |

## Reference documentation

- [Haplotype-LSO GitHub Repository](./references/github_com_holtgrewe_haplotype-lso_blob_master_README.rst.md)
- [Haplotype-LSO History and Versioning](./references/github_com_holtgrewe_haplotype-lso_blob_master_HISTORY.rst.md)