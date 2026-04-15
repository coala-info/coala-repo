---
name: bamdam
description: bamdam processes ancient DNA BAM files to reduce their size and authenticate taxonomic alignments through damage pattern analysis. Use when user asks to shrink BAM files based on LCA results, compute authentication metrics like postmortem damage, extract taxon-specific reads, or visualize damage patterns and taxonomic distributions.
homepage: https://github.com/bdesanctis/bamdam
metadata:
  docker_image: "quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0"
---

# bamdam

## Overview

bamdam is a specialized suite designed for ancient DNA (aDNA) workflows, specifically following the use of the Lowest Common Ancestor (LCA) algorithm. It addresses the common issue of massive BAM files generated when mapping against large reference databases by "shrinking" them to include only informative taxonomic alignments. Beyond file management, it provides critical authentication tools to verify the authenticity of ancient samples by analyzing postmortem damage (PMD) patterns, read complexity, and k-mer duplicity. It is compatible with both eukaryotic and microbial datasets.

## Core Workflow

### 1. Data Reduction (Shrink)
Use `shrink` to remove alignments to uninformative high-level taxonomic nodes (e.g., "Viridiplantae") and reduce file size while retaining informative reads.

```bash
bamdam shrink \
    --in_bam input_sorted.bam \
    --in_lca input.lca \
    --out_bam shrunken.bam \
    --out_lca shrunken.lca \
    --stranded ds \
    --mincount 5 \
    --upto family
```
*   **Expert Tip**: Input BAMs **must** be sorted by read name (`samtools sort -n`). Merging read-sorted files often breaks this order; always re-sort after merging.
*   **Performance**: Use `--annotate_pmd` to add PMD tags (DS:Z field) during shrinking, though this doubles execution time.

### 2. Authentication Metrics (Compute)
Generate a TSV summary of taxonomic nodes with associated aDNA metrics.

```bash
bamdam compute \
    --in_bam shrunken.bam \
    --in_lca shrunken.lca \
    --out_tsv metrics.tsv \
    --out_subs damage_substitutions.txt \
    --stranded ds
```
*   **Key Metrics**: Focus on 5' C-to-T frequency, k-mer duplicity, and mean read complexity to distinguish true ancient signals from modern contaminants.

### 3. Visualization and Extraction
*   **Extract Reads**: Isolate reads for a specific taxon for downstream analysis.
    ```bash
    bamdam extract --in_bam shrunken.bam --out_bam taxon_specific.bam --taxid 1234
    ```
*   **Damage Plots**: Create "smiley" plots from the `.subs` file generated during the compute step.
    ```bash
    bamdam plotdamage --in_subs damage_substitutions.txt --taxid 1234 --out_plot damage.png
    ```
*   **Krona Charts**: Generate interactive taxonomic visualizations colored by damage frequency.
    ```bash
    bamdam krona --in_tsv metrics.tsv --out_xml krona_input.xml
    # Follow with KronaTools: ktImportXML krona_input.xml -o interactive_plot.html
    ```

## Best Practices
*   **Library Prep**: Always specify the correct library type with `--stranded` (`ss` for single-stranded, `ds` for double-stranded) as this fundamentally changes how damage is calculated.
*   **Pre-filtering**: For faster processing on massive datasets, `grep` the LCA file for your target group (e.g., "Eukaryota") before running `shrink`.
*   **Memory Management**: bamdam processes files line-by-line and typically stays under 8GB RAM, making it suitable for standard workstations even with 50GB+ BAM files.



## Subcommands

| Command | Description |
|---------|-------------|
| bamdam plotbaminfo | Generate plots from BAM file information. |
| bamdam shrink | Shrinks an LCA file and its corresponding BAM file by filtering nodes and alignments. |
| bamdam_combine | Combine multiple bamdam compute output TSV files into a single file. |
| bamdam_compute | Compute statistics from BAM and LCA files. |
| bamdam_extract | Extracts reads from a BAM file based on taxonomic information. |
| bamdam_krona | Generate Krona plots from BAM data. |
| bamdam_plotdamage | Plot damage patterns from substitution files. |

## Reference documentation
- [bamdam GitHub Repository](./references/github_com_bdesanctis_bamdam.md)
- [bamdam README and Usage Guide](./references/github_com_bdesanctis_bamdam_blob_main_README.md)
- [bamdam Changelog](./references/github_com_bdesanctis_bamdam_blob_main_CHANGELOG.md)