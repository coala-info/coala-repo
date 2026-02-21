---
name: metabat2
description: MetaBAT2 is an automated binning algorithm that clusters metagenomic contigs into bins based on tetranucleotide frequency and differential abundance across samples.
homepage: https://bitbucket.org/berkeleylab/metabat
---

# metabat2

## Overview
MetaBAT2 is an automated binning algorithm that clusters metagenomic contigs into bins based on tetranucleotide frequency and differential abundance across samples. It is highly efficient for large-scale datasets and is a standard tool in metagenomic pipelines for generating Metagenome-Assembled Genomes (MAGs). It excels at handling complex microbial communities by integrating sequence composition and coverage information.

## Core Workflow

### 1. Prepare Abundance Data
MetaBAT2 requires a depth file generated from BAM files (reads mapped back to the assembly). Use the included utility script to create this.

```bash
jgi_summarize_bam_contig_depths --outputDepth depth.txt *.bam
```

### 2. Execute Binning
Run the main binning command using the assembly FASTA and the generated depth file.

```bash
metabat2 -i assembly.fasta -a depth.txt -o bins/bin_prefix
```

## Common CLI Patterns

### High Sensitivity Mode
For complex samples where you want to maximize the recovery of bins, even if they are less complete.
```bash
metabat2 -i assembly.fasta -a depth.txt -o bins/bin --sensitive
```

### Specific Contig Length Filtering
By default, MetaBAT2 ignores contigs shorter than 2500bp. Adjust this based on your assembly quality.
```bash
# Lowering threshold for highly fragmented assemblies (use with caution)
metabat2 -i assembly.fasta -a depth.txt -o bins/bin -m 1500
```

### Multi-threaded Execution
Always specify threads to improve performance on large metagenomes.
```bash
metabat2 -i assembly.fasta -a depth.txt -o bins/bin -t 16
```

## Expert Tips

- **Input Quality**: Ensure your BAM files are sorted and indexed. The quality of binning is heavily dependent on the accuracy of the read mapping.
- **Differential Abundance**: MetaBAT2 performs significantly better when provided with multiple BAM files from related samples (e.g., a time series or different sites), as it uses differential abundance patterns to separate closely related species.
- **Contig Length**: While `-m` can be lowered, contigs shorter than 1500bp often lack sufficient tetranucleotide frequency signal, leading to poor binning or contamination.
- **Validation**: Always follow MetaBAT2 with a tool like CheckM or CheckM2 to assess the completeness and contamination of the resulting MAGs.

## Reference documentation
- [MetaBAT2 Bitbucket Repository](./references/bitbucket_org_berkeleylab_metabat.md)
- [Bioconda MetaBAT2 Overview](./references/anaconda_org_channels_bioconda_packages_metabat2_overview.md)