---
name: dnaapler
description: "dnaapler reorients circular microbial genome assemblies to begin at a conserved marker gene. Use when user asks to reorient circular contigs, fix arbitrary start points in assemblies, or rotate sequences to start at a specific gene like dnaA."
homepage: https://github.com/gbouras13/dnaapler
---

# dnaapler

## Overview

dnaapler is a bioinformatics tool designed to solve the "arbitrary start point" problem in circular microbial genome assemblies. While bacterial chromosomes and plasmids are circular, assemblers must output them as linear sequences, often breaking the circle at a random location. dnaapler identifies conserved marker genes—most commonly *dnaA* for chromosomes—and reorients the sequence so that the chosen gene begins at the first coordinate. It supports both FASTA and GFA formats and can handle complex cases where the target gene spans the artificial break in the assembly.

## Common CLI Patterns

### Standard Reorientation
The most common use case is reorienting all circular contigs in an assembly based on the default database.
```bash
dnaapler all -i assembly.fasta -o output_dir -p sample_name -t 8
```

### Working with GFA Files
When using GFA files (from assemblers like Flye, Unicycler, or Autocycler), dnaapler will output a reoriented GFA file. Note that only contigs explicitly marked as circular in the GFA header/tags will be processed.
```bash
dnaapler all -i assembly.gfa -o output_dir -p sample_name
```

### Ignoring Specific Contigs
If you have a mixed assembly and wish to skip certain sequences (e.g., known linear contigs or specific plasmids), use the `--ignore` flag.
```bash
# Using a comma-separated list
dnaapler all -i input.fasta -o out -p test --ignore contig_1,contig_5

# Using a file containing names (one per line)
dnaapler all -i input.fasta -o out -p test --ignore exclude_list.txt
```

## Expert Tips and Best Practices

- **Gene-Spanning Detection**: dnaapler handles genes that span the contig ends by rotating the input by half its length and running MMseqs2 on both versions. It selects the hit with the highest bitscore, ensuring that even "split" genes are correctly identified as the start point.
- **Mixed Assemblies**: Use the `all` subcommand when dealing with assemblies containing both chromosomes and plasmids. It is more robust than running individual gene-specific subcommands.
- **Dependency Management**: Ensure `MMseqs2` (version >= 13.45111), `BLAST+`, and `Prodigal` (or `Pyrodigal`) are available in your environment. dnaapler relies on these for gene prediction and homology searching.
- **Apple Silicon Support**: If installing via Conda on M1/M2/M3/M4 Macs, use the `osx-64` platform override to ensure compatibility with all underlying bioinformatics dependencies.
- **Output Verification**: Always check the `dnaapler.log` in the output directory to verify which contigs were successfully reoriented and which genes were used as the new anchor point.



## Subcommands

| Command | Description |
|---------|-------------|
| dnaapler | A tool for analyzing and annotating archaeal genomes. |
| dnaapler | A tool for analyzing DNA sequences. |
| dnaapler | A tool for analyzing DNA sequences. |
| dnaapler all | Run dnaapler on all contigs in the input file. |
| dnaapler archaea | Run dnaapler on archaea genomes |
| dnaapler bulk | Reorient sequences in bulk |
| dnaapler chromosome | This command is part of the dnaapler tool and is used for processing chromosome-related data. |
| dnaapler largest | Finds the largest contig in a FASTA or GFA file. |
| dnaapler mystery | Mystery tool for dnaapler |
| dnaapler nearest | Find the nearest reference genome for each input sequence. |
| dnaapler phage | Run dnaapler on phage genomes |
| dnaapler plasmid | Runs the plasmid detection pipeline. |
| dnaapler_custom | Custom reorientation of sequences using a custom MMseqs2 database. |

## Reference documentation
- [github_com_gbouras13_dnaapler_blob_main_README.md](./references/github_com_gbouras13_dnaapler_blob_main_README.md)
- [github_com_gbouras13_dnaapler_blob_main_HISTORY.md](./references/github_com_gbouras13_dnaapler_blob_main_HISTORY.md)