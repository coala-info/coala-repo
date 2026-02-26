---
name: bioconductor-geneaccord
description: This tool identifies clonally exclusive gene or pathway pairs in cancer cohorts using phylogenetic tree inference data. Use when user asks to detect mutations occurring in different branches of a tumor phylogeny, identify potential synergies between co-existing clones, or perform statistical tests for clonal exclusivity across patient cohorts.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GeneAccord.html
---


# bioconductor-geneaccord

name: bioconductor-geneaccord
description: Statistical framework for detecting clonally exclusive gene or pathway pairs in cancer cohorts using phylogenetic tree inference data. Use when analyzing tumor subclonal mutation profiles to identify potential synergies between co-existing clones by finding mutations that occur in different branches of the tumor phylogeny more often than expected by chance.

## Overview

GeneAccord identifies pairs of genes or pathways that are mutated in the same tumor but in different clones (clonally exclusive). It uses a likelihood ratio test to compare observed clonal exclusivity frequencies against a background null distribution. The package is designed to handle uncertainty in phylogenetic tree reconstruction by allowing multiple gene-to-clone assignments per patient.

## Workflow and Functions

### 1. Prepare Patient Data

Convert mutation-to-clone assignment files (CSV format) into the required tibble format.

```r
# Create a collection of tree inferences for a patient
# input_files is a vector of paths to CSV files
clone_tbl <- create_tbl_tree_collection(input_files, max_num_clones = 7)

# Compute clonal exclusivity rates for the patient across all trees
rates <- compute_rates_clon_excl(clone_tbl)
avg_rate <- mean(rates)

# Generate histograms of pair occurrences and exclusivity
hist_data <- get_hist_clon_excl(clone_tbl)
```

### 2. Generate Null Distribution

Before testing, generate the empirical cumulative distribution function (ECDF) of the test statistic under the null hypothesis (independence).

```r
# Determine the maximum number of patients a pair is mutated in
num_pat_pair_max <- pairs_in_patients_hist(clone_tbl_all_pats_all_trees)

# Generate ECDF (use high num_pairs_sim for production, e.g., 100000)
ecdf_list <- generate_ecdf_test_stat(avg_rates_m, 
                                     list_of_num_trees_all_pats, 
                                     list_of_clon_excl_all_pats, 
                                     num_pat_pair_max = 15, 
                                     num_pairs_sim = 1000)
```

### 3. Perform Clonal Exclusivity Test

Run the main statistical test to identify significant pairs.

```r
# Standard one-sided test for clonal exclusivity
res_pairs <- GeneAccord(clone_tbl_all_pats_all_trees, avg_rates_m, ecdf_list)

# Two-sided test for specific genes of interest
res_pairs_ts <- GeneAccord(clone_tbl_all_pats_all_trees, 
                           avg_rates_m, 
                           ecdf_list, 
                           alternative = "two.sided", 
                           genes_of_interest = c("ENSG1", "ENSG2"), 
                           AND_OR = "AND")
```

### 4. Process and Visualize Results

Map Ensembl IDs to HGNC symbols and visualize the clonal structures.

```r
# Map to HGNC symbols
all_genes_tbl <- create_ensembl_gene_tbl_hg()
sig_pairs <- map_pairs_to_hgnc_symbols(res_pairs, all_genes_tbl)

# Identify specific patients where pairs are exclusive
sig_pairs <- take_pairs_and_get_patients(clone_tbl_all_pats_all_trees, sig_pairs)

# Visualizations
plot_ecdf_test_stat(ecdf_list)
plot_rates_clon_excl(avg_rates_m, clone_tbl_all_pats_all_trees)
heatmap_clones_gene_pat(sig_pairs, clone_tbl_subset, all_genes_tbl)
```

### 5. Pathway Level Analysis

To perform analysis at the pathway level, map gene-to-clone assignments to pathways using Reactome.

```r
data("ensg_reactome_path_map")
clone_tbl_pw <- convert_ensembl_to_reactome_pw_tbl(clone_tbl_gene, ensg_reactome_path_map)
```

## Tips and Best Practices

- **Tree Uncertainty:** Always use multiple tree inference runs (e.g., different seeds or posterior samples) to populate the `tree_id` column. This allows GeneAccord to account for phylogenetic ambiguity.
- **Simulation Depth:** For publication-quality results, set `num_pairs_sim` in `generate_ecdf_test_stat` to at least 100,000. This is computationally intensive and should be run in parallel or on a cluster if possible.
- **Input Format:** Ensure input CSVs have a first column for the `mutated_entity` followed by binary columns (`0` or `1`) for each clone.
- **Filtering:** GeneAccord only tests pairs that occur in more than one patient. Use `pairs_in_patients_hist` to inspect the cohort frequency of gene pairs before running the full test.

## Reference documentation

- [GeneAccord](./references/GeneAccord.md)