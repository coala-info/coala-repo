---
name: bioconductor-cbpmanager
description: The cbpManager package provides an interactive R Shiny interface to manage cancer genomics studies and generate data files compatible with cBioPortal. Use when user asks to initialize cancer studies, manage clinical patient or sample data, upload and merge mutation files, create timeline tracks, or validate study data for cBioPortal.
homepage: https://bioconductor.org/packages/release/bioc/html/cbpManager.html
---

# bioconductor-cbpmanager

name: bioconductor-cbpmanager
description: Managing cancer studies and generating cBioPortal-compatible files using the cbpManager R package. Use this skill to initialize cancer studies, manage clinical patient/sample data, upload mutation (MAF) files, and create timeline tracks for cBioPortal instances.

# bioconductor-cbpmanager

## Overview
The `cbpManager` package provides an interactive R Shiny interface and supporting functions to streamline the creation and management of cancer genomics studies. It specifically targets the generation of metadata and data files (clinical, mutation, and timeline) that adhere to the strict formatting requirements of the cBioPortal for Cancer Genomics.

## Core Workflow

### 1. Initialization and Setup
Before launching the application, it is recommended to set up the required conda environment for data validation and define a persistent directory for your studies to avoid data loss during package updates.

```r
library(cbpManager)

# Setup conda environment for validation (run once)
setupConda_cbpManager()

# Launch the Shiny application with a persistent study directory
cbpManager(
  studyDir = "path/to/your/studies",
  logDir = "path/to/logs"
)
```

### 2. Managing Study Metadata
*   **Create Study:** Use the "Study Metadata" tab to define a new Study ID and Cancer Type. This creates the `meta_study.txt` file and the study subfolder.
*   **Load Study:** Select an existing Study ID from the dropdown to populate the manager with current data.

### 3. Clinical Data Management (Patients and Samples)
The package manages the complex three-line header requirement (Attribute, Description, Data Type) for cBioPortal clinical files.
*   **Attributes:** Add predefined or custom columns.
*   **Entries:** Add or edit rows for `PATIENT_ID` and `SAMPLE_ID`.
*   **Persistence:** You must click **Save** to generate/overwrite `data_clinical_patient.txt` and `data_clinical_sample.txt`.

### 4. Mutation Data (MAF)
*   **Upload:** Upload Mutation Annotation Format (MAF) files.
*   **Merge:** Use `Add uploaded data to existing mutation data` to concatenate new mutations into `data_mutations_extended.txt`.
*   **Edit:** Manually add, edit, or delete specific mutation records within the UI table.

### 5. Timeline Tracks
cBioPortal requires "days since diagnosis" rather than absolute dates.
*   **First Diagnosis:** Set the initial diagnosis date for patients first.
*   **Events:** Add events for Treatment, Surgery, or Status. The package automatically calculates the relative day offsets.
*   **Custom Tracks:** Define new tracks as either `timeline` (start and end) or `timepoint` (start only).

### 6. Resource Links
Add external links (PDFs, reports, or web pages) to specific patients or samples:
1.  Define a `RESOURCE_ID` and `RESOURCE_TYPE` (STUDY, PATIENT, or SAMPLE).
2.  Map specific IDs to URLs.

### 7. Validation
Use the "Validation" tab to run the `validateData.py` script (via the conda environment). This checks for formatting errors before you attempt to load the data into a cBioPortal instance.

## File Naming Conventions
The package automatically manages files with these specific names:
*   `meta_study.txt`
*   `data_clinical_patient.txt` / `meta_clinical_patient.txt`
*   `data_clinical_sample.txt` / `meta_clinical_sample.txt`
*   `data_mutations_extended.txt` / `meta_mutations_extended.txt`
*   `data_timeline_<type>.txt` / `meta_timeline_<type>.txt`

## Reference documentation
- [cbpManager: Managing cancer studies and generating files for cBioPortal](./references/intro.md)