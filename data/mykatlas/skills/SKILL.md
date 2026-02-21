---
name: mykatlas
description: mykatlas (invoked via the `atlas` command) is a bioinformatics toolset designed to bridge the gap between raw genomic sequence data and clinical antibiotic-resistance predictions.
homepage: http://github.com/phelimb/atlas
---

# mykatlas

## Overview
mykatlas (invoked via the `atlas` command) is a bioinformatics toolset designed to bridge the gap between raw genomic sequence data and clinical antibiotic-resistance predictions. It functions by creating specific "probes" for known resistance-associated variants and then genotyping sample data against these probes. This allows for rapid identification of resistance profiles without requiring full de novo assembly for every sample.

## Installation and Setup
The preferred method for installing mykatlas is via Bioconda to ensure all dependencies (like mccortex) are correctly managed.

```bash
conda install bioconda::mykatlas
```

Alternatively, it can be installed via pip from the source repository:
```bash
pip install git+https://github.com/Phelimb/atlas
```

## Core CLI Usage
The tool is primarily accessed through the `atlas` entry point.

### 1. Creating Probes (make-probes)
This is the first step in building a resistance panel. You define the variants you are interested in relative to a reference genome.

*   **Single Variant**: `atlas make-probes -v [Variant] -g [Genbank_File] [Reference_Fasta]`
    *   Example: `atlas make-probes -v A1234T -g NC_000962.3.gb NC_000962.3.fasta`
*   **Batch Variants**: Use a text file containing a list of variants (one per line, e.g., `S450L`).
    *   Example: `atlas make-probes -f panel_variants.txt -g reference.gb reference.fasta`

**Key Arguments:**
- `-v, --variant`: Specify a single DNA position variant (e.g., A1234T).
- `-f, --file`: Path to a file containing multiple variants.
- `-g, --genbank`: Genbank file containing gene features (crucial for identifying coding mutations).
- `-k, --kmer`: Kmer length (default is usually sufficient, but can be adjusted for repetitive regions).

### 2. Genotyping Samples (genotype)
Once probes are generated, use the `genotype` command to analyze a specific sample's sequence data.

```bash
atlas genotype --db_name [Database_Name] --sample [Sample_Name] --files [Fastq_Files]
```

### 3. Managing the Atlas (add)
To incorporate new variant data into an existing atlas collection:

```bash
atlas add --db_name [Database_Name] -v [Variant]
```

## Best Practices
*   **Reference Consistency**: Always ensure the Genbank file and the Fasta reference file use the same coordinate system and headers.
*   **Kmer Selection**: If you encounter high levels of ambiguity in genotyping, consider increasing the kmer length (`-k`) to improve the specificity of the probes, though this may decrease sensitivity if the sample has high sequencing error rates.
*   **Pathogen Specificity**: While the tool is generic, it is optimized for *S. aureus* and *M. tuberculosis*. When working with other organisms, ensure your variant list (`-f`) follows standard nomenclature (e.g., [Ref][Pos][Alt]).

## Reference documentation
- [mykatlas Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mykatlas_overview.md)
- [Phelimb/atlas GitHub Repository](./references/github_com_phelimb_atlas.md)