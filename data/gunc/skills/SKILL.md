---
name: gunc
description: GUNC (Genome Unclutterer) is a specialized tool for quality control of prokaryotic genomes.
homepage: https://github.com/grp-bork/gunc
---

# gunc

## Overview

GUNC (Genome Unclutterer) is a specialized tool for quality control of prokaryotic genomes. While traditional tools like CheckM focus on the redundancy of single-copy marker genes to estimate contamination, GUNC evaluates the taxonomic "entropy" or consistency across the entire genome. It maps genes to a reference database (like GTDB) and calculates a GUNC score; a high score indicates that genes in the genome are assigned to widely different taxonomic groups, suggesting the genome is a chimera or heavily contaminated.

## CLI Usage and Best Practices

### 1. Database Management
Before running analysis, you must download the reference database. GUNC supports both a standard database and the Genome Taxonomy Database (GTDB).

```bash
# Download the default GUNC database
gunc download_db [output_directory]
```

### 2. Basic Analysis
The primary workflow involves running GUNC against a FASTA file (nucleotide) or a set of gene calls (protein).

```bash
# Run analysis on a single genome (FASTA)
gunc run -f genome.fna --gunc_db [path_to_db]

# Run analysis using pre-computed gene calls (FAA)
gunc run -f genes.faa --gene_calls --gunc_db [path_to_db]
```

### 3. Batch Processing
GUNC is optimized for high-throughput analysis of MAGs. You can provide a directory or a list of files.

```bash
# Run on multiple genomes in a directory
gunc run -f /path/to/genomes/*.fna --gunc_db [path_to_db] --threads 8
```

### 4. Visualization and Interpretation
GUNC provides visualization tools to help inspect problematic genomes.

```bash
# Generate plots for specific contigs or all contigs
gunc plot -i gunc_output.tsv --plot_all_contigs
```

### Key Parameters and Tips
- **Input Formats**: Use the `--gene_calls` flag if your input is a protein FASTA (`.faa`). GUNC can handle gzipped input files.
- **Contamination Cutoff**: You can adjust the sensitivity of the tool using the `--contamination_portion` flag to define the threshold for what is considered a contaminating fraction.
- **Temporary Files**: Use `--temp_dir` to specify a location for intermediate files, especially when working on clusters with limited `/tmp` space.
- **Output Files**: 
    - `GUNC.progenomes_2.maxCSS.tsv`: The main summary file containing the GUNC score.
    - `contig_assignments.tsv`: Detailed taxonomic assignments for every contig, useful for manual binning refinement.

## Reference documentation
- [Anaconda Bioconda GUNC Overview](./references/anaconda_org_channels_bioconda_packages_gunc_overview.md)
- [GUNC GitHub Repository](./references/github_com_grp-bork_gunc.md)
- [GUNC Release Tags and Changelog](./references/github_com_grp-bork_gunc_tags.md)