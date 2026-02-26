---
name: novoplasty
description: NOVOPlasty is a specialized assembler that extracts and reconstructs organelle genomes from total genomic DNA using a seed-and-extend algorithm. Use when user asks to assemble mitochondrial or chloroplast genomes, perform de novo organelle assembly from whole genome sequencing data, or circularize organelle sequences using a seed.
homepage: https://github.com/ndierckx/NOVOPlasty
---


# novoplasty

## Overview

NOVOPlasty is a specialized assembler designed to extract and assemble organelle genomes directly from total genomic DNA. Unlike general-purpose assemblers, it uses a "seed-and-extend" algorithm that starts from a user-provided seed sequence (such as a conserved gene or a related species' organelle sequence) and iteratively pulls matching reads from the dataset to reconstruct the circular genome. This eliminates the need for physical organelle enrichment or pre-filtering of reads. It is particularly effective for mitochondrial and chloroplast assembly in plants and animals.

## Core Workflow

### 1. Seed Selection
The seed is the starting point for the assembly. Valid seeds include:
- A single read from the dataset known to be of organelle origin.
- A conserved gene sequence (e.g., RUBP for chloroplasts).
- A complete organelle sequence from a related or even distant species.
- Format: Standard FASTA file.

### 2. Configuration File Setup
NOVOPlasty relies on a `config.txt` file. Ensure the following parameters are correctly defined:
- **Type**: Set to `chloro` (chloroplast), `mito` (mitochondria), or `mito_plant` (plant mitochondria).
- **K-mer**: Default is 33. Decrease to 21-27 for low coverage or reads <90bp. Increase for reads >101bp if necessary.
- **Genome Range**: Set the expected size (e.g., 12000-20000 for animal mito). Narrowing this range can help prevent premature circularization in repetitive regions.
- **Dataset**: Provide paths to forward and reverse FASTQ files.

### 3. Execution
Run the assembler using Perl or the Conda-installed executable:

```bash
# Standard Perl execution
perl NOVOPlasty4.3.5.pl -c config.txt

# Conda execution
NOVOPlasty.pl -c config.txt
```

## Best Practices and Expert Tips

- **Raw Data Only**: Do NOT filter or quality-trim your reads. NOVOPlasty performs best with raw whole genome datasets. Only adapter removal is recommended.
- **Memory and Subsampling**: If memory is limited, use the `Max memory` parameter in the config file. NOVOPlasty will automatically subsample the data to fit within the specified RAM (in GB).
- **Handling Assembly Failures**:
    - If the assembly fails to circularize, try varying the K-mer size.
    - If the seed is not found, ensure the seed sequence is in the correct FASTA format and contains no illegal characters.
    - For low-coverage datasets, lower the K-mer to 23 or 25.
- **Seed Extension**: The `Extend seed directly` option allows the assembler to use the seed as-is without correction. Use this only if the seed is derived from the exact same sample.
- **Heteroplasmy Calling**: To detect minor variants, ensure `Variance detection` is enabled and provide the necessary reference sequences in the configuration.

## Reference documentation
- [NOVOPlasty Main Repository](./references/github_com_ndierckx_NOVOPlasty.md)
- [NOVOPlasty Wiki and Manual](./references/github_com_ndierckx_NOVOPlasty_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_novoplasty_overview.md)