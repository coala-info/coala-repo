---
name: bioconductor-dominoeffect
description: This tool identifies and annotates protein mutation hotspots in cancer datasets by detecting amino acid residues with high mutation loads. Use when user asks to identify mutation hotspots, calculate the statistical significance of mutation clusters, or map residues to functional protein regions and UniProt annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/DominoEffect.html
---

# bioconductor-dominoeffect

name: bioconductor-dominoeffect
description: Identify and annotate protein mutation hotspots in cancer datasets using the DominoEffect R package. Use this skill when you need to detect amino acid residues with high mutation loads, calculate statistical significance of hotspots, and map these residues to functional protein regions or UniProt annotations.

## Overview
DominoEffect is a Bioconductor package designed to identify mutation hotspots—individual amino acid residues that accumulate a disproportionately high fraction of a protein's total mutation load. These hotspots often signify critical functional sites in cancer-associated proteins. The package performs statistical testing (Poisson test) to identify significant clusters and provides functional/structural annotations for the affected regions by integrating Ensembl and UniProt data.

## Core Workflow

### 1. Loading Data
The package requires three primary inputs: a mutation dataset, gene information, and SNP frequency data.

```r
library(DominoEffect)

# Load provided example data
data("TestData", package = "DominoEffect") # Mutation dataset
data("DominoData", package = "DominoEffect") # Gene/Transcript info (Ensembl 73)
data("SnpData", package = "DominoEffect") # Population SNPs (MAF > 1%)
```

### 2. Running the Main Pipeline
The `DominoEffect()` function is a wrapper that identifies hotspots and maps them to functional elements in one step.

```r
hotspot_results <- DominoEffect(
  mutation_dataset = TestData, 
  gene_data = DominoData, 
  snp_data = SnpData,
  write_to_file = "NO"
)
```

### 3. Modular Analysis
You can run the identification and annotation steps separately for more control.

**Step A: Identify Hotspots**
```r
hotspots <- identify_hotspots(
  mutation_dataset = TestData,
  gene_data = DominoData,
  snp_data = SnpData,
  min_n_muts = 5,          # Minimum mutations at a residue
  MAF_thresh = 0.01,       # Filter common polymorphisms
  flanking_region = 200,   # Window size for background rate
  poisson.thr = 0.01,      # Adjusted p-value threshold
  approach = "percentage", # "percentage", "ratio", or "both"
  percentage.thr = 0.15    # Min % of window mutations at residue
)
```

**Step B: Map to Functional Elements**
```r
# Annotates hotspots with UniProt domains and regions
annotated_results <- map_to_func_elem(
  hotspots, 
  ens_release = "73", 
  write_to_file = "NO"
)
```

## Input Data Requirements

| Dataset | Required Columns / Format |
| :--- | :--- |
| **Mutation Data** | `Ensembl_gene_id`, `Protein_residue`, `Original_aa`, `Mutated_aa`, `Genomic_coordinate` |
| **Gene Data** | `Ensembl_gene_id`, `Representative_tr`, `cDNA_length`, `Gene_name`, `Uniprot_id` |
| **SNP Data** | `Chr_name`, `Position_on_chr`, `Minor_allele_freq` |

*Note: Mutation data can also be provided as a `GRanges` or `GRangesList` object.*

## Tips and Best Practices
- **Small Cohorts:** For smaller datasets, relax the `min_n_muts` parameter (e.g., set to 3 instead of the default 5).
- **Ensembl Versions:** The default data uses Ensembl v73 (GRCh37). If using a newer release, provide custom `gene_data` and `snp_data` and update the `ens_release` parameter in `map_to_func_elem()`.
- **Filtering:** Use the `approach` parameter to define how hotspots are prioritized. "ratio" compares the residue mutation count to the expected background rate, while "percentage" ensures a specific fraction of the window's mutations are concentrated at that spot.
- **Downstream Analysis:** Convert results to a `GPos` object for integration with other GenomicRanges-based Bioconductor tools.

## Reference documentation
- [Vignette for DominoEffect package](./references/Vignette.md)