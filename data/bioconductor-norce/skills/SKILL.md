---
name: bioconductor-norce
description: bioconductor-norce performs functional enrichment analysis for non-coding RNAs by identifying and annotating their spatially proximal or target protein-coding genes. Use when user asks to perform GO or pathway enrichment analysis on ncRNA sets, identify cis-acting mRNA neighbors, or integrate TAD boundaries and miRNA target predictions into functional annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/NoRCE.html
---

# bioconductor-norce

name: bioconductor-norce
description: Comprehensive pipeline for preprocessing, annotation, and enrichment analysis of non-coding RNA (ncRNA) sets (lncRNA, miRNA, snoRNA, etc.). Use when analyzing ncRNA gene lists or genomic regions to find functional enrichment in GO terms or pathways (KEGG, Reactome, WikiPathways) based on cis-acting mRNA proximity, TAD boundaries, miRNA target predictions, or co-expression data.

# bioconductor-norce

## Overview

NoRCE (Noncoding RNA Set Cis Annotation and Enrichment) is an R package designed to perform functional enrichment analysis for non-coding RNAs. Because ncRNAs often lack direct functional annotations, NoRCE identifies spatially proximal protein-coding genes (cis-neighbors) and uses their annotations to infer ncRNA function. It supports various ncRNA types, genomic regions, and integrates Topologically Associating Domain (TAD) boundaries, miRNA target predictions, and co-expression data to refine the set of associated coding genes.

## Core Workflow

### 1. Configuration and Parameters
NoRCE uses a global parameter system. Use `setParameters` to modify defaults before running enrichment functions.

```r
# Set upstream and downstream search distances (in bp)
setParameters(type = c("upstream", "downstream"), value = c(5000, 5000))

# Change pathway database (kegg, reactome, wiki, or other)
setParameters("pathwayType", "reactome")
```

### 2. GO Enrichment
Use `geneGOEnricher` for general ncRNAs and `mirnaGOEnricher` for miRNAs.

```r
# Basic neighborhood-based GO enrichment for lncRNAs
ncGO <- geneGOEnricher(
  gene = my_ncRNA_list, 
  org_assembly = 'hg38', 
  near = TRUE, 
  genetype = 'Ensembl_gene'
)

# miRNA enrichment using both proximity and target predictions
mirGO <- mirnaGOEnricher(
  gene = my_mirna_list, 
  org_assembly = 'hg38', 
  near = TRUE, 
  target = TRUE
)
```

### 3. Pathway Enrichment
Similar to GO enrichment, use the pathway-specific functions.

```r
# KEGG enrichment (default)
miPathway <- mirnaPathwayEnricher(
  gene = my_mirna_list, 
  org_assembly = 'hg19', 
  near = TRUE
)
```

### 4. Advanced Filtering
*   **TAD Boundaries**: Set `isTADSearch = TRUE` and provide a TAD object to restrict neighbor search to the same TAD.
*   **Co-expression**: Set `express = TRUE` and provide expression matrices (`exp1`, `exp2`) to filter neighbors by correlation.
*   **Biotype Filtering**: Use `filterBiotype()` with a GTF file to subset your gene list by specific ncRNA categories.

## Visualization and Output

NoRCE provides several ways to interpret results:

*   **Tabular**: `writeEnrichment(mrnaObject, fileName = "results.txt")`
*   **Dot Plot**: `drawDotPlot(mrnaObject, type = "pvalue", n = 20)`
*   **Network**: `createNetwork(mrnaObject, n = 5, isNonCode = TRUE)` - Shows relationships between terms and ncRNAs.
*   **GO DAG**: `getGoDag(mrnaObject, n = 5)` - Visualizes the Gene Ontology hierarchy.
*   **Pathway Maps**: `getKeggDiagram()` or `getReactomeDiagram()` to view enriched pathways in a browser.

## Key Parameters and Keywords

| Organism | Keyword |
| :--- | :--- |
| Homo Sapiens | `hg19`, `hg38` |
| Mus Musculus | `mm10` |
| Rattus Norvegicus | `rn6` |
| Danio Rerio | `dre10` |
| Drosophila Melanogaster | `dm6` |

**Common `setParameters` options:**
*   `searchRegion`: 'all', 'exon', 'intron'
*   `GOtype`: 'BP' (Biological Process), 'CC' (Cellular Component), 'MF' (Molecular Function)
*   `pAdjust`: 'BH', 'bonferroni', 'fdr', etc.

## Reference documentation

- [NoRCE: Noncoding RNA Set Cis Annotation and Enrichment](./references/NoRCE.Rmd)
- [NoRCE Vignette](./references/NoRCE.md)