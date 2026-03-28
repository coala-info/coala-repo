[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

PANORAMA just released!

[![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)
![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)

PANORAMA](../index.html)

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* More
  + [PANORAMA](https://github.com/labgem/PANORAMA)
  + [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
  + [LABGeM](https://labgem.genoscope.cns.fr/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Search
`Ctrl`+`K`

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* [PANORAMA](https://github.com/labgem/PANORAMA)
* [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
* [LABGeM](https://labgem.genoscope.cns.fr/)

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Section Navigation

Get Started:

* [Installation Guide 🦮](install.html)
* [Quick usage 🦅](quick_usage.html)
  + [Complete Biological Systems Prediction Workflow](pansystems.html)
  + [Pangenome Comparison Analysis](quick_compare.html)
* [Reporting Issues and Suggesting Features 💬](issues.html)

Biological system Prediction:

* [Gene Family annotation](annotation.html)
* [System Detection Based on Models](detection.html)
* [Systems analysis output 📊](write_systems.html)
  + [System Projection on Genomes](projection.html)
  + [System Association with Pangenome Elements](association.html)
  + [System Partition Analysis](partition.html)

Pangenomes comparison:

* [Conserved Spots Comparison Across Pangenomes](compare_spots.html)
* [Systems Comparison Across Pangenomes](compare_systems.html)

PANORAMA utilities:

* [Extract and Visualize Pangenome Information ℹ️](info.html)
* Gene Family Alignment Across Pangenomes
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Gene Family Alignment Across Pangenomes

# Gene Family Alignment Across Pangenomes[#](#gene-family-alignment-across-pangenomes "Link to this heading")

The align command performs sequence alignment of gene families between multiple pangenomes using MMseqs2 to identify
homologous relationships and sequence similarities across different bacterial populations. This analysis supports both
targeted inter-pangenome comparisons (excluding intra-pangenome alignments) and comprehensive all-against-all alignments
that capture both inter- and intra-pangenome relationships.

## Alignment Workflow[#](#alignment-workflow "Link to this heading")

The gene family alignment process runs as follows:

1. Load and Validate Pangenomes

   * Multiple pangenomes are loaded from .h5 files based on a .tsv file.
   * Each pangenome is validated to ensure gene families have been clustered and sequences are available.
2. Extract Gene Family Sequences

   * Gene family sequences are extracted from each pangenome and written to individual FASTA files.
   * Sequences are compressed and organized in temporary directories for processing.
3. Create MMseqs2 Databases

   * Individual sequence databases are created for each pangenome using MMseqs2.
   * For all-against-all mode, sequences are combined into a single unified database.
4. Perform Sequence Alignments

   * **Inter-pangenome mode**: Pairwise alignments between all pangenome combinations, excluding self-alignments.
   * **All-against-all mode**: Comprehensive alignment including both inter- and intra-pangenome comparisons.
   * MMseqs2 search algorithms apply identity and coverage thresholds to identify significant matches.
5. Process and Merge Results

   * Alignment results are converted from binary format to human-readable TSV files.
   * Multiple alignment files are merged into consolidated output files.
6. Write Results to Files

   * Final alignment results are saved as detailed TSV files containing sequence similarity metrics.

## Alignment command Line Usage[#](#alignment-command-line-usage "Link to this heading")

* Basic inter-pangenome alignment:

  ```
  panorama align \
  --pangenomes pangenomes.tsv \
  --output alignment_results \
  --inter_pangenomes \
  --align_identity 0.8 \
  --align_coverage 0.8 \
  --threads 8
  ```
* Comprehensive all-against-all alignment:

  ```
  panorama align \
  --pangenomes pangenomes.tsv \
  --output alignment_results \
  --all_against_all \
  --align_identity 0.5 \
  --align_coverage 0.8 \
  --align_cov_mode 0 \
  --threads 8 \
  --keep_tmp
  ```

### Key Options[#](#key-options "Link to this heading")

| Shortcut | Argument | Type | Required/Optional | Description |
| --- | --- | --- | --- | --- |
| -p | –pangenomes | File path | Required | TSV file listing .h5 pangenomes with gene families and sequences |
| -o | –output | Directory path | Required | Output directory for alignment results |
| — | –inter\_pangenomes | Flag | Required (either) | Align gene families between pangenomes only (excludes intra-pangenome) |
| — | –all\_against\_all | Flag | Required (either) | Align all gene families including intra-pangenome comparisons |

### MMseqs2 Alignment Parameters[#](#mmseqs2-alignment-parameters "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| — | –align\_identity | Float | True | Minimum identity percentage threshold (0.0-1.0, default: 0.5) |
| — | –align\_coverage | Float | True | Minimum coverage percentage threshold (0.0-1.0, default: 0.8) |
| — | –align\_cov\_mode | Int | True | Coverage mode: 0=query, 1=target, 2=shorter seq, 3=longer seq, 4=both, 5=all (default: 0) |

### Advanced Configuration Arguments[#](#advanced-configuration-arguments "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| — | –tmpdir | str (directory path) | True | Directory for temporary files (default: system temp directory) |
| — | –keep\_tmp | bool (flag) | True | Keep temporary files after completion (useful for debugging) |
| — | –threads | int | True | Number of CPU threads for parallel processing (default: 1) |

### Alignment Modes[#](#alignment-modes "Link to this heading")

#### Inter-Pangenome Alignment[#](#inter-pangenome-alignment "Link to this heading")

This mode performs alignments **only between** different pangenomes, excluding intra-pangenome comparisons:

* **Use case**: Identifying shared gene families between populations
* **Results**: Focus on inter-population relationships

#### All-Against-All Alignment[#](#all-against-all-alignment "Link to this heading")

This mode performs comprehensive alignments including both inter- and intra-pangenome comparisons:

* **Use case**: Complete similarity analysis including within-population diversity
* **Results**: Complete gene family relationship matrix

## Parameter Guidelines[#](#parameter-guidelines "Link to this heading")

### Identity Thresholds[#](#identity-thresholds "Link to this heading")

| Threshold | Use Case |
| --- | --- |
| 0.9-1.0 | Nearly identical sequences |
| 0.7-0.9 | Highly similar homologs |
| 0.5-0.7 | Moderate similarity |
| 0.3-0.5 | Low similarity (use with caution) |

### Coverage Thresholds[#](#coverage-thresholds "Link to this heading")

| Threshold | Description |
| --- | --- |
| 0.8-1.0 | High coverage requirement |
| 0.6-0.8 | Moderate coverage |
| 0.4-0.6 | Permissive coverage |

### Coverage Modes[#](#coverage-modes "Link to this heading")

| Mode | Target Coverage |
| --- | --- |
| 0 | Query coverage |
| 1 | Target coverage |
| 2 | Shorter sequence coverage |

## Output Files[#](#output-files "Link to this heading")

PANORAMA generates alignment results in standardized TSV format with detailed similarity metrics.

### File Organization[#](#file-organization "Link to this heading")

```
output_directory/
├── inter_pangenomes.tsv        (inter-pangenome mode)
└── all_against_all.tsv         (all-against-all mode)
```

### Alignment Results Format[#](#alignment-results-format "Link to this heading")

Each alignment file contains the following columns:

| Column | Description | Example |
| --- | --- | --- |
| query | Query gene family identifier | PG1\_FAM\_001 |
| target | Target gene family identifier | PG2\_FAM\_045 |
| identity | Percentage sequence identity (0.0-1.0) | 0.85 |
| qlength | Query sequence length in amino acids | 150 |
| tlength | Target sequence length in amino acids | 145 |
| alnlength | Alignment length in amino acids | 142 |
| e\_value | E-value of the alignment | 1.2e-45 |
| bits | Bit score of the alignment | 185.2 |

[previous

Extract and Visualize Pangenome Information ℹ️](info.html "previous page")
[next

Gene Family Clustering Across Pangenomes](clustering.html "next page")

On this page

* [Alignment Workflow](#alignment-workflow)
* [Alignment command Line Usage](#alignment-command-line-usage)
  + [Key Options](#key-options)
  + [MMseqs2 Alignment Parameters](#mmseqs2-alignment-parameters)
  + [Advanced Configuration Arguments](#advanced-configuration-arguments)
  + [Alignment Modes](#alignment-modes)
    - [Inter-Pangenome Alignment](#inter-pangenome-alignment)
    - [All-Against-All Alignment](#all-against-all-alignment)
* [Parameter Guidelines](#parameter-guidelines)
  + [Identity Thresholds](#identity-thresholds)
  + [Coverage Thresholds](#coverage-thresholds)
  + [Coverage Modes](#coverage-modes)
* [Output Files](#output-files)
  + [File Organization](#file-organization)
  + [Alignment Results Format](#alignment-results-format)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/align.md)

### This Page

* [Show Source](../_sources/user/align.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.