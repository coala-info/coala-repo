---
name: absense
description: abSENSE calculates the probability that a gene is undetected in a species due to technical limitations rather than biological loss. Use when user asks to calculate detection failure probabilities, predict expected bitscores across evolutionary distances, or distinguish between gene loss and search sensitivity limitations.
homepage: https://github.com/caraweisman/abSENSE
metadata:
  docker_image: "quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0"
---

# absense

## Overview
abSENSE is a statistical tool designed to interpret the "absence" of homologs in genomic datasets. When a gene is not found in a target species, it could be due to a biological event (gene loss) or a technical limitation (the search tool lacks the power to find it). abSENSE models the expected bitscore of a gene across evolutionary time; if the predicted bitscore falls below the detection threshold, the tool calculates a "probability of detection failure." This allows researchers to identify "detectability blind spots" where homologs are likely present but invisible to standard search methods.

## Usage Instructions

### Input Requirements
abSENSE requires two primary tab-delimited input files:
1.  **Bitscore File**: Contains bitscores of homologs for each gene across at least three species (the focal species where the gene is known to exist, plus at least two others).
2.  **Distance File**: Contains evolutionary distances (substitutions per site) between the focal species and every other species in the analysis. The distance from the focal species to itself must be 0.

### Core Command Line Patterns

**Batch Analysis**
To calculate detection probabilities for all genes in a bitscore file:
```bash
python Run_abSENSE.py --distfile [DISTANCE_FILE] --scorefile [BITSCORE_FILE]
```

**Single Gene Visualization**
To analyze a specific gene and generate a plot showing the bitscore decay curve and detection probabilities:
```bash
python Plot_abSENSE.py --distfile [DISTANCE_FILE] --scorefile [BITSCORE_FILE] --gene [GENE_ID]
```

### Output Interpretation
The tool generates several output files in a timestamped directory:
*   **Detection_Failure_Probabilities**: The primary result. Values near 1.0 suggest the homology search was likely to fail even if the gene were present.
*   **Predicted_bitscores**: The expected bitscore for the homolog in each species based on the evolutionary model.
*   **Bitscore_99PI_lowerbound/higherbound**: The 99% prediction interval for the bitscores. If the observed search threshold is higher than the lower bound, detection failure is a statistical possibility.

### Expert Tips and Best Practices
*   **Focal Species Selection**: Always use the species where the gene is best characterized as the focal species.
*   **Distance Accuracy**: Evolutionary distances are critical. If you do not have distances, calculate them using a standard phylogenetic tool or refer to the methods in Weisman et al. (2020) for calculating substitutions per site.
*   **Minimum Data**: While the tool requires a minimum of three species, accuracy improves significantly with more data points across varying evolutionary distances.
*   **Thresholding**: If abSENSE reports a high probability of detection failure (e.g., >0.5), be cautious about claiming "gene loss" in that species, as the null model of detection failure is sufficient to explain the result.

## Reference documentation
- [abSENSE GitHub README](./references/github_com_caraweisman_abSENSE.md)
- [Bioconda abSENSE Overview](./references/anaconda_org_channels_bioconda_packages_absense_overview.md)