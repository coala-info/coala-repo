---
name: mcscanx
description: MCScanX is a software suite designed to detect and analyze collinear blocks and syntenic regions within or between genomes. Use when user asks to identify syntenic blocks, classify duplicate genes, or visualize genomic alignments using BLAST and GFF data.
homepage: https://github.com/wyp1125/MCScanX
---


# mcscanx

## Overview
MCScanX (Multiple Collinearity Scan toolkit X version) is a specialized suite for detecting and evolutionary analyzing collinear blocks in genomes. It is primarily used to identify syntenic regions between different species or within the same species to understand genome duplication events. The toolkit processes sequence similarity data (BLAST) and gene positional information to produce both tabular synteny data and visual representations of genomic alignments.

## Input Requirements
MCScanX requires two primary input files sharing the same prefix (e.g., `data.blast` and `data.gff`) located in the same directory.

### 1. BLAST File (`prefix.blast`)
Must be in BLASTP "m8" format (tab-delimited).
- **Generation**: `blastall -p blastp -m 8 -e 1e-10 -b 5 -v 5 -o prefix.blast`
- **Tip**: Restrict BLAST hits to the top 5-10 matches per gene to reduce noise and improve processing speed.

### 2. Gene Location File (`prefix.gff`)
A tab-delimited file with four columns:
1. `chr#`: Chromosome name (use a two-letter species prefix, e.g., `at1` for Arabidopsis chromosome 1).
2. `gene`: Gene identifier (must match the BLAST file).
3. `starting_position`: Start coordinate.
4. `ending_position`: End coordinate.

*Note: Ensure no duplicate gene entries exist in the GFF file.*

## Core CLI Usage

### Running the Main Algorithm
To detect syntenic blocks and generate HTML visualizations:
```bash
./MCScanX path/to/prefix
```
- **Output**: `prefix.synteny` (text file of blocks) and `prefix.html` (directory for browser visualization).

### Duplicate Gene Classification
To classify the origin of every gene in a genome:
```bash
./Duplicate_gene_classifier path/to/prefix
```
This categorizes genes into:
1. **WGD/Segmental**: Collinear genes in syntenic blocks.
2. **Tandem**: Consecutive duplicates on the same chromosome.
3. **Proximal**: Near each other but not adjacent.
4. **Transposed**: Duplicates not in the above categories.
5. **Dispersed**: Other duplicates.

### Using Homology Files
If you have pre-defined homologous pairs instead of raw BLAST data, use the homology-based version:
```bash
./MCScanX_h path/to/prefix
```
*Requires `prefix.homology` instead of `prefix.blast`.*

## Parameter Tuning
Fine-tune detection by passing options to the `MCScanX` command:

| Option | Description | Default |
| :--- | :--- | :--- |
| `-s` | **Match Size**: Minimum number of genes to call a syntenic block. | 5 |
| `-k` | **Match Score**: Score for a matching gene pair. | 50 |
| `-g` | **Gap Penalty**: Penalty for gaps between collinear genes. | -1 |
| `-m` | **Max Gaps**: Maximum gaps allowed (1 gap = 10,000bp by default). | 20 |
| `-b` | **Pattern**: 0: All; 1: Intra-species only; 2: Inter-species only. | 0 |
| `-a` | **Pairwise Only**: Only build `.synteny` file, skip HTML generation. | N/A |

## Downstream Analysis Tools
The `downstream_analyses` folder contains auxiliary scripts for specific tasks:

- **Visualizations**:
  - `dot_plotter.java`: Generates genome-wide dot plots.
  - `dual_synteny_plotter.java`: Compares two specific chromosomes/regions.
  - `circle_plotter.java`: Creates circular synteny diagrams.
  - `bar_plotter.java`: Displays synteny as stacked bars.
- **Calculations**:
  - `add_ka_and_ks_to_synteny.pl`: Integrates evolutionary rates into synteny blocks.
  - `detect_collinearity_within_gene_families.pl`: Focuses on specific gene families.

## Expert Tips
- **Multi-Genome Analysis**: When comparing multiple species, concatenate all inter-species and intra-species BLAST results into one `.blast` file and all gene positions into one `.gff` file.
- **Memory Management**: For very large genomes, use the `-a` flag to skip HTML generation if you only need the raw synteny data, as HTML generation can be resource-intensive.
- **Naming Convention**: Always use the species prefix in the chromosome column (e.g., `os` for Oryza sativa, `at` for Arabidopsis thaliana) to prevent chromosome ID collisions during multi-species runs.

## Reference documentation
- [MCScanX GitHub README](./references/github_com_wyp1125_MCScanX.md)
- [Bioconda MCScanX Overview](./references/anaconda_org_channels_bioconda_packages_mcscanx_overview.md)