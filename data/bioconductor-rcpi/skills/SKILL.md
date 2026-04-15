---
name: bioconductor-rcpi
description: The Rcpi package provides an integrated platform for drug discovery by transforming biological sequences and chemical structures into numerical descriptors for machine learning. Use when user asks to retrieve protein or molecular data, calculate chemical fingerprints, extract protein descriptors, or model compound-protein and protein-protein interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/Rcpi.html
---

# bioconductor-rcpi

## Overview

The `Rcpi` package is an integrated R/Bioconductor platform that bridges bioinformatics and chemoinformatics. It is designed for drug discovery workflows, including quantitative structure-activity relationship (QSAR) modeling, proteochemometrics (PCM), and chemogenomics. It provides tools to transform raw biological sequences and chemical structures into numerical feature vectors (descriptors) suitable for machine learning.

## Core Workflows

### 1. Data Retrieval and Loading
`Rcpi` can fetch data directly from web databases or load local files.

*   **Proteins:** Use `readFASTA()` or `readPDB()` for local files. Use `getProt()` or `getSeqFromKEGG()` for remote retrieval.
*   **Molecules:** Use `readMolFromSmi()` or `readMolFromSDF()` for local files. Use `getDrug()` or `getSmiFromPubChem()` for remote retrieval.
*   **Validation:** Always run `checkProt(sequence)` to ensure protein sequences contain only the 20 standard amino acids before descriptor extraction.

### 2. Protein Descriptor Extraction
Descriptors are categorized into groups such as composition, autocorrelation, and profile-based (PSSM).

*   **Standard Descriptors:** `extractProtAAC()` (Amino Acid Composition), `extractProtAPAAC()` (Amphiphilic Pseudo-AAC), `extractProtCTDC()` (Composition).
*   **PSSM Profiles:** Use `extractProtPSSM()` to compute Position-Specific Scoring Matrices.
*   **PCM Scales:** Use `extractPCMScales()` or `extractPCMPropScales()` for proteochemometric modeling.

### 3. Molecular Descriptor and Fingerprint Extraction
`Rcpi` supports over 300 descriptors and various fingerprint types.

*   **Descriptors:** `extractDrugAIO()` (All-in-one), `extractDrugWeight()`, `extractDrugTPSA()`, `extractDrugLogP()`.
*   **Fingerprints:** `extractDrugStandard()`, `extractDrugMACCS()`, `extractDrugEstate()`, `extractDrugPubChem()`. Use the `...Complete()` version of these functions to get the full bit vector.

### 4. Interaction Descriptors (CPI/PPI)
To model interactions, combine protein and drug descriptors into a single vector.

*   **Compound-Protein (CPI):** `getCPI(prot_desc, drug_desc, type = "combine")`.
*   **Protein-Protein (PPI):** `getPPI(protA_desc, protB_desc, type = "tensorprod")`.
*   **Types:** `combine` (concatenation), `tensorprod` (pseudo-tensor product), or `entrywise` (for PPI).

### 5. Similarity Searching
*   **Chemical Similarity:** `calcDrugFPSim(fp1, fp2, metric = "tanimoto")` or `searchDrug()` for database-wide searches.
*   **Sequence Similarity:** `calcTwoProtSeqSim()` (alignment-based) or `calcTwoProtGOSim()` (Gene Ontology-based).

## Practical Tips

*   **Parallelization:** Many retrieval and search functions (e.g., `getSeqFromKEGG`, `searchDrug`) support a `parallel` or `cores` argument to speed up processing.
*   **Data Preparation:** When building machine learning models (e.g., with `caret`), use `nearZeroVar()` to remove uninformative (constant) descriptors, especially when using sparse fingerprints.
*   **Format Conversion:** Use `convMolFormat()` to switch between chemical formats like SDF and SMILES.

## Reference documentation

- [Rcpi Quick Reference Card](./references/Rcpi-quickref.md)
- [Rcpi: Integrated Informatics Platform for Drug Discovery](./references/Rcpi.md)