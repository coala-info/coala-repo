---
name: bioconductor-psygenet2r
description: The psygenet2r package retrieves and analyzes gene-disease associations from the PsyGeNET database to explore the genetic basis of psychiatric disorders. Use when user asks to query psychiatric disease data by gene or disorder, extract literature-based evidence sentences, calculate Jaccard Index for genetic overlap, or perform enrichment analysis on gene lists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/psygenet2r.html
---


# bioconductor-psygenet2r

## Overview
The `psygenet2r` package allows users to interact with the PsyGeNET database to explore the genetic basis of psychiatric disorders. It supports querying by genes or diseases, extracting supporting evidence (sentences from literature), and performing comparative studies like Jaccard Index estimations to identify shared genetic components between disorders.

## Core Workflows

### Querying PsyGeNET
The package uses two primary functions to retrieve data, both of which return a `DataGeNET.Psy` object.

```r
library(psygenet2r)

# Query by Disease (e.g., "schizophrenia", "depression")
# database options: "PsyCUR", "CURATED", "ALL", "MODELS", "GAD", "CTD"
d_sch <- psygenetDisease(disease = "schizophrenia", database = "ALL")

# Query by Gene (Symbol or Entrez ID)
g_alc <- psygenetGene(gene = "ALDH2", database = "ALL")

# Extract raw data frame from the result object
raw_data <- extract(d_sch)
```

### Evidence and Sentences
PsyGeNET provides literature-based evidence for associations. You can retrieve specific sentences that support a gene-disease link.

```r
# Get sentences for a specific disorder from a query object
sentences <- extractSentences(d_sch, disorder = "schizophrenia")

# Direct query for sentences by gene list
genes <- c("PECR", "ADH1C", "CAST")
gene_sentences <- psygenetGeneSentences(geneList = genes, database = "ALL")
```

### Comorbidity and Similarity Analysis
Use the Jaccard Index to estimate the genetic overlap between different diseases or between a gene list and diseases.

```r
# Calculate Jaccard Index between a list of genes and a specific disease
ji <- jaccardEstimation(
  pDisease = c("COMT", "CLOCK", "DRD3"), 
  sDisease = "umls:C0005586", 
  database = "ALL",
  nboot = 100
)

# Extract results
ji_df <- extract(ji)
```

### Enrichment Analysis
Test if a user-provided gene list is enriched for genes associated with psychiatric disorders in PsyGeNET or anatomical terms (TopAnat).

```r
# Enrichment in PsyGeNET diseases
enr <- enrichedPD(gene = c("ADCY2", "AKAP13", "ANK3"), database = "ALL")

# Enrichment in anatomical terms (TopAnat)
# datatypes: "rna_seq", "affymetrix", "est", "in_situ"
ana_enr <- topAnatEnrichment(gene = c("ADCY2", "AKAP13", "ANK3"), datatype = "rna_seq")
```

## Visualization
The package provides several plotting methods for `DataGeNET.Psy` and `JaccardIndexPsy` objects.

```r
# Network and Heatmap visualizations
plot(d_sch, type = "GDA network")    # Gene-Disease Association network
plot(d_sch, type = "GDCA heatmap")  # Gene-Disease Category Association heatmap
plot(d_sch, type = "publications")  # Barplot of PMIDs per association

# Attribute plots for genes
geneAttrPlot(d_sch, type = "pie")              # Pie chart of disease categories
geneAttrPlot(d_sch, type = "evidence index")   # Barplot by Evidence Index

# Panther class visualization
pantherGraphic(c("COMT", "CLOCK", "DRD3"))
```

## Tips and Best Practices
- **Database Selection**: Use `database = "ALL"` for a comprehensive search, or `"PsyCUR"` for the most high-quality, manually curated psychiatric data.
- **Evidence Index**: The `evidenceIndex` argument (default `c(">", 0)`) filters results based on the strength of evidence. An index of 1 indicates all sources agree on the association.
- **Identifiers**: Diseases can be queried using names (e.g., "Depression") or UMLS CUI codes (e.g., "C0011581"). Genes can be queried using Symbols or Entrez IDs.
- **Object Inspection**: Use `ngene(object)` and `ndisease(object)` to quickly check the number of unique entities in your query results.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)