---
name: bioconductor-drugtargetinteractions
description: This tool identifies drug-target interactions and retrieves bioactivity data for small molecules and proteins using the ChEMBL database. Use when user asks to map gene identifiers to UniProt IDs, query drug-target annotations, or retrieve bioassay measurements for specific compounds and biological targets.
homepage: https://bioconductor.org/packages/release/bioc/html/drugTargetInteractions.html
---


# bioconductor-drugtargetinteractions

name: bioconductor-drugtargetinteractions
description: Identify drug-target interactions for small molecules and gene/protein identifiers using the ChEMBL database. Use this skill when you need to map Ensembl IDs or Gene Names to UniProt IDs, query drug-target annotations, or retrieve bioassay data for specific compounds or proteins.

## Overview
The `drugTargetInteractions` package facilitates the discovery of relationships between drugs (small molecules) and their biological targets (genes/proteins). It utilizes a local SQLite instance of the ChEMBL database to provide comprehensive, annotated drug-target information. The package supports strict ID matching as well as sequence similarity-based approaches (SSNN) using UniProt UNIREF clusters or BioMart paralogs to identify potential interactions for related proteins.

## Environment Setup
Before running queries, you must configure the path to the ChEMBL SQLite database.

```r
library(drugTargetInteractions)

# Define paths to the ChEMBL database and results directory
chembldb <- "path/to/chembl_vXX.db" 
resultsPath <- "./results"
config <- genConfig(chemblDbPath=chembldb, resultsPath=resultsPath)

# Initialize UniChem mapping for ID translations (DrugBank, PubChem, ChEBI)
downloadUniChem(config=config)
cmpIdMapping(config=config)
```

## Core Workflows

### 1. ID Mapping and UniProt Retrieval
To query ChEMBL, you often need UniProt IDs. You can map Gene Names or Ensembl IDs to UniProt IDs using strict matching (IDM) or similarity clusters (SSNN).

```r
# Map Gene Names to Ensembl/UniProt
idMap <- getSymEnsUp(EnsDb="EnsDb.Hsapiens.v86", ids=c("CA7", "CFTR"), idtype="GENE_NAME")

# Get UniProt IDs via UNIREF90 clusters (Sequence Similarity)
keys <- c("ENSG00000145700", "ENSG00000135441")
res_list90 <- getUniprotIDs(taxId=9606, kt="ENSEMBL", keys=keys, seq_cluster="UNIREF90")

# Get UniProt IDs via BioMart Paralogs (Faster, wider evolutionary distance)
queryBy <- list(molType="gene", idType="ensembl_gene_id", ids=keys)
res_list_para <- getParalogs(queryBy)
```

### 2. Querying Drug-Target Annotations
Use `drugTargetAnnot` for direct SQL-based queries against ChEMBL.

```r
# Query by Compound IDs (ChEMBL IDs)
queryCmp <- list(molType="cmp", idType="chembl_id", ids=c("CHEMBL17", "CHEMBL19"))
annot_cmp <- drugTargetAnnot(queryCmp, config=config)

# Query by Protein IDs (UniProt IDs)
queryProt <- list(molType="protein", idType="UniProt_ID", ids=c("P43166", "P00915"))
annot_prot <- drugTargetAnnot(queryProt, config=config)
```

### 3. Querying Bioassay Data
Retrieve experimental bioactivity measurements for compounds or targets.

```r
# Query bioassay data for specific DrugBank IDs
queryBA <- list(molType="cmp", idType="DrugBank_ID", ids=c("DB00945", "DB00316"))
bioassay_results <- drugTargetBioactivity(queryBA, config=config)
```

### 4. Integrated Workflow
Use `runDrugTarget_Annot_Bioassay` to process a list of UniProt IDs (from `getParalogs` or `getUniprotIDs`) and return both annotations and bioassays in a single list.

```r
# Run full pipeline
results <- runDrugTarget_Annot_Bioassay(
    res_list = res_list_para, 
    up_col_id = "ID_up_sp", 
    ens_gene_id = idMap$ens_gene_id, 
    config = config
)

# Access results
annotation_df <- results$Annotation
bioassay_df <- results$Bioassay
```

## Tips for Success
- **Database Version**: Always use a recent version of the ChEMBL SQLite database for production work. The `system.file` sample database is for demonstration only.
- **ID Types**: Supported compound ID types include `chembl_id`, `PubChem_ID`, and `DrugBank_ID`. Supported protein/gene types include `UniProt_ID`, `ENSEMBL`, and `GENE_NAME`.
- **SSNN Logic**: When using sequence similarity (SSNN), the results include a `Query_` prefix in the GeneName column to indicate the interaction was found via a similar protein, not necessarily the exact query gene.

## Reference documentation
- [Drug-Target Interactions](./references/drugTargetInteractions.Rmd)
- [Drug-Target Interactions](./references/drugTargetInteractions.md)