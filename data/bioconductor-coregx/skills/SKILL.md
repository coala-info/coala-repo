---
name: bioconductor-coregx
description: This tool manages and analyzes multi-omic treatment response data by providing the architectural foundation for the Gx suite of packages in R. Use when user asks to construct TreatmentResponseExperiment objects, map raw experimental data using TREDataMapper, or interact with CoreSet objects for pharmacogenomic and toxicogenomic analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/CoreGx.html
---


# bioconductor-coregx

name: bioconductor-coregx
description: Use for managing and analyzing multi-omic treatment response data in R. This skill provides guidance on using the CoreGx package to construct TreatmentResponseExperiment (TRE) objects, map raw data using TREDataMapper, and interact with CoreSet objects which serve as the foundation for PharmacoGx, RadioGx, and ToxicoGx.

## Overview

CoreGx provides the architectural foundation for the Gx suite of packages (PharmacoGx, RadioGx, ToxicoGx). It defines the `CoreSet` class for integrated multi-omic data and the `TreatmentResponseExperiment` (TRE) class, which uses `data.table` for high-performance storage and manipulation of treatment-response observations.

## Constructing a TreatmentResponseExperiment (TRE)

To transform raw data into a TRE object, use the `TREDataMapper` workflow:

1.  **Load Raw Data**: Import your experimental data as a `data.table` or `data.frame`.
2.  **Initialize Mapper**: Create a `TREDataMapper` object.
    ```r
    library(CoreGx)
    library(data.table)
    dt <- fread("path/to/data.csv")
    tdm <- TREDataMapper(rawdata = dt)
    ```
3.  **Map Columns**: Define which columns identify rows (treatments), columns (samples), and assay measurements. Use `guessMapping` to assist.
    ```r
    # Define grouping hypotheses
    groups <- list(rows = c("drug1id", "drug2id"), cols = c("cellid"))
    guess <- guessMapping(tdm, groups = groups)

    # Assign mappings
    rowDataMap(tdm) <- guess$rows
    colDataMap(tdm) <- guess$cols
    assayMap(tdm) <- list(viability = list(guess$rows$id_columns, c("viability_col")))
    ```
4.  **Construct Object**: Call `metaConstruct` to build the TRE.
    ```r
    tre <- metaConstruct(tdm)
    ```

## Interacting with TRE Objects

### Accessors
*   **Metadata**: Use `rowData(tre)` and `colData(tre)` to view annotations. Use `key = TRUE` to see internal mapping keys.
*   **Assays**: Use `assayNames(tre)` to list assays and `assay(tre, "assay_name")` to retrieve data.

### Subsetting
TRE objects support three subsetting modes:
*   **Standard**: `tre[row_names, col_names]` using exact matches.
*   **Regex**: `tre["^DrugA", "CellLine.*"]` for pattern matching. Use `*` as a shortcut for `.*`.
*   **Data.table**: Use the `.(expression)` syntax for complex queries on metadata columns.
    ```r
    # Subset for specific drug and exclude a batch
    sub_tre <- tre[.(drug1id == "Paclitaxel"), .(batchid != 2)]
    ```

## Working with CoreSet (cSet)

The `CoreSet` class aggregates molecular profiles and treatment responses.

*   **Molecular Data**: Access specific types (e.g., "rna") using `molecularProfiles(cSet, "rna")`.
*   **Sample/Treatment Info**: Use `sampleInfo(cSet)` and `treatmentInfo(cSet)` to retrieve metadata data.frames.
*   **Response Data**: Use `sensitivityProfiles(cSet)` or `sensitivityRaw(cSet)` to access the `treatmentResponse` slot.
*   **Subsetting**: Use `subsetBySample(cSet, ids)`, `subsetByTreatment(cSet, ids)`, or `subsetByFeature(cSet, ids)` to filter the entire object.

## Extending CoreGx Classes

To create a specialized container (e.g., for a new data type):
1.  Define a new class that `contains = "CoreSet"`.
2.  Implement S4 methods for generics like `molecularProfiles` if the internal data structure differs (e.g., using `ExpressionSet` instead of `SummarizedExperiment`).
3.  Define new generics and methods for any custom slots.

## Reference documentation

- [The TreatmentResponseExperiment Class](./references/TreatmentResponseExperiment.md)
- [CoreGx: Class and Function Abstractions](./references/coreGx.md)