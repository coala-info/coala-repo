---
name: prodigal-gv
description: Prodigal-gv is a specialized fork of the Prodigal gene caller designed to improve the identification of protein-coding sequences in giant viruses and viral lineages with non-standard translation tables.
homepage: https://github.com/apcamargo/prodigal-gv
---

# prodigal-gv

## Overview

Prodigal-gv is a specialized fork of the Prodigal gene caller designed to improve the identification of protein-coding sequences in giant viruses and viral lineages with non-standard translation tables. While the original Prodigal is optimized for bacteria and archaea, it often misses genes in Nucleocytoplasmic Large DNA Viruses (NCLDVs) due to their distinct codon usage and genomic structures. Prodigal-gv addresses this by incorporating ten additional models into its metagenomic mode, covering various Chlorella viruses, Mimiviruses, and sequences using genetic code 15 (Topaz, Agate, and certain gut phages).

## Installation

The tool is most easily installed via Conda or by downloading pre-built binaries:

```bash
# Via Conda/Mamba
conda install -c bioconda prodigal-gv

# Via GitHub Binary (Linux example)
curl -L https://github.com/apcamargo/prodigal-gv/releases/download/2.11.0/prodigal-gv-linux -o prodigal-gv
chmod +x prodigal-gv
```

## Common CLI Patterns

### Standard Metagenomic Gene Calling
To utilize the specialized viral models, you must run the tool in metagenomic mode (`-p meta`).

```bash
prodigal-gv -p meta -i input_genome.fna -a output_proteins.faa -d output_genes.fna -o output_coords.gff
```

### Parallelized Execution
For large datasets or multi-contig FASTA files, use the included Python wrapper to distribute the workload across multiple CPU threads.

```bash
./parallel-prodigal-gv.py -t 8 -i input_genome.fna -a output_proteins.faa -o output_coords.gff
```

## Expert Tips and Best Practices

- **Metagenome Mode Requirement**: The improved viral models are only active when using `-p meta`. Running in single-genome mode (`-p single`) will use the standard Prodigal training algorithm, which may not capture the specific viral optimizations.
- **Genetic Code 15**: Prodigal-gv is one of the few tools with built-in support for genetic code 15 (where TAG codes for Glutamine instead of a Stop codon). This is critical for accurate gene prediction in specific "Agate" and "Topaz" viral clades found in environmental samples.
- **Output Headers**: Note that prodigal-gv adds the detected genetic code directly to the FASTA headers of the output files, which is useful for downstream functional annotation and verifying if alternative codes were applied.
- **Giant Virus Models**: The tool includes specific models for:
    - Acanthamoeba polyphaga mimivirus
    - Paramecium bursaria Chlorella virus
    - Acanthocystis turfacea Chlorella virus
    - VirSorter2's NCLDV gene model
- **Handling Large Sequences**: This fork has increased internal limits (`MAX_GENES` and `MAX_SEQ`) compared to the original Prodigal to accommodate the significantly larger genomes of giant viruses.

## Reference documentation

- [Prodigal-gv GitHub Repository](./references/github_com_apcamargo_prodigal-gv.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_prodigal-gv_overview.md)