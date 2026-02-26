---
name: viralmsa
description: ViralMSA performs high-performance alignment of viral sequences against a reference genome. Use when user asks to align viral sequences to a reference, fetch a reference by accession, use a preselected or local reference, align with a specific mapping algorithm, list available references, or omit the reference from the final alignment.
homepage: https://github.com/niemasd/ViralMSA
---


# viralmsa

## Overview
ViralMSA is a high-performance wrapper that leverages read-mapping algorithms (like Minimap2) to align viral sequences against a specific reference genome. Unlike traditional MSA tools that perform all-to-all comparisons, ViralMSA scales linearly with the number of sequences. It is specifically designed for viral phylogenetics where the primary goal is to identify substitutions and deletions relative to a standard reference. Note that insertions relative to the reference genome are discarded by design to maintain alignment efficiency and focus on phylogenetically informative sites.

## Installation and Setup
The tool can be installed via Bioconda or used as a standalone Python script.

```bash
# Installation via Conda
conda install bioconda::viralmsa

# Manual installation
wget "https://github.com/niemasd/ViralMSA/releases/latest/download/ViralMSA.py"
chmod a+x ViralMSA.py
```

## Common CLI Patterns

### Basic Alignment with a GenBank Accession
If you know the NCBI accession number for your reference, ViralMSA can fetch it automatically. An email address is required for NCBI Entrez API usage.
```bash
ViralMSA.py -s my_sequences.fas -r NC_045512 -e your_email@example.com -o output_dir
```

### Using Preselected Reference Names
For common viruses, you can use shorthand names. ViralMSA maintains a curated list of optimal reference genomes.
```bash
ViralMSA.py -s covid_samples.fas -r SARS-CoV-2 -e your_email@example.com -o covid_alignment
```

### Using a Local Reference File
To use a custom or proprietary reference, provide the path to a single-sequence FASTA file.
```bash
ViralMSA.py -s sequences.fas -r local_ref.fasta -o custom_output
```

### Selecting a Specific Aligner
While Minimap2 is the default and recommended aligner for most viral genomes, you can specify others if your workflow requires specific mapping logic (e.g., bowtie2, BWA, STAR).
```bash
ViralMSA.py -s sequences.fas -r NC_045512 -a bowtie2 -o bowtie_output
```

## Expert Tips and Best Practices

- **Thread Optimization**: By default, ViralMSA uses the maximum available threads. In shared HPC environments, explicitly set `-t` to match your resource allocation to avoid overhead or policy violations.
- **Handling Insertions**: Remember that ViralMSA is "reference-guided." If your research focus is on novel insertions or structural variations not present in the reference, this tool may not be appropriate as those sequences will be omitted from the final MSA.
- **Cache Management**: ViralMSA caches reference genomes in `~/.viralmsa`. If you are running out of disk space or need to move the cache to a high-capacity scratch drive, use the `--viralmsa_dir` flag.
- **Reference Listing**: Use the `-l` flag to see all available preselected reference genomes currently supported by the tool.
- **Output Cleaning**: If you do not want the reference sequence included in your final alignment file (e.g., for certain phylogenetic tree builders), use the `--omit_ref` flag.

## Reference documentation
- [ViralMSA GitHub Repository](./references/github_com_niemasd_ViralMSA.md)
- [Bioconda ViralMSA Package](./references/anaconda_org_channels_bioconda_packages_viralmsa_overview.md)