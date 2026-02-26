---
name: last-align
description: LAST is a high-performance sequence alignment suite designed to detect complex structural variations and sensitive DNA-to-protein relationships in biological datasets. Use when user asks to index a reference sequence, train alignment parameters, align DNA or protein sequences, or convert alignment formats.
homepage: https://gitlab.com/mcfrith/last
---


# last-align

## Overview
LAST is a high-performance sequence alignment suite designed for moderately large biological datasets. Unlike general-purpose aligners, it excels at detecting complex structural variations and sensitive DNA-to-protein relationships. The toolset follows a modular workflow: indexing a reference, training parameters to match the specific data characteristics, and executing the alignment with various output options.

## Core Workflow

### 1. Database Preparation (lastdb)
Before alignment, the reference sequence must be indexed.
```bash
lastdb mydb reference.fasta
```
*   **Tip**: For DNA-versus-protein search, use the `-p` flag if the reference is a protein database.

### 2. Parameter Training (last-train)
To improve sensitivity, especially with noisy reads or divergent species, use `last-train` to find the best alignment parameters (scoring matrix and gap penalties).
```bash
last-train mydb query.fasta > my_params.txt
```

### 3. Sequence Alignment (lastal)
The primary alignment command. It can take the parameters generated in the previous step.
```bash
lastal -p my_params.txt mydb query.fasta > alignments.maf
```

## Common CLI Patterns

### Output Formats
LAST defaults to MAF (Multiple Alignment Format), but supports others via the `-f` flag:
*   **Tab-separated**: `lastal -f TAB mydb query.fasta`
*   **BLAST-like**: `lastal -f BlastTab+ mydb query.fasta` (Includes E-values and bit scores).
*   **Frame Information**: In recent versions (1651+), `BlastTab+` includes translation frame information for DNA-versus-protein alignments.

### Sensitive DNA-DNA Search
For highly sensitive searches or AT-rich data, adjust the seeding and gap parameters:
```bash
lastal -s 2 -m 500 -k 2 mydb query.fasta
```

### Post-Processing and Visualization
*   **Format Conversion**: Use `maf-convert` to transform MAF files into SAM, BED, or BlastTab.
    ```bash
    maf-convert sam alignments.maf > alignments.sam
    ```
*   **Dotplots**: Visualize the alignments to identify rearrangements.
    ```bash
    last-dotplot alignments.maf plot.png
    ```

## Expert Tips
*   **E-values**: Use `-e` to set an E-value threshold. If you are getting too many random matches in genome-genome alignments, increase the stringency.
*   **Memory Management**: For very large genomes, `lastal` can be memory-intensive. Use the `--split` option to process the query in chunks if memory is limited.
*   **DNA-versus-Protein**: When aligning DNA queries against a protein database, LAST automatically handles 6-frame translation. Use `-F0` if you want to disable specific frameshift handling.

## Reference documentation
- [LAST Overview](./references/anaconda_org_channels_bioconda_packages_last_overview.md)
- [LAST GitLab Activity and Examples](./references/gitlab_com_mcfrith_last.atom.md)
- [LAST Project Repository](./references/gitlab_com_mcfrith_last.md)