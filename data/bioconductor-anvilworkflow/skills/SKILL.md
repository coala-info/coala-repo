---
name: bioconductor-anvilworkflow
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVILWorkflow.html
---

# bioconductor-anvilworkflow

name: bioconductor-anvilworkflow
description: Facilitates running batch analysis workflows on the AnVIL/Terra cloud platform using the AnVILWorkflow R package. Use this skill when a user needs to clone Terra workspaces, configure workflow inputs, launch cloud-based genomic pipelines (like Salmon or bioBakery), monitor job status, or retrieve results from the Google Cloud Platform via R.

## Overview

The `AnVILWorkflow` package allows R users to leverage cloud-based computing resources (Terra/GCP) to run non-R tools and batch workflows without manual infrastructure management. It simplifies the process of workspace cloning, input configuration, and job submission.

## Setup and Authentication

To use this skill, the user must have a Terra account and a Google Cloud billing project.

```r
library(AnVILWorkflow)

# Set environment (Required for local use)
setCloudEnv(accountEmail = "user@gmail.com", 
            billingProjectName = "my-billing-project")

# Check for gcloud SDK (Required for local use)
AnVILGCP::gcloud_exists()
```

## Workflow 1: Preparing the Workspace

You can browse available resources or clone curated analysis templates.

```r
# List curated analyses (e.g., "salmon", "bioBakery", "pathml")
availableAnalysis()

# Clone a curated template
my_ws <- "unique_workspace_name"
cloneWorkspace(workspaceName = my_ws, analysis = "salmon")

# OR clone any accessible workspace by name
cloneWorkspace(workspaceName = "my_new_ws", templateName = "Tumor_Only_CNV")
```

## Workflow 2: Configuring Inputs

Before running, you must inspect and potentially update the workflow configuration.

```r
# Get current configuration
config <- getWorkflowConfig(workspaceName = my_ws)

# View current inputs
inputs <- currentInput(my_ws, config = config)

# Update an input (e.g., changing a reference index)
new_inputs <- inputs
new_inputs[4, 4] <- "new_reference_path"
updateInput(my_ws, inputs = new_inputs, config = config)
```

## Workflow 3: Execution and Monitoring

Launch the workflow and track its progress.

```r
# Launch the workflow
# If inputName is unknown, run without it to see available options
runWorkflow(my_ws, inputName = "AnVILBulkRNASeq_set", config = config)

# Monitor status
monitorWorkflow(workspaceName = my_ws)

# Abort a submission if necessary
stopWorkflow(my_ws)
```

## Workflow 4: Retrieving Results

Once the status indicates success, list or download the output files.

```r
# Get outputs from a specific submission
submissions <- monitorWorkflow(my_ws)
success_id <- submissions$submissionId[submissions$succeeded == 1][1]

out <- getOutput(workspaceName = my_ws, submissionId = success_id)
head(out)
```

## Tips
- **Unique Names**: `workspaceName` must be unique within your billing project. Use `tempfile()` or timestamps to generate unique strings.
- **Dry Runs**: `updateInput` defaults to `dry = TRUE`. Set `dry = FALSE` to commit changes to the cloud.
- **Browsing**: Use `AnVILBrowse("keyword")` to find relevant data or workflows on the AnVIL platform.

## Reference documentation
- [Salmon Workflow Example](./references/salmon.md)