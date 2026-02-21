---
name: bioconductor-ahwikipathwaysdbs
description: The package provides a comprehensive mapping table of metabolites linked to Wikipathways pathways. The tables include HMDB, KEGG, ChEBI, Drugbank, PubChem compound, ChemSpider, KNApSAcK, and Wikidata IDs plus CAS and InChIKey. The tables are provided for each of the 25 species ("Anopheles gambiae", "Arabidopsis thaliana", "Bacillus subtilis", "Bos taurus", "Caenorhabditis elegans", "Canis familiaris", "Danio rerio", "Drosophila melanogaster", "Equus caballus", "Escherichia coli", "Gallus gallus", "Gibberella zeae", "Homo sapiens", "Hordeum vulgare", "Mus musculus", "Mycobacterium tuberculosis", "Oryza sativa", "Pan troglodytes", "Plasmodium falciparum", "Populus trichocarpa", "Rattus norvegicus", "Saccharomyces cerevisiae", "Solanum lycopersicum", "Sus scrofa", "Zea mays"). These table information can be used for Metabolite Set Enrichment Analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHWikipathwaysDbs.html
---

# bioconductor-ahwikipathwaysdbs

name: bioconductor-ahwikipathwaysdbs
description: Use this skill to retrieve and work with metabolite-pathway mapping tables from WikiPathways via the AHWikipathwaysDbs package. This skill should be used for Metabolite Set Enrichment Analysis (MSEA), cross-referencing metabolite identifiers (HMDB, KEGG, ChEBI, Drugbank, PubChem, ChemSpider, KNApSAcK, Wikidata, CAS, and InChIKey), and identifying metabolites associated with specific biological pathways across 25 supported species.

# bioconductor-ahwikipathwaysdbs

## Overview
The `AHWikipathwaysDbs` package provides comprehensive mapping tables linking metabolites to WikiPathways. It supports 25 species and includes a wide array of external identifiers. Data is primarily accessed through the `AnnotationHub` framework, which provides these mappings as tidy `tibble` objects.

## Core Workflows

### 1. Fetching Data via AnnotationHub
The primary way to access these databases is through the `AnnotationHub` package.

```r
library(AnnotationHub)
ah <- AnnotationHub()

# List all available WikiPathways metabolite records
wp_records <- query(ah, "wikipathways")
```

### 2. Querying for Specific Species
You can narrow down the search to a specific organism (e.g., *Homo sapiens*, *Mus musculus*, or *Arabidopsis thaliana*).

```r
# Query for Human pathways
qr <- query(ah, c("wikipathways", "Homo sapiens"))

# Retrieve the tibble (e.g., using the AH ID like AH91805)
hsatbl <- qr[[1]]
```

### 3. Exploring the Mapping Table
The retrieved object is a `tibble` where each row represents a metabolite-pathway association.

```r
# View the structure
head(hsatbl)

# Filter for a specific pathway by name
pathway_data <- hsatbl[hsatbl$pathway_name == "Amino Acid metabolism", ]

# Access specific identifiers for downstream analysis
# Available columns: wpid, pathway_name, metabolite_name, HMDB_ID, KEGG_ID, 
# ChEBI_ID, DrugBank_ID, PubChem_CID, ChemSpider_ID, KNApSAcK_ID, 
# Wikidata_ID, CAS, and InChI_Key.
kegg_ids <- hsatbl$KEGG_ID
```

### 4. Creating Databases from GPML
If you need to regenerate the tables from the source WikiPathways GPML (XML) files rather than using the cached versions in AnnotationHub:

```r
library(AHWikipathwaysDbs)

# Source the internal data creation script provided by the package
scr <- system.file("scripts/make-data.R", package = "AHWikipathwaysDbs")
source(scr)

# This downloads GPML files and creates .rda files for all 25 species 
# in the current working directory
createWikipathwaysMetabolitesDb()
```

## Supported Species
The package provides data for 25 species, including:
*   *Anopheles gambiae*, *Arabidopsis thaliana*, *Bacillus subtilis*, *Bos taurus*, *Caenorhabditis elegans*, *Canis familiaris*, *Danio rerio*, *Drosophila melanogaster*, *Equus caballus*, *Escherichia coli*, *Gallus gallus*, *Gibberella zeae*, *Homo sapiens*, *Hordeum vulgare*, *Mus musculus*, *Mycobacterium tuberculosis*, *Oryza sativa*, *Pan troglodytes*, *Plasmodium falciparum*, *Populus trichocarpa*, *Rattus norvegicus*, *Saccharomyces cerevisiae*, *Solanum lycopersicum*, *Sus scrofa*, *Zea mays*.

## Tips for Enrichment Analysis
*   The `wpid` column provides the unique WikiPathways identifier (e.g., "WP100").
*   Use the `KEGG_ID` or `HMDB_ID` columns to join this data with experimental metabolomics results.
*   Because the data is returned as a `tibble`, it is compatible with `tidyverse` functions for easy filtering and transformation.

## Reference documentation
- [Creating WikipathwaysDbs](./references/creating-WikipathwaysDbs.md)