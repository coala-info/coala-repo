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
* [Gene Family Alignment Across Pangenomes](align.html)
* Gene Family Clustering Across Pangenomes

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Gene Family Clustering Across Pangenomes

# Gene Family Clustering Across Pangenomes[#](#gene-family-clustering-across-pangenomes "Link to this heading")

The cluster command groups related gene families from multiple pangenomes into homologous clusters based on sequence
similarity using MMseqs2. This analysis identifies gene families that share common evolutionary origins across different
bacterial populations, enabling comparative genomics studies and the construction of meta-pangenomes. The clustering
supports both fast (linclust) and sensitive (cluster) methods to accommodate different accuracy and performance
requirements.

## Clustering Workflow[#](#clustering-workflow "Link to this heading")

The gene family clustering process runs as follows:

1. Load and Validate Pangenomes

   * Multiple pangenomes are loaded from .h5 files based on a .tsv file.
   * Each pangenome is validated to ensure gene families have been clustered and sequences are available.
2. Extract Gene Family Sequences

   * Gene family sequences are extracted from each pangenome and written to compressed FASTA files.
   * All sequences are combined while maintaining pangenome-specific identifiers.
3. Create Unified MMseqs2 Database

   * All gene family sequences are combined into a single MMseqs2 database.
   * Database indexing optimizes subsequent clustering operations.
4. Perform Sequence Clustering

   * **Linclust method**: Fast linear-time clustering suitable for large datasets with moderate sensitivity
     requirements.
   * **Cluster method**: Sensitive clustering with comprehensive sequence comparisons for high-accuracy results.
   * MMseqs2 applies identity and coverage thresholds to group similar sequences.
5. Process Clustering Results

   * Binary clustering results are converted to human-readable TSV format.
   * Cluster IDs are assigned to group-related gene families.
6. Write Results to Files

   * Final clustering results are saved with cluster assignments and membership details.

## Clustering command Line Usage[#](#clustering-command-line-usage "Link to this heading")

* Fast clustering with linclust:

  ```
  panorama cluster \
  --pangenomes pangenomes.tsv \
  --output clustering_results \
  --method linclust \
  --cluster_identity 0.8 \
  --cluster_coverage 0.8 \
  --threads 8
  ```
* Sensitive clustering with comprehensive parameters:

  ```
  panorama cluster \
  --pangenomes pangenomes.tsv \
  --output clustering_results \
  --method cluster \
  --cluster_identity 0.5 \
  --cluster_coverage 0.8 \
  --cluster_sensitivity 7.5 \
  --cluster_max_seqs 500 \
  --threads 8 \
  --keep_tmp
  ```

### Key Options[#](#key-options "Link to this heading")

| Shortcut | Argument | Type | Required/Optional | Description |
| --- | --- | --- | --- | --- |
| -p | –pangenomes | File path | Required | TSV file listing .h5 pangenomes with gene families and sequences |
| -o | –output | Directory path | Required | Output directory for clustering results |
| -m | –method | String | Required | Clustering method: ‘linclust’ (fast) or ‘cluster’ (sensitive) |

### MMseqs2 Core Clustering Parameters[#](#mmseqs2-core-clustering-parameters "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| — | –cluster\_identity | Float | True | Minimum sequence identity threshold (0.0-1.0, default: 0.5) |
| — | –cluster\_coverage | Float | True | Minimum coverage threshold (0.0-1.0, default: 0.8) |
| — | –cluster\_cov\_mode | Int | True | Coverage mode: 0=query, 1=target, 2=shorter, 3=longer, 4=both, 5=all (default: 0) |
| — | –cluster\_eval | Float | True | E-value threshold for sequence similarity (default: 1e-3) |

### Cluster method-specific parameters[#](#cluster-method-specific-parameters "Link to this heading")

| Argument | Type | Description |
| --- | --- | --- |
| –cluster\_sensitivity | Float | Search sensitivity (higher = more sensitive but slower) |
| –cluster\_max\_seqs | Int | Maximum sequences per cluster representative |
| –cluster\_min\_ungapped | Int | Minimum ungapped alignment score |

### Advanced Parameters (Both Methods)[#](#advanced-parameters-both-methods "Link to this heading")

| Argument | Type | Description |
| --- | --- | --- |
| –cluster\_comp\_bias\_corr | Int | Compositional bias correction: 0=disabled, 1=enabled |
| –cluster\_kmer\_per\_seq | Int | Number of k-mers per sequence |
| –cluster\_align\_mode | Int | Alignment mode: 0=auto, 1=score only, 2=extended, 3=both, 4=fast |
| –cluster\_max\_seq\_len | Int | Maximum sequence length |
| –cluster\_max\_reject | Int | Maximum number of rejected sequences |
| –cluster\_mode | Int | Clustering algorithm: 0=Set Cover, 1=Connected Component, 2=Greedy, 3=Greedy Low Memory |

### Advanced Configuration Arguments[#](#advanced-configuration-arguments "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| — | –tmpdir | str (directory path) | True | Directory for temporary files (default: system temp directory) |
| — | –keep\_tmp | bool (flag) | True | Keep temporary files after completion (useful for debugging) |
| — | –threads | int | True | Number of CPU threads for parallel processing (default: 1) |

## Clustering Methods Comparison[#](#clustering-methods-comparison "Link to this heading")

### Linclust (Fast Method)[#](#linclust-fast-method "Link to this heading")

**Algorithm**: Linear time complexity clustering
**Performance**: Fast execution suitable for large datasets
**Sensitivity**: Moderate - may miss distant relationships

| Parameter Range | Recommendation |
| --- | --- |
| Identity: 0.7-0.9 | High confidence clusters |
| Identity: 0.5-0.7 | Balanced approach |
| Identity: 0.3-0.5 | Permissive clustering |

### Cluster (Sensitive Method)[#](#cluster-sensitive-method "Link to this heading")

**Algorithm**: Comprehensive pairwise comparisons
**Performance**: Slower but more thorough
**Sensitivity**: High - detects distant homologs

| Parameter | Recommended Range | Impact |
| --- | --- | --- |
| Sensitivity | 4.0-6.0 | Standard sensitivity |
| Sensitivity | 6.0-8.0 | High sensitivity (slower) |
| Max Seqs | 100-300 | Balanced performance |
| Max Seqs | 500-1000 | Comprehensive but slow |

## Parameter Guidelines[#](#parameter-guidelines "Link to this heading")

### Identity and Coverage Combinations[#](#identity-and-coverage-combinations "Link to this heading")

| Identity | Coverage | Clustering Behavior | Biological Interpretation |
| --- | --- | --- | --- |
| 0.9 | 0.9 | Very strict | Nearly identical sequences |
| 0.8 | 0.8 | Strict | Highly conserved families |
| 0.6 | 0.8 | Moderate | Homologous families |
| 0.5 | 0.7 | Permissive | Distant homologs |
| 0.3 | 0.5 | Very permissive | Potential remote homology |

### Coverage Mode Selection[#](#coverage-mode-selection "Link to this heading")

| Mode | Coverage Target | Best Use Case |
| --- | --- | --- |
| 0 | Query coverage | Find complete matches to smaller sequences |
| 1 | Target coverage | Find sequences that completely match targets |
| 2 | Shorter sequence | Balanced approach (recommended) |
| 3 | Longer sequence | Conservative clustering |

## Output Files[#](#output-files "Link to this heading")

PANORAMA generates clustering results with detailed cluster membership information.

### File Organization[#](#file-organization "Link to this heading")

```
output_directory/
└── clustering.tsv
```

### Clustering Results Format[#](#clustering-results-format "Link to this heading")

The clustering results file contains the following columns:

| Column | Description | Example |
| --- | --- | --- |
| cluster\_id | Unique cluster identifier (integer) | 0 |
| referent | Representative gene family ID | PG1\_FAM\_001 |
| in\_clust | Gene family member of this cluster | PG2\_FAM\_045 |

### Results Interpretation[#](#results-interpretation "Link to this heading")

* **cluster\_id**: Sequential integer identifying each cluster group
* **referent**: The representative (typically first or most abundant) family in the cluster
* **in\_clust**: All gene families assigned to this cluster (including the referent)

Example clustering results:

```
cluster_id  referent      in_clust
0           PG1_FAM_001   PG1_FAM_001
0           PG1_FAM_001   PG2_FAM_045
0           PG1_FAM_001   PG3_FAM_078
1           PG1_FAM_002   PG1_FAM_002
1           PG1_FAM_002   PG2_FAM_123
```

[previous

Gene Family Alignment Across Pangenomes](align.html "previous page")
[next

Modeler Documentation](../modeler/modeler_guide.html "next page")

On this page

* [Clustering Workflow](#clustering-workflow)
* [Clustering command Line Usage](#clustering-command-line-usage)
  + [Key Options](#key-options)
  + [MMseqs2 Core Clustering Parameters](#mmseqs2-core-clustering-parameters)
  + [Cluster method-specific parameters](#cluster-method-specific-parameters)
  + [Advanced Parameters (Both Methods)](#advanced-parameters-both-methods)
  + [Advanced Configuration Arguments](#advanced-configuration-arguments)
* [Clustering Methods Comparison](#clustering-methods-comparison)
  + [Linclust (Fast Method)](#linclust-fast-method)
  + [Cluster (Sensitive Method)](#cluster-sensitive-method)
* [Parameter Guidelines](#parameter-guidelines)
  + [Identity and Coverage Combinations](#identity-and-coverage-combinations)
  + [Coverage Mode Selection](#coverage-mode-selection)
* [Output Files](#output-files)
  + [File Organization](#file-organization)
  + [Clustering Results Format](#clustering-results-format)
  + [Results Interpretation](#results-interpretation)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/clustering.md)

### This Page

* [Show Source](../_sources/user/clustering.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.