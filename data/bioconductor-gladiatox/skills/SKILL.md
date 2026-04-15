---
name: bioconductor-gladiatox
description: GladiaTOX processes and reports High Content Screening data through automated curve fitting and toxicological modeling. Use when user asks to analyze dose-response data, perform automated curve fitting, calculate Minimal Effective Concentrations, or generate toxicological reports from High Content Screening experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/GladiaTOX.html
---

# bioconductor-gladiatox

name: bioconductor-gladiatox
description: Processing and reporting of High Content Screening (HCS) data using the GladiaTOX R package. Use this skill when analyzing dose-response data, performing automated curve fitting (Hill, Gain-Loss models), calculating Minimal Effective Concentrations (MEC), or generating toxicological reports from HCS experiments.

# bioconductor-gladiatox

## Overview

GladiaTOX is an R package designed for the analysis of High Content Screening (HCS) data. It extends the ToxCast pipeline (`tcpl`) by adding features for fetching raw image quantifications, computing Minimal Effective Concentrations (MEC) based on historical data, and calculating exposure severity scores. It uses a database backend (SQLite or MariaDB) to manage study metadata, raw data, and processing results across multiple levels (0 to 6).

## Workflow

### 1. Database Configuration
GladiaTOX requires a database connection to store and process data. By default, it uses a bundled SQLite database.

```r
library(GladiaTOX)

# Configure for SQLite (default)
sqlite_src <- file.path(system.file(package="GladiaTOX"), "sql", "gladiatoxdb.sqlite")
gtoxConf(drvr = "SQLite", db = sqlite_src, host = NA, user = NA, pass = NULL)

# For production (MariaDB)
# gtoxConf(drvr = "MariaDB", host = "host", user = "user", pass = "pass", db = "db_name")
```

### 2. Loading Metadata and Raw Data
Data loading involves registering the study (asid), assays, and then writing the raw values.

```r
# 1. Register study metadata (plate and assay data frames)
loadAnnot(plate_metadata, assay_metadata, NULL)

# 2. Get the Assay Source ID (asid) for the new study
asid <- gtoxLoadAsid(fld = c("asnm", "asph"), val = list("StudyName", "Phase"))$asid

# 3. Prepare and write raw data (level 0)
dat <- prepareDatForDB(asid, raw_data_df)
gtoxWriteData(dat[, list(acid, waid, wllq, rval)], lvl = 0, type = "mc")
```

### 3. Data Processing
Processing occurs in levels. Level 1-3 handle normalization; Level 4-6 handle model fitting and activity characterization.

```r
# Assign default processing methods (normalization, etc.)
assignDefaultMthds(asid = asid)

# Compute noise band (VMAD) using vehicle controls
aeids <- gtoxLoadAeid(fld = "asid", val = asid)$aeid
mapply(function(xx) gtoxCalcVmad(inputs = xx, aeid = xx), as.integer(aeids))

# Run full pipeline (Level 1 to 6)
gtoxRun(asid = asid, slvl = 1, elvl = 6, mc.cores = 2)
```

### 4. Quality Control and Masking
Identify and remove poor-quality plates or wells before final reporting.

```r
# Generate QC report (PDF)
gtoxReport(type = "qc", asid = asid, odir = getwd())

# Mask a specific plate (set well quality to 0)
apid <- gtoxLoadApid()[u_boxtrack == "Plate_ID", apid]
waids <- gtoxLoadWaid(fld = "apid", val = apid)$waid
m0ids <- gtoxLoadData(lvl = 0, fld = "waid", val = waids)$m0id
gtoxSetWllq(ids = m0ids, wllq = 0, type = "mc")
```

### 5. Visualization and Reporting
GladiaTOX provides specialized plots for toxicological assessment.

*   **Full Report**: `gtoxReport(type = "all", asid = asid, odir = outdir)`
*   **Dose-Response**: `gtoxPlotWin(chid = chemical_id, aeid = endpoint_id, bline = "bmad")`
*   **MEC Boxplots**: `glPlotStat(asid)`
*   **MEC Pie Charts**: `glPlotPie(asid, chnms = c("chem1", "chem2"))`
*   **Severity Scores**: `glPlotToxInd(asid)`

## Key Functions

| Function | Description |
| :--- | :--- |
| `gtoxConf` | Configures the database connection parameters. |
| `loadAnnot` | Loads study, assay, and chemical annotation into the database. |
| `gtoxRun` | Executes the processing pipeline for specified levels. |
| `gtoxLoadData` | Retrieves data from the database at a specific level (0-6). |
| `gtoxPlotM4ID` | Plots the dose-response curve and model fits for a specific ID. |
| `glPlotStat` | Generates boxplots of Minimal Effective Concentrations (MEC). |
| `glPlotToxInd` | Computes and plots the toxicity index (severity score). |

## Reference documentation
- [GladiaTOX: R Package for Processing High Content Screening data](./references/GladiaTOX.Rmd)
- [GladiaTOX: R Package for Processing High Content Screening data](./references/GladiaTOX.md)