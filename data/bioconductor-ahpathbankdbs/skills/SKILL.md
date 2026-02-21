---
name: bioconductor-ahpathbankdbs
description: The package provides a comprehensive mapping table of metabolites and proteins linked to PathBank pathways. The tables include HMDB, KEGG, ChEBI, CAS, Drugbank, Uniprot IDs. The tables are provided for each of the 10 species ("Homo sapiens", "Escherichia coli", "Mus musculus", "Arabidopsis thaliana", "Saccharomyces cerevisiae", "Bos taurus", "Caenorhabditis elegans", "Rattus norvegicus", "Drosophila melanogaster", and "Pseudomonas aeruginosa"). These table information can be used for Metabolite Set (and other) Enrichment Analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHPathbankDbs.html
---

# bioconductor-ahpathbankdbs

name: bioconductor-ahpathbankdbs
description: Access and use PathBank pathway annotation databases via AnnotationHub. Use this skill to retrieve mapping tables for metabolites and proteins linked to PathBank pathways across 10 species (Human, E. coli, Mouse, etc.). This is essential for Metabolite Set Enrichment Analysis (MSEA), protein-pathway mapping, and cross-referencing IDs like HMDB, KEGG, ChEBI, DrugBank, and UniProt.

## Overview
The `AHPathbankDbs` package provides metadata and access to comprehensive PathBank pathway mapping tables stored in `AnnotationHub`. These tables link biological entities (metabolites or proteins) to specific pathways and include a wide array of external database identifiers.

Supported species:
- Homo sapiens
- Escherichia coli
- Mus musculus
- Arabidopsis thaliana
- Saccharomyces cerevisiae
- Bos taurus
- Caenorhabditis elegans
- Rattus norvegicus
- Drosophila melanogaster
- Pseudomonas aeruginosa

## Workflow: Fetching Data from AnnotationHub

To access the PathBank databases, use the `AnnotationHub` interface.

### 1. Initialize AnnotationHub
```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### 2. Query for PathBank Records
Search for all available PathBank records:
```r
qr_all <- query(ah, "pathbank")
```

Filter by species and type (metabolites or proteins):
```r
# Example: Search for E. coli records
qr_ecoli <- query(ah, c("pathbank", "Escherichia coli"))
qr_ecoli
```

### 3. Retrieve the Data
Select the desired record from the query results (usually index 1 for metabolites and 2 for proteins in a species-specific query):
```r
# Load the first record (e.g., metabolites)
ecoli_metabolites <- qr_ecoli[[1]]
```

## Data Structure and Usage

The retrieved data is a `tibble`. Each row represents a unique entity-pathway association.

### Metabolite Table Columns
- **PathBank ID / Pathway Name**: Pathway identifiers.
- **Metabolite ID / Name**: PathBank-specific metabolite info.
- **External IDs**: HMDB ID, KEGG ID, ChEBI ID, DrugBank ID, CAS.
- **Chemical Info**: Formula, IUPAC, SMILES, InChI, InChI Key.

### Filtering for Specific Pathways
To extract all metabolites for a specific pathway (e.g., "TCA Cycle"):
```r
tca_metabolites <- ecoli_metabolites[ecoli_metabolites$`Pathway Name` == "TCA Cycle", ]
```

## Creating Local Databases
If you need to generate the `.rda` files locally from the latest PathBank CSV source:

```r
library(AHPathbankDbs)
# Source the internal processing script
scr <- system.file("scripts/make-data.R", package = "AHPathbankDbs")
source(scr)

# Generate metabolite and protein tables for all species
createPathbankMetabolitesDb()
createPathbankProteinsDb()
```
Note: These functions download large CSV files and save `.rda` files to your current working directory.

## Reference documentation
- [Provide PathbankDb databases for AnnotationHub (Rmd)](./references/creating-PathbankDbs.Rmd)
- [Provide PathbankDb databases for AnnotationHub (Markdown)](./references/creating-PathbankDbs.md)