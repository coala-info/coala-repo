---
name: corekaburra
description: Corekaburra adds spatial context to pan-genome analyses by identifying and characterizing genomic regions flanked by core genes. Use when user asks to analyze synteny between core genes, identify genomic islands, or characterize the accessory gene content within core regions.
homepage: https://github.com/milnus/Corekaburra
---


# corekaburra

## Overview

Corekaburra is a downstream bioinformatics tool designed to add spatial context to pan-genome analyses. While standard pipelines like Roary or Panaroo generate gene presence/absence matrices, they often lose the syntenic (positional) relationship between genes. Corekaburra uses the original GFF files to identify "core regions"—the genomic spaces flanked by core genes—and characterizes them based on their accessory gene content and nucleotide length. It is particularly useful for identifying genomic islands, hotspots of recombination, and conserved core gene segments across a set of genomes.

## Installation and Setup

Corekaburra requires Python 3.9+ and can be installed via Conda or Pip:

```bash
# Via Conda
conda install -c bioconda -c conda-forge corekaburra

# Via Pip
pip install corekaburra
```

## Core Workflow and CLI Usage

To run a standard analysis, you must provide the GFF files used in the pan-genome construction and the output directory from Roary or Panaroo.

### Basic Command

```bash
Corekaburra -ig ./gffs/*.gff -ip ./pan_genome_results/ -o ./corekaburra_output/
```

### Key Arguments

- `-ig`, `--input_gffs`: Paths to the GFF files. These must match the files used for the pan-genome.
- `-ip`, `--input_pangenome`: Path to the folder containing `gene_presence_absence.csv`.
- `-cc`, `--core_cutoff`: The threshold for a gene to be considered "core" (default is 1.0, meaning 100% presence).
- `-lc`, `--low_cutoff`: Threshold for "low-frequency" genes (default 0.05). Set to `0` to treat all accessory genes as intermediate frequency.
- `-cg`, `--complete_genomes`: A text file listing filenames of closed/complete genomes to be treated as circular.

## Input Requirements and Best Practices

### GFF Formatting
- **FASTA Requirement**: GFF files must contain a `##FASTA` line separating the annotations from the sequence.
- **Tags**: Every CDS must have both an `ID` and a `locus_tag`.
- **Compression**: Gzipped GFF files (`.gff.gz`) are supported.

### Defining Coreness
The default `-cc 1.0` is highly conservative. In larger datasets with assembly gaps, consider lowering this (e.g., `-cc 0.95`) to ensure core regions are not broken by a single missing gene call in one isolate.

### Handling Complete Genomes
If your dataset includes finished genomes, provide them in a list to the `-cg` flag. Corekaburra treats these as circular, allowing it to identify core regions that span the start/end of the linear sequence representation.

## Interpreting Key Outputs

- `core_pair_summary.csv`: Describes the regions between every pair of adjacent core genes, including the number of accessory genes and the physical distance.
- `core_segments.csv`: Identifies stretches of core genes that maintain synteny across the entire dataset.
- `low_frequency_gene_placement.csv`: Maps where rare genes are integrated relative to the core scaffold.
- `coreless_contigs.csv`: Lists contigs (usually in draft assemblies) that contain no core genes, often representing mobile genetic elements or plasmids.

## Expert Tips

- **CPU Scaling**: Use the `-c` flag to specify multiple CPUs for faster processing of large GFF sets.
- **Memory Management**: For very large pan-genomes (>1000 genomes), ensure the system has sufficient RAM to load the `gene_presence_absence.csv` into memory.
- **Downstream Analysis**: The output CSVs are designed for easy import into R or Python (pandas) for visualizing "hotspots" where accessory gene accumulation is significantly higher than the pangenome average.

## Reference documentation

- [Corekaburra GitHub Repository](./references/github_com_milnus_Corekaburra.md)
- [Corekaburra Wiki](./references/github_com_milnus_Corekaburra_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_corekaburra_overview.md)