---
name: catfasta2phyml
description: "catfasta2phyml concatenates multiple FASTA alignments into a single matrix in PHYML, PHYLIP, or FASTA format. Use when user asks to merge multiple sequence alignments, handle missing taxa across alignments, or generate partition coordinates for phylogenetic analysis."
homepage: https://github.com/nylander/catfasta2phyml
---


# catfasta2phyml

## Overview
catfasta2phyml is a specialized utility for concatenating multiple FASTA alignments into a single matrix. While its default output is the PHYML (interleaved PHYLIP) format, it also supports standard FASTA and sequential PHYLIP outputs. The tool performs essential validation by checking that sequences within each input file are of equal length and provides flexible strategies for handling taxa that are not present in every input alignment.

## Common CLI Patterns

### Basic Concatenation
To merge all FASTA files in a directory into a single PHYML file:
```bash
catfasta2phyml.pl *.fas > concatenated.phy
```

### Handling Missing Data
By default, the tool expects all files to have the same sequence labels. Use these flags to change that behavior:
- **Include All Taxa**: Use `-c` or `--concatenate` to include every taxon found across all files. Missing data in specific alignments will be automatically filled with gaps (`-`).
- **Intersection Only**: Use `-i` or `--intersect` to only include taxa that are present in every single input file.

### Output Formats
- **FASTA**: `catfasta2phyml.pl -f *.fas > concatenated.fasta`
- **Sequential PHYLIP**: `catfasta2phyml.pl -p -s *.fas > concatenated.phy`
- **Check Only**: Use `-n` or `--noprint` combined with `-v` to verify alignments without generating an output file.

### Managing Partitions
The tool prints partition coordinates (e.g., `file1.fas = 1-625`) to **STDERR**. Always capture this to a separate file for downstream analysis:
```bash
catfasta2phyml.pl *.fas > concatenated.phy 2> partitions.txt
```

## Expert Tips

### Cleaning Partition Names
Use the `-b` (basename) option to strip file suffixes from the partition table, making it cleaner for software like RAxML:
```bash
catfasta2phyml.pl -b.fas *.fas > out.phy 2> partitions.txt
```

### Preparing RAxML/IQ-TREE Partition Files
The partition table generated in STDERR needs a data type prefix (e.g., `DNA`) for most phylogenetic software. You can format the `partitions.txt` file using `sed`:
```bash
# Example: Adding 'DNA, ' prefix and removing file paths/extensions
sed -i -e 's#.*/##' -e 's/\.fas//' -e 's/^/DNA, /' partitions.txt
```

### Solving "Argument list too long"
If you have thousands of files, the shell may fail to expand `*.fas`. Use a two-step approach with intermediate files:
1. Concatenate batches into intermediate FASTA files using `find` and `parallel`.
2. Perform a final concatenation of the intermediate files:
```bash
find . -type f -name '*.fas' | parallel -N1000 'catfasta2phyml.pl -c -f {} > tmp.{#}.conc'
catfasta2phyml.pl -c tmp.*.conc > final_concatenated.phy
rm tmp.*.conc
```

## Reference documentation
- [catfasta2phyml GitHub Repository](./references/github_com_nylander_catfasta2phyml.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_catfasta2phyml_overview.md)