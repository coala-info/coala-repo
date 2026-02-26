---
name: krakmeopen
description: krakmeopen is a toolkit for calculating quality metrics and k-mer distribution statistics from Kraken 2 or StringMeUp taxonomic classifications. Use when user asks to analyze classification confidence, calculate lineage ratios, or aggregate k-mer tallies across multiple samples to identify false positive taxonomic assignments.
homepage: https://github.com/danisven/KrakMeOpen
---


# krakmeopen

## Overview

krakmeopen is a specialized toolkit designed for the downstream analysis of Kraken 2 (or StringMeUp) read-by-read classifications. While Kraken 2 provides taxonomic assignments, krakmeopen goes deeper by calculating specific quality metrics based on k-mer distributions within a clade. It allows researchers to distinguish between high-confidence assignments and potential false positives by analyzing metrics such as alternative confidence scores, lineage ratios, and average taxonomic distances. It also supports a two-step workflow to aggregate k-mer tallies from multiple classification files before calculating final metrics.

## Installation

Install krakmeopen via Bioconda:

```bash
conda install -c conda-forge -c bioconda krakmeopen
```

## Core Workflow

### Single Sample Analysis
To calculate quality metrics for a specific taxonomic ID (taxID) from a Kraken 2 output file:

```bash
krakmeopen --input classifications.kraken2 \
           --output metrics_out.tsv \
           --names names.dmp \
           --nodes nodes.dmp \
           --tax_id <INT> \
           --output_kmer_tally kmer_tally.tsv
```

### Batch Processing
If you need metrics for multiple taxa, provide a file containing one taxID per line:

```bash
krakmeopen --input classifications.kraken2 \
           --output metrics_out.tsv \
           --names names.dmp \
           --nodes nodes.dmp \
           --tax_id_file tax_ids.txt
```

### Multi-Sample Aggregation
For projects with multiple sequencing runs or samples that should be analyzed together, use the "pickle" workflow:

1.  **Generate tallies for each sample:**
    ```bash
    krakmeopen --input sample_1.kraken2 --output_pickle s1.pickle --names names.dmp --nodes nodes.dmp --tax_id 9606
    krakmeopen --input sample_2.kraken2 --output_pickle s2.pickle --names names.dmp --nodes nodes.dmp --tax_id 9606
    ```

2.  **Calculate combined metrics:**
    Create a text file (`pickle_list.txt`) containing the paths to the `.pickle` files, then run:
    ```bash
    krakmeopen --input_file_list pickle_list.txt --output combined_metrics.tsv --names names.dmp --nodes nodes.dmp --tax_id 9606
    ```

## Key Metrics Explained

| Metric | Description |
| :--- | :--- |
| `confidence_original` | The standard Kraken 2 confidence score. |
| `confidence_classified` | An alternative score where unclassified k-mers are removed from the denominator, highlighting the strength of the classification among classified k-mers only. |
| `other_kmers_lineage_ratio` | Ratio of k-mers classified to the lineage directly above the target clade vs. all k-mers outside the clade. |
| `other_kmers_distance` | The average taxonomic distance between the target root and the taxa where "off-target" k-mers were assigned. |

## Best Practices

*   **Taxonomy Matching:** Always use the exact `names.dmp` and `nodes.dmp` files that were used to build the Kraken 2 database. Using different versions will result in incorrect clade aggregations.
*   **Input Compression:** krakmeopen natively supports gzipped Kraken 2 classification files, saving disk space.
*   **Clade-Level Focus:** Remember that metrics are calculated at the clade level. All k-mers from reads assigned to any node within the clade rooted at your target `tax_id` are aggregated.
*   **Confidence Filtering:** Use `confidence_classified` to identify samples where a low "original" confidence is driven primarily by a high number of unclassified k-mers rather than conflicting taxonomic assignments.

## Reference documentation

- [krakmeopen - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_krakmeopen_overview.md)
- [GitHub - danisven/KrakMeOpen: A Kraken2 downstream analysis toolkit.](./references/github_com_danisven_KrakMeOpen.md)