---
name: haplotype-lso
description: The haplotype-lso tool identifies and haplotypes Candidatus Liberibacter solanacearum from Sanger sequencing data. Use when user asks to identify Lso species, assign haplotypes to Sanger sequences, or process sequence data according to the IPPC DP 21 standard.
homepage: https://github.com/holtgrewe/haplotype-lso
---


# haplotype-lso

## Overview
The `haplotype-lso` tool (invoked via the `hlso` command) is a specialized bioinformatic utility designed to identify and haplotype *Candidatus Liberibacter solanacearum* (Lso) from Sanger sequencing data. It automates the alignment of sequences to specific GenBank reference sequences (EU812559 and EU834131) as mandated by the International Plant Protection Convention (IPPC) standard DP 21. The tool calculates sequence identity to confirm the species and identifies specific haplotypes based on variations from the reference.

## CLI Usage and Patterns

### Basic Haplotype Assignment
To process a single FASTA or FASTQ file containing Sanger sequences:
```bash
hlso -o results.tsv input.fasta
```

### Processing Multiple Samples
You can provide multiple input files or use wildcards. By default, the tool uses the sequence names within the files as sample identifiers.
```bash
hlso -o results.tsv sample1.fasta sample2.fasta sample3.fasta
```

### Using Filenames as Sample IDs
If your FASTA headers are generic (e.g., ">Read1") but your filenames contain the sample metadata, use the `--use-file-name` flag:
```bash
hlso --use-file-name -o results.tsv *.fasta
```

## Best Practices and Tips
- **Input Requirements**: Ensure your input sequences are derived from the 16S, 16S-23S, or 50S primers specified in the IPPC DP 21 standard.
- **Species Identification**: The output TSV includes sequence identity to EU822559. A high identity score here is the primary metric for confirming the presence of *C. Liberibacter solanacearum*.
- **Sample Mapping**: For complex datasets where neither the read name nor the filename is ideal, the tool supports a separate mapping TSV file to manage sample nomenclature.
- **Installation Note**: While the package is named `haplotype-lso`, the executable command is `hlso`. In older environments, the package might still be found under the name `clsify`.

## Reference documentation
- [Haplotype-LSO GitHub Repository](./references/github_com_holtgrewe_haplotype-lso.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_haplotype-lso_overview.md)