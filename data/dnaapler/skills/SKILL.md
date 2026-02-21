---
name: dnaapler
description: dnaapler is a bioinformatics utility designed to standardize the starting point of circular microbial sequences.
homepage: https://github.com/gbouras13/dnaapler
---

# dnaapler

## Overview

dnaapler is a bioinformatics utility designed to standardize the starting point of circular microbial sequences. While genome assemblers often produce circular contigs with arbitrary breakpoints, dnaapler uses MMseqs2 to identify specific target genes and rotates the sequence so the start codon of the selected gene is positioned at the beginning of the file on the forward strand. It supports bacterial chromosomes, plasmids, and phages, and can process both FASTA and GFA formats.

## Core Commands and Usage

### Standard Workflow
For most users with a mixed assembly (containing both chromosomes and plasmids), use the `all` command. This automatically detects the appropriate reference genes for different contig types.

```bash
dnaapler all -i input.fasta -o output_dir -p sample_name -t 8
```

### Specialized Subcommands
If you know the specific type of sequence you are reorienting, you can use targeted subcommands:
- `chromosome`: Reorients bacterial chromosomes to the *dnaA* gene.
- `plasmid`: Reorients plasmids using a database of common plasmid replication genes.
- `phage`: Reorients phage genomes to the *terL* gene.
- `custom`: Allows you to provide your own amino acid sequence to use as the reorientation target.
- `bulk`: Processes multiple files or multi-FASTA files in a single run.

### Working with GFA Files
dnaapler supports GFA files (e.g., from Flye or Autocycler). If a GFA is provided as input, the tool will output a reoriented GFA. Note that only contigs marked as circular in the GFA will be reoriented.

```bash
dnaapler all -i assembly.gfa -o output_dir -p sample_name
```

## Expert Tips and Best Practices

### Handling Mixed Contigs
If your input contains contigs you wish to skip (e.g., small fragments or linear artifacts), use the `--ignore` parameter. It accepts:
- A comma-separated list: `--ignore contig1,contig2`
- A file path (one name per line): `--ignore to_skip.txt`
- Stdin: `cat list.txt | dnaapler all ... --ignore -`

### Genes Spanning Contig Ends
dnaapler (v1.1.0+) automatically handles cases where the target gene (like *dnaA*) is split across the arbitrary breakpoint of the assembly. It does this by rotating the input by half the genome length and running searches on both versions to find the highest bitscore hit.

### Performance
Version 1.0+ uses MMseqs2 instead of BLAST, making it significantly faster. For a standard bacterial genome, reorientation typically takes only a few seconds. Always specify threads with `-t` to maximize performance on multi-core systems.

### Troubleshooting Start Codons
If dnaapler finds a hit but fails to reorient, it is often because it cannot find a valid start codon (M, V, or L) at the beginning of the MMseqs2 alignment. Ensure your assembly is of high quality and that the sequence is actually circular.

## Reference documentation
- [dnaapler GitHub Repository](./references/github_com_gbouras13_dnaapler.md)
- [dnaapler Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dnaapler_overview.md)