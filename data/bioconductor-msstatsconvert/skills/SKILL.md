---
name: bioconductor-msstatsconvert
description: This tool converts and preprocesses mass spectrometry data from various signal processing tools into the standardized format required for MSstats and MSstatsTMT statistical analysis. Use when user asks to import raw MS data, clean and filter protein datasets, handle shared peptides, or prepare balanced experimental designs for downstream statistical modeling.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsConvert.html
---


# bioconductor-msstatsconvert

name: bioconductor-msstatsconvert
description: Use this skill to convert and preprocess mass spectrometry (MS) data from various signal processing tools (MaxQuant, OpenMS, Skyline, etc.) into the standardized format required by MSstats and MSstatsTMT for statistical analysis. Use when the user needs to import raw MS data, perform PSM/protein filtering, handle shared peptides, manage fractionation, or create balanced experimental designs in R.

# bioconductor-msstatsconvert

## Overview

`MSstatsConvert` is an R package designed to bridge the gap between MS signal processing tools and statistical modeling. It provides a unified framework for cleaning, filtering, and formatting data from tools like MaxQuant, OpenMS, ProteomeDiscoverer, and Skyline. The package ensures that data meets the specific requirements of the `MSstats` family (label-free, SRM, or TMT) by handling common preprocessing challenges such as shared peptides, missing values, and fractionation.

## Core Workflow

### 1. Logging and Session Info
Before starting, configure the logging behavior to track preprocessing steps.
```r
library(MSstatsConvert)
# Enable logging to a specific file
MSstatsLogsSettings(use_log_file = TRUE, log_file_path = "MSstats_analysis.log")
# Save session info for reproducibility
MSstatsSaveSessionInfo("session_info.log")
```

### 2. Data Import
Use `MSstatsImport` to wrap tool-specific output files.
```r
# Example for MaxQuant (requires evidence and proteinGroups files)
mq_imported = MSstatsImport(
  list(evidence = mq_ev_df, protein_groups = mq_pg_df),
  type = "MSstats", 
  tool = "MaxQuant"
)
```

### 3. Cleaning
Standardize column names and perform initial tool-specific cleaning.
```r
# Clean the imported data
cleaned_data = MSstatsClean(mq_imported, protein_id_col = "Proteins")
```

### 4. Annotation
Create a mapping between MS runs and biological conditions.
```r
# annotation_df must contain Run, Condition, and BioReplicate columns
annotated_data = MSstatsMakeAnnotation(cleaned_data, annotation_df, Run = "Rawfile")
```

### 5. Preprocessing and Filtering
Apply filters for shared peptides, oxidation, or low-quality measurements.
```r
# Define a pattern filter (e.g., remove oxidation)
ox_filter = list(col_name = "Modifications", pattern = "Oxidation", 
                 filter = TRUE, drop_column = TRUE)

processed_data = MSstatsPreprocess(
  cleaned_data,
  annotated_data,
  feature_columns = c("PeptideSequence", "PrecursorCharge"),
  remove_shared_peptides = TRUE,
  pattern_filtering = list(oxidation = ox_filter),
  feature_cleaning = list(remove_features_with_few_measurements = TRUE,
                          summarize_multiple_psms = max)
)
```

### 6. Balanced Design
Finalize the dataset by handling fractions and ensuring a balanced structure for the statistical model.
```r
# Returns an MSstatsValidated object
final_data = MSstatsBalancedDesign(processed_data, 
                                   feature_columns = c("PeptideSequence", "PrecursorCharge"))
```

## Filtering Specifications

Filtering is controlled via named lists passed to `MSstatsPreprocess`:

*   **Score Filtering**: For numerical thresholds (e.g., q-values). Requires `score_column`, `score_threshold`, `direction` ("greater"/"smaller"), and `behavior` ("remove"/"replace").
*   **Pattern Filtering**: For regex-based removal (e.g., "Contaminant"). Requires `col_name`, `pattern`, and `filter`.
*   **Exact Filtering**: For specific string matches. Requires `col_name`, `filter_symbols`, and `behavior`.

## Reference documentation

- [MSstats Data Format](./references/msstats_data_format.md)