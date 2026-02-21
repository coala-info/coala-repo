---
name: ltr_finder
description: ltr_finder is a specialized bioinformatics tool designed to detect LTR retrotransposons with high precision.
homepage: https://github.com/NBISweden/LTR_Finder/
---

# ltr_finder

## Overview

ltr_finder is a specialized bioinformatics tool designed to detect LTR retrotransposons with high precision. It utilizes a suffix-array based algorithm to find exact match pairs, which are then extended and refined using Smith-Waterman alignments. The tool goes beyond simple structural detection by identifying functional motifs such as TG..CA boxes, Target Site Repeats (TSRs), Primer Binding Sites (PBS), and Polypurine Tracts (PPT). It also searches for internal protein domains like Reverse Transcriptase (RT) to provide a confidence-ranked list of retrotransposon candidates.

## Common CLI Patterns

### Basic Discovery
The most straightforward usage requires only the input FASTA file.
```bash
ltr_finder input_genome.fa > ltr_results.txt
```

### Tabular Output for Downstream Analysis
Use the `-w` flag to control the output format. Format `2` is generally preferred for parsing.
```bash
ltr_finder -w 2 input_genome.fa > ltr_results.table
```

### High-Sensitivity Search
To increase sensitivity for specific LTR structures, you can adjust the distance and length parameters.
```bash
# -D: Max distance between LTRs (default 20000)
# -L: Max length of LTR (default 7000)
# -l: Min length of LTR (default 100)
ltr_finder -D 15000 -L 5000 -l 50 input_genome.fa
```

### Visualizing Results
The tool includes a Perl script for generating genomic plots of the identified elements.
```bash
ltr_finder input.fa -P output_prefix -w 2 > results.txt
perl genome_plot.pl results.txt
```

## Expert Tips and Best Practices

- **Input Preparation**: Ensure your FASTA headers are concise. Long or complex headers containing special characters can sometimes cause parsing errors in the output report.
- **Domain Identification**: ltr_finder can call `ps_scan` (from PROSITE) to locate enzyme cores. If you require high-confidence models, ensure your environment is configured to allow ltr_finder to access these external dependencies.
- **Filtering Results**: The tool reports models at different confidence levels based on the number of signals (PBS, PPT, RT) detected. For genome annotation, it is standard practice to filter for "full-length" candidates that possess both LTRs and at least one internal domain.
- **Memory Management**: For very large genomes (e.g., wheat or maize), consider masking common repeats or processing the genome in scaffolds to manage memory usage, as the suffix-array construction is memory-intensive.
- **Handling Frame Shifts**: The RT identification module includes dynamic programming to handle frame shifts, making it more robust for detecting older, slightly degraded retrotransposons compared to simple ORF finders.

## Reference documentation

- [LTR_Finder GitHub Repository](./references/github_com_NBISweden_LTR_Finder.md)
- [Bioconda ltr_finder Overview](./references/anaconda_org_channels_bioconda_packages_ltr_finder_overview.md)