---
name: bioconductor-impcdata
description: This tool provides an R interface to access and retrieve phenotyping data from the International Mouse Phenotyping Consortium (IMPC) database. Use when user asks to explore IMPC pipelines and procedures, list phenotyping centers, or download mouse phenotyping datasets for statistical analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/IMPCdata.html
---

# bioconductor-impcdata

name: bioconductor-impcdata
description: Access and retrieve phenotyping data from the International Mouse Phenotyping Consortium (IMPC) database. Use this skill to programmatically explore IMPC pipelines, procedures, and parameters, and to download datasets for statistical analysis (e.g., with PhenStat).

## Overview

The `IMPCdata` package provides an R interface to the IMPC database and the IMPReSS (International Mouse Phenotyping Resource of Standardised Screens) SOAP APIs. It allows users to navigate the complex hierarchy of phenotyping data—from centers and pipelines down to specific genes and alleles—and retrieve matched experimental and control datasets.

## Core Workflow

The typical workflow involves a top-down exploration of the IMPC data dimensions to identify specific filters before downloading the final dataset.

1.  **Identify the Center and Pipeline**: Start by listing available phenotyping centers and their associated pipelines.
2.  **Select Procedure and Parameter**: Drill down into the specific screens (procedures) and the individual measurements (parameters) taken.
3.  **Filter by Genetics**: Identify the strains, genes, and alleles available for the selected parameter.
4.  **Retrieve Data**: Download the final dataset as a `data.frame` for analysis.

## Key Functions

### Discovery ("List") Functions
Most discovery functions come in two forms: `get*` (returns IDs) and `print*` (prints human-readable ID-Name pairs).

*   **Centers**: `getPhenCenters()`, `printPhenCenters()`
*   **Pipelines**: `getPipelines(center)`, `printPipelines(center)`
*   **Procedures**: `getProcedures(center, pipelineID)`, `printProcedures(center, pipelineID)`
*   **Parameters**: `getParameters(center, pipelineID, procedureID)`, `printParameters(...)`
*   **Strains/Genes/Alleles**: 
    *   `getStrains(center, pipelineID, procedureID, parameterID)`
    *   `getGenes(center, pipelineID, procedureID, parameterID, strainID)`
    *   `getAlleles(center, pipelineID, procedureID, parameterID, strainID)`
*   **Zygosities**: `getZygosities(center, pipelineID, procedureID, parameterID, ...)`

### Data Retrieval Functions
*   **`getIMPCTable(fileName, ...)`**: Generates a CSV file containing all possible combinations of objects for a given filter. The last column of this CSV contains the exact R code needed to call `getIMPCDataset`.
*   **`getIMPCDataset(center, pipelineID, procedureID, parameterID, alleleID, ...)`**: The primary function to download a `data.frame` containing matched mutant and control data.

## Examples

### Exploring the Hierarchy
```r
library(IMPCdata)

# 1. Find pipelines for a specific center
printPipelines("WTSI")

# 2. Find procedures for a pipeline
printProcedures("WTSI", "MGP_001")

# 3. Find parameters for a procedure (e.g., Complete Blood Count)
printParameters("WTSI", "MGP_001", "IMPC_CBC_001")
```

### Downloading Data for Analysis
```r
# Download a specific dataset
dataset <- getIMPCDataset(
  PhenCenterName = "WTSI",
  PipelineID = "MGP_001",
  ProcedureID = "IMPC_CBC_001",
  ParameterID = "IMPC_CBC_003_001",
  AlleleID = "MGI:4431644"
)

# The resulting data.frame is compatible with PhenStat
library(PhenStat)
phenList <- PhenList(
  dataset = dataset,
  testGenotype = "MDTZ",
  refGenotype = "+/+",
  dataset.colname.genotype = "Colony"
)
```

## Tips and Best Practices
*   **Legacy Pipelines**: By default, `getPipelines` excludes legacy data. Set `excludeLegacyPipelines = FALSE` to include older datasets.
*   **Name Resolution**: If you have an ID but need the name (or vice versa), use `getName(field_id, field_name, id_value)`.
*   **Batch Discovery**: Use `getIMPCTable` to map out all available datasets for a specific procedure. This is more efficient than manual discovery if you need to process multiple alleles.
*   **MGI IDs**: Most genetic identifiers (strains, genes, alleles) use MGI accession IDs (e.g., "MGI:101835").

## Reference documentation
- [IMPCdata: data retrieval from IMPC database](./references/IMPCdata.md)