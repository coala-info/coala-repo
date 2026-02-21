---
name: bioconductor-anvilbilling
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVILBilling.html
---

# bioconductor-anvilbilling

name: bioconductor-anvilbilling
description: Use this skill to analyze and reckon cloud billing costs for the AnVIL/Terra platform using the AnVILBilling R package. This skill is appropriate for retrieving billing data from Google BigQuery, calculating costs for specific Terra submissions or Cromwell workflows, and analyzing resource usage (RAM/CPU) associated with cloud analysis projects.

# bioconductor-anvilbilling

## Overview

The `AnVILBilling` package provides R functions to access and analyze billing data for the AnVIL/Terra platform. It bridges the gap between raw Google Cloud Platform (GCP) billing exports in BigQuery and human-readable summaries of costs associated with specific workflows, submissions, and interactive clusters.

## Setup and Prerequisites

Before using this package, GCP billing exports must be configured:
1.  **GCP Export**: Enable billing export to a BigQuery dataset in the GCP console.
2.  **Permissions**: Ensure your Google identity has the `BigQuery User` scope on the project containing the billing data.
3.  **Authentication**: Use `gargle` or `bigrquery` authentication (often handled automatically via `AnVIL::gcloud_auth()`).

## Core Workflow

### 1. Initializing a Billing Request
Define the scope of your cost analysis by specifying the date range and BigQuery location.

```r
library(AnVILBilling)

# Define parameters
start_date <- "2024-01-01"
end_date <- "2024-01-31"
project <- "your-gcp-billing-project"
dataset <- "your_bigquery_dataset"
table <- "gcp_billing_export_v1_XXXX"

# Create request object
req <- setup_billing_request(
    start = start_date, 
    end = end_date, 
    project = project, 
    dataset = dataset, 
    table = table
)
```

### 2. Reckoning Costs
The `reckon()` function executes the BigQuery query and returns an `avReckoning` object.

```r
# Retrieve the data
billing_data <- reckon(req)

# View summary
billing_data
```

### 3. Analyzing Specific Submissions
You can drill down into specific Terra submissions or Cromwell workflows using their IDs.

```r
# Get available submission IDs
submission_ids <- getValues(billing_data@reckoning, "terra-submission-id")

# Get total cost for a specific submission
cost <- getSubmissionCost(billing_data@reckoning, submission_ids[1])

# Get detailed RAM usage for a submission
ram_usage <- getSubmissionRam(billing_data@reckoning, submission_ids[1])
```

### 4. Filtering and Exploration
Use `subsetByKeyValue` to isolate records for specific resources or tasks.

```r
# Subset by a specific key (e.g., cromwell-workflow-id)
sub_table <- subsetByKeyValue(billing_data@reckoning, "terra-submission-id", submission_ids[1])

# List all SKUs (products) used in that subset
AnVILBilling:::getSkus(sub_table)
```

## Key Metadata Keys
When drilling down, use these standard keys:
*   `terra-submission-id`: Links to a specific Terra workflow execution.
*   `cromwell-workflow-id`: Links to individual jobs within a workflow.
*   `goog-dataproc-cluster-name`: Links to Jupyter or RStudio interactive clusters.

## Interactive Exploration
The package includes a Shiny app for visual exploration of billing data:

```r
# Launches a browser interface
browse_reck(email = "your-google-email@gmail.com")
```

## Reference documentation

- [Software for reckoning AnVIL/Terra usage](./references/billing.Rmd)
- [Software for reckoning AnVIL/Terra usage (Markdown)](./references/billing.md)