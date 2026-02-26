---
name: degenotate
description: "degenotate characterizes evolutionary constraints on coding sites by calculating their degeneracy from genome assemblies and structural annotations. Use when user asks to annotate site-by-site degeneracy, perform standard or imputed McDonald-Kreitman tests, or extract specific coding sequences and degenerate sites."
homepage: https://github.com/harvardinformatics/degenotate
---


# degenotate

## Overview

degenotate is a specialized bioinformatics tool designed to characterize the evolutionary constraints on coding sites by calculating their degeneracy. It processes genome assemblies alongside structural annotations to produce site-by-site degeneracy maps (BED format) and can integrate variant data (VCF) to perform standard and imputed McDonald-Kreitman tests. This tool is particularly useful for researchers studying selective pressures, as it automates the classification of sites where mutations are likely to be synonymous versus non-synonymous.

## Core Workflows

### 1. Basic Degeneracy Annotation
To annotate every coding site in a genome using a standard assembly and annotation file:

```bash
degenotate.py -a <annotation.gff/gtf> -g <genome.fasta> -o <output_dir>
```

### 2. McDonald-Kreitman (MK) Testing
To perform MK tests (standard and imputed) on every coding transcript, provide a VCF and specify outgroup samples:

```bash
degenotate.py -a <annotation.gff> -g <genome.fasta> -v <variants.vcf> -u <outgroup_sample_id> -o <output_dir> -sfs
```
*Note: VCF functionality requires Python 3.10+ and the `pysam`, `NetworkX`, and `scipy` libraries.*

### 3. Sequence Extraction
degenotate can extract specific subsets of genomic data based on the annotation:

- **Extract all CDS (nucleotides):** Use `-c <output.fasta>`
- **Extract longest transcript per gene (nucleotides and amino acids):**
  ```bash
  degenotate.py -a <annotation.gff> -g <genome.fasta> -l <cds_out.fa> -la <aa_out.fa> -o <output_dir>
  ```
- **Extract sites by degeneracy (e.g., 4-fold degenerate sites):** Use `-x 4`

## Degeneracy Classification Reference

| Fold | Description |
| :--- | :--- |
| **0** | Non-degenerate; any mutation changes the amino acid. |
| **2** | Two nucleotides code for the same AA; 1/3 mutations is synonymous. |
| **3** | Three nucleotides code for the same AA; 2/3 mutations are synonymous. |
| **4** | Four nucleotides code for the same AA; all 3 possible mutations are synonymous. |

## Expert Tips and Best Practices

- **Installation:** Always prefer the Bioconda installation (`conda install bioconda::degenotate`) to ensure complex dependencies like `pysam` and `scipy` are correctly linked.
- **Input Flexibility:** If you do not have a full genome and GFF, you can run degenotate on a directory of individual coding sequence FASTAs using the `-s <directory>` flag.
- **Output Interpretation:** The primary output is `degeneracy-all-sites.bed`. The final column ("Mutation summary") provides a mapping of how specific nucleotide changes at that position affect the resulting amino acid (e.g., `T:D;C:D` indicates mutations to T or C both result in Aspartic Acid).
- **Memory and Performance:** For large genomes, ensure the output directory is on a filesystem with sufficient space, as the site-by-site BED file can become quite large.
- **VCF Requirements:** When performing MK tests, ensure your VCF contains the outgroup samples specified by the `-u` flag. The `-sfs` flag is recommended to output the site frequency spectrum data used for the tests.

## Reference documentation
- [degenotate GitHub Repository](./references/github_com_harvardinformatics_degenotate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_degenotate_overview.md)