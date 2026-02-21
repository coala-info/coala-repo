---
name: islandpath
description: IslandPath-DIMOB is a specialized bioinformatics tool designed to identify genomic islands—clusters of genes acquired through horizontal origin that often carry adaptations related to virulence, antibiotic resistance, or environmental metabolism.
homepage: http://www.pathogenomics.sfu.ca/islandpath/
---

# islandpath

## Overview
IslandPath-DIMOB is a specialized bioinformatics tool designed to identify genomic islands—clusters of genes acquired through horizontal origin that often carry adaptations related to virulence, antibiotic resistance, or environmental metabolism. It specifically flags regions that exhibit both abnormal sequence composition (dinucleotide bias) and proximity to mobility-related genes like integrases or transposases.

## Usage Guidelines

### Core Functionality
The tool automates the identification of Genomic Islands (GIs) by scanning genome files (typically in GenBank format) for two primary signatures:
1.  **Dinucleotide Bias:** Identifying DNA segments where the frequency of dinucleotide pairs deviates significantly from the genome average.
2.  **Mobility Genes:** Detecting genes associated with DNA movement (e.g., integrases, transposases, or insertion sequences).

### Command Line Execution
The standard execution requires a GenBank file as input, which must contain both the nucleotide sequence and gene annotations (specifically "product" or "note" tags that identify mobility genes).

```bash
# Basic execution pattern
islandpath <input_genbank_file> <output_filename>
```

### Best Practices
- **Input Preparation:** Ensure your GenBank files are properly annotated. IslandPath relies on text-matching within the annotation fields to identify mobility genes. If a genome is poorly annotated, the "DIMOB" criteria may fail even if a genomic island is present.
- **Data Interpretation:** A region is typically classified as a genomic island by this tool if it contains a mobility gene and exhibits a dinucleotide bias. Users should manually inspect the output to verify the biological relevance of the predicted clusters.
- **Environment Setup:** Since the tool is available via Bioconda, it is best managed within a dedicated Conda environment to handle its Perl-based dependencies.

### Common Workflow
1.  Download or generate a complete prokaryotic genome in GenBank format.
2.  Run `islandpath` to generate the prediction coordinates.
3.  Cross-reference results with other tools (like IslandPick or SIGI-HMM) for consensus-based genomic island detection.

## Reference documentation
- [IslandPath-DIMOB Overview](./references/anaconda_org_channels_bioconda_packages_islandpath_overview.md)