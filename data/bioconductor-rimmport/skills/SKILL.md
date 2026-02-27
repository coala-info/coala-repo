---
name: bioconductor-rimmport
description: This tool connects to ImmPort databases to load and map immunology research data into the CDISC SDTM standard for analysis in R. Use when user asks to load clinical study data, search for specific assay results, or integrate ImmPort datasets into structured data frames.
homepage: https://bioconductor.org/packages/release/bioc/html/RImmPort.html
---


# bioconductor-rimmport

name: bioconductor-rimmport
description: Enables ready-for-analysis immunology research data by connecting to ImmPort databases and mapping data to the CDISC SDTM standard. Use this skill to load, search, and integrate clinical trial data from ImmPort (MySQL or SQLite/Tab formats) into R for immunological analysis.

## Overview

RImmPort provides a standards-based interface to the ImmPort database, which warehouses clinical study data from NIAID-funded immunology research. It transforms proprietary ImmPort data into the Clinical Data Interchange Standards Consortium (CDISC) Study Data Tabulation Model (SDTM). This allows researchers to load entire studies or specific domains (e.g., Demographics, Adverse Events, Assay Results) into R as structured data frames ready for bioinformatics pipelines.

## Core Workflow

### 1. Setup Data Source
RImmPort requires a connection to an ImmPort database (MySQL or SQLite).

```r
library(RImmPort)
library(DBI)
library(RSQLite)

# Option: SQLite (from downloaded Tab-separated files)
# buildNewSqliteDb(tab_dir, db_dir) # If database doesn't exist yet
sqlite_conn <- dbConnect(SQLite(), dbname="path/to/ImmPort.sqlite")
setImmPortDataSource(sqlite_conn)
```

### 2. Explore Available Data
Identify which studies and domains are available in the connected data source.

```r
# List all study IDs (e.g., "SDY139")
studies <- getListOfStudies()

# List all supported SDTM domains
domains <- getListOfDomains()

# List available assay types (e.g., "ELISA", "Flow", "ELISPOT")
assays <- getListOfAssayTypes()
```

### 3. Load Study Data
You can load an entire study or specific subsets.

```r
# Load entire study into a Reference Class object
sdy139 <- getStudy("SDY139")

# Access specific domain data from the study object
# Structure: study$class$domain_list$data_frame
dm_df <- sdy139$special_purpose$dm_l$dm_df

# Load specific domain data across multiple studies
zb_l <- getDomainDataOfStudies("Cellular Quantification", c("SDY139", "SDY208"))
# Returns a list containing 'zb_df' (main data) and 'suppzb_df' (supplemental)
```

### 4. Load Assay Results
Assay data is mapped to specialized Findings domains (ZA, ZB, ZC, ZD, PF).

```r
# Get specific assay data (e.g., ELISPOT) for a study
elispot_data <- getAssayDataOfStudies("SDY139", "ELISPOT")
```

## Data Model Mapping

RImmPort organizes data into five SDTM classes:
- **Special Purpose**: Demographics (DM), Subject Visits (SV)
- **Interventions**: Concomitant Medications (CM), Exposure (EX), Substance Use (SU)
- **Events**: Adverse Events (AE), Protocol Deviations (DV), Medical History (MH)
- **Findings**: Lab Results (LB), Vital Signs (VS), Protein Quantification (ZA), Cellular Quantification (ZB)
- **Trial Design**: Trial Arms (TA), Trial Summary (TS)

## Utility Functions

- `serialzeStudyData(study_ids, rds_dir)`: Saves RImmPort-formatted data as .rds files for faster subsequent loading.
- `loadSerializedStudyData(rds_dir, study_id, domain_name)`: Loads previously serialized .rds data.
- `getDomainCode("Demographics")`: Returns the SDTM code (e.g., "DM").

## Reference documentation

- [RImmPort: Enabling ready-for-analysis immunology research data](./references/RImmPort_Article.md)
- [RImmPort: Quick Start Guide](./references/RImmPort_QuickStart.md)