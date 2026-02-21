---
name: bcgtree
description: `bcgtree` is a wrapper tool designed to streamline the multi-step process of building phylogenetic trees.
homepage: https://github.com/molbiodiv/bcgtree
---

# bcgtree

## Overview
`bcgtree` is a wrapper tool designed to streamline the multi-step process of building phylogenetic trees. It automates the identification of core genes (using HMMER), sequence alignment (using MUSCLE), alignment refinement (using Gblocks), and tree inference (using RAxML). It is particularly useful when working with large sets of bacterial genomes where manual extraction of orthologous genes is impractical.

## Common CLI Patterns

### Basic Tree Construction
To build a tree from protein sequences (proteomes), provide pairs of organism names and their corresponding FASTA files:
```bash
bcgTree.pl --proteome "E_coli_K12=ecoli_k12.faa" --proteome "S_enterica=s_enterica.faa" --outdir core_tree
```

### Working with Nucleotide Genomes
If you provide nucleotide genomes, the tool will automatically run `prodigal` to predict genes before proceeding:
```bash
bcgTree.pl --genome "StrainA=strainA.fna" --genome "StrainB=strainB.fna" --outdir genome_analysis
```

### Environment and Resource Management
Before running a large analysis, verify that all external dependencies (HMMER, MUSCLE, Gblocks, RAxML, Prodigal) are correctly installed and accessible:
```bash
bcgTree.pl --check-external-programs
```

To speed up the analysis on multi-core systems:
```bash
bcgTree.pl --proteome org1=p1.faa --proteome org2=p2.faa --threads 8
```

### Using Configuration Files
For projects with many organisms, use a configuration file to avoid extremely long command lines. Create a text file (e.g., `project.conf`) containing the parameters and call it with the `@` prefix:
```bash
# project.conf content:
# --proteome org1=path/to/1.faa
# --proteome org2=path/to/2.faa
# --outdir results_dir

bcgTree.pl @project.conf
```

## Expert Tips and Best Practices

- **Input Precedence**: If you provide both a `--proteome` and a `--genome` with the same organism name, `bcgtree` will prioritize the genome and ignore the proteome for that specific organism.
- **Dependency Versions**: Ensure you are using MUSCLE version 5 or later, as version 3 is no longer supported in recent `bcgtree` releases.
- **Custom HMMs**: By default, the tool uses `essential.hmm`. You can specify alternative HMM profiles (like the included `ubcg.hmm`) using the `--hmmfile` option to target different sets of core genes.
- **Path Overrides**: If external binaries are not in your system PATH, you can specify them directly using flags like `--raxml-bin /path/to/raxmlHPC` or `--muscle-bin /path/to/muscle`.
- **Output Inspection**: Always check the `options.txt` file generated in the output directory; it contains the exact parameters used for the run, ensuring your results are reproducible.

## Reference documentation
- [github_com_molbiodiv_bcgtree.md](./references/github_com_molbiodiv_bcgtree.md)
- [anaconda_org_channels_bioconda_packages_bcgtree_overview.md](./references/anaconda_org_channels_bioconda_packages_bcgtree_overview.md)