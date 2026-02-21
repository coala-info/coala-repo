# Running an AnVIL workflow within R

Kayla Interdonato1, Yubo Cheng1 and Martin Morgan1\*

1Roswell Park Comprehensive Cancer Center

\*Martin.Morgan@RoswellPark.org

#### 5 February 2026

#### Abstract

This vignette demonstrates how a user can edit, run, and stop a
Terra / AnVIL workflow from within their R session. The configuration of the
workflow can be retrieved and edited. Then this new configuration can be
sent back to the Terra / AnVIL workspace for future use. With the new
configuration defined by the user will then be able to run the workflow as
well as stop any jobs from running.

#### Package

AnVIL 1.22.5

# Contents

* [1 Installation](#installation)
* [2 Workflow setup: DESeq2](#workflow-setup-deseq2)
  + [2.1 Setting up the workspace and choosing a workflow](#setting-up-the-workspace-and-choosing-a-workflow)
  + [2.2 Retrieving the configuration](#retrieving-the-configuration)
* [3 Updating workflows](#updating-workflows)
  + [3.1 Changing the inputs / outputs](#changing-the-inputs-outputs)
  + [3.2 Update configuration locally](#update-configuration-locally)
  + [3.3 Set a workflow configuration for reuse in AnVIL](#set-a-workflow-configuration-for-reuse-in-anvil)
* [4 Running and stopping workflows](#running-and-stopping-workflows)
  + [4.1 Running a workflow](#running-a-workflow)
  + [4.2 Monitoring workflows](#monitoring-workflows)
  + [4.3 Stopping workflows](#stopping-workflows)
* [5 Managing workflow output](#managing-workflow-output)
  + [5.1 Workflow files](#workflow-files)
  + [5.2 Workflow information](#workflow-information)
* [6 Session information](#session-information)

# 1 Installation

Install the *AnVIL* package with

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = "https://cran.r-project.org")
BiocManager::install("AnVIL")
```

Once installed, load the package with

```
library(AnVILGCP)
library(AnVIL)
```

# 2 Workflow setup: DESeq2

## 2.1 Setting up the workspace and choosing a workflow

The first step will be to define the namespace (billing project) and
name of the workspace to be used with the functions. In our case we
will be using the Bioconductor AnVIL namespace and a DESeq2 workflow
as the intended workspace.

```
avworkspace("bioconductor-rpci-anvil/Bioconductor-Workflow-DESeq2")
```

Each workspace can have 0 or more workflows. The workflows have a
`name` and `namespace`, just as workspaces. Discover the workflows
available in a workspace

```
avworkflows()
```

From the table returned by `avworkflows()`, record the namespace and
name of the workflow of interest using `avworkflow()`.

```
avworkflow("bioconductor-rpci-anvil/AnVILBulkRNASeq")
```

## 2.2 Retrieving the configuration

Each workflow defines inputs, outputs and certain code
execution. These workflow ‘configurations’ that can be retrieved with
`avworkflow_configuration_get`.

```
config <- avworkflow_configuration_get()
config
```

This function is using the workspace namespace, workspace name,
workflow namespace, and workflow name we recorded above with
`avworkspace()` and `avworkflow()`.

# 3 Updating workflows

## 3.1 Changing the inputs / outputs

There is a lot of information contained in the configuration but the
only variables of interest to the user would be the inputs and
outputs. In our case the inputs and outputs are pre-defined so we
don’t have to do anything to them. But for some workflows these
inputs / outputs may be blank and therefore would need to be defined
by the user. We will change one of our inputs values to show how this
would be done.

There are two functions to help users easily see the content of the
inputs and outputs, they are `avworkflow_configuration_inputs` and
`avworkflow_configuration_outputs`. These functions display the
information in a `tibble` structure which users are most likely
familiar with.

```
inputs <- avworkflow_configuration_inputs(config)
inputs

outputs <- avworkflow_configuration_outputs(config)
outputs
```

Let’s change the `salmon.transcriptome_index_name` field; this is an
arbitrary string identifier in our workflow.

```
inputs <-
    inputs |>
    mutate(
        attribute = ifelse(
            name == "salmon.transcriptome_index_name",
            '"new_index_name"',
            attribute
        )
    )
inputs
```

## 3.2 Update configuration locally

Since the inputs have been modified we need to put this information into
the configuration of the workflow. We can do this with
`avworkflow_configuration_update()`. By default this function will take the
inputs and outputs of the original configuration, just in case there were no
changes to one of them (like in our example our outputs weren’t changed).

```
new_config <- avworkflow_configuration_update(config, inputs)
new_config
```

## 3.3 Set a workflow configuration for reuse in AnVIL

Use `avworkflow_configuration_set()` to permanently update the
workflow to new parameter values.

```
avworkflow_configuration_set(new_config)
```

Actually, the previous command validates `new_config` only; to update
the configuration in AnVIL (i.e., replacing the values in the
workspace workflow graphical user interface), add the argument `dry = FALSE`.

```
## avworkflow_configuration_set(new_config, dry = FALSE)
```

# 4 Running and stopping workflows

## 4.1 Running a workflow

To finally run the new workflow we need to know the name of the data set to be
used in the workflow. This can be discovered by looking at the table of
interest and using the name of the data set.

```
entityName <- avtable("participant_set") |>
    pull(participant_set_id) |>
    head(1)
avworkflow_run(new_config, entityName)
```

Again, actually running the new configuration requires the argument
`dry = FALSE`.

```
## avworkflow_run(new_config, entityName, dry = FALSE)
```

`config` is used to set the `rootEntityType` and workflow method name
and namespace; other components of `config` are ignored (the other
components will be read by Terra / AnVIL from values updated with
`avworkflow_configuration_set()`).

## 4.2 Monitoring workflows

We can see that the workflow is running by using the `avworkflow_jobs`
function. The elements of the table are ordered chronologically, with
the most recent submission (most likely the job we just started!)
listed first.

```
avworkflow_jobs()
```

## 4.3 Stopping workflows

Use `avworkflow_stop()` to stop a currently running workflow. This
will change the status of the job, reported by `avworkflow_jobs()`,
from ‘Submitted’ to ‘Aborted’.

```
avworkflow_stop() # dry = FALSE to stop

avworkflow_jobs()
```

# 5 Managing workflow output

## 5.1 Workflow files

Workflows can generate a large number of intermediate files (including
diagnostic logs), as well as final outputs for more interactive
analysis. Use the `submissionId` from `avworkflow_jobs()` to discover
files produced by a submission; the default behavior lists files
produced by the most recent job.

```
submissionId <- "fb8e35b7-df5d-49e6-affa-9893aaeebf37"
avworkflow_files(submissionId)
```

Workflow files are stored in the workspace bucket. The files can be
localized to the persistent disk of the current runtime using
`avworkflow_localize()`; the default is again to localize files from
the most recently submitted job; use `type=` to influence which files
(‘control’ e.g., log files, ‘output’, or ‘all’) are localized.

```
avworkflow_localize(
    submissionId,
    type = "output"
    ## dry = FALSE to localize
)
```

## 5.2 Workflow information

Information on workflows (status, start, and end times, and input and
output parameters) is available with `avworkflow_info()`. The examples
below are from workflows using the [Rcollectl](https://bioconductor.org/packages/Rcollectl) package to measure
time spent in different parts of a single-cell RNA-seq analysis. The
workspace is not publicly available, so results from
`avworkflow_info()` are read from files in this package.

A single job submission can launch multiple workflows. This occurs,
e.g., when a workflow uses several rows from a DATA table to perform
independent analyses. In the example used here, the workflows were
configured to use different numbers of cores (3 or 8) and different
ways of storing single-cell expression data (an in-memory `dgCMatrix`
or an on-disk representation). Thus a single job submission started
four workflows. This example was retrieved with

```
avworkspace("bioconductor-rpci-yubo/Rcollectlworkflowh5ad")
submissionId <- "9385fd75-4cb7-470f-9e07-1979e2c8f193"
info_1 <- avworkflow_info(submissionId)
```

Read the saved version of this result in to *R*.

```
info_file_1 <-
    system.file(package = "AnVIL", "extdata", "avworkflow_info_1.rds")
info_1 <- readRDS(info_file_1)

## view result of avworkflow_info()
info_1
```

Three of the workflows were successful, one failed.

```
info_1 |>
    select(workflowId, status, inputs, outputs)
```

Inputs and outputs for each workflow are stored as list. Strategies
for working with list-columns in tibbles are described in Chapter 24
of [R for Data Science](https://r4ds.hadley.nz/rectangling). Use `tidyr::unnest_wider()` to expand
the inputs. The failed workflow involved 8 `core` using the on-disk
data representation `dgCMatrix = FALSE`.

```
info_1 |>
    select(workflowId, status, inputs) |>
    tidyr::unnest_wider(inputs)
```

The outputs (files summarizing the single-cell analysis, and the
timestamps associated with each step in the analysis) involve two
levels of nesting; following the strategy outlined in
[R for Data Science](https://r4ds.hadley.nz/rectangling), the outputs (google bucket locations) are

```
info_1 |>
    select(workflowId, outputs) |>
    tidyr::unnest_wider(outputs) |>
    tidyr::unnest_longer(starts_with("Rcollectl"), keep_empty = TRUE)
```

In the example used so far, each workflow produces a single file. A
different examples is a workflow that produces multiple output
files. This corresponds to the following submissionId:

```
submissionId <- "35280de1-42d8-492b-aa8c-5feff984bffa"
info_2 <- avworkflow_info(submissionId)
```

Reading the result from the stored version:

```
info_file_2 <-
    system.file(package = "AnVIL", "extdata", "avworkflow_info_2.rds")
info_2 <- readRDS(info_file_2)
info_2
```

Inputs and outputs are manipulated in the same way as before, but this
time there are multiple output files.

```
info_2 |>
    select(workflowId, outputs) |>
    tidyr::unnest_wider(outputs)
```

To see the output files, expand the outputs column using `unnest_longer()`.

```
output_files <-
    info_2 |>
    select(workflowId, outputs) |>
    tidyr::unnest_wider(outputs) |>
    select(RcollectlWorkflowDelayedArrayParameters.Rcollectl_result) |>
    tidyr::unnest_longer(
        "RcollectlWorkflowDelayedArrayParameters.Rcollectl_result"
    )
output_files
```

The full file paths are available using `pull()` or `as.vector()`.

```
output_files |>
    as.vector()
```

# 6 Session information

```
sessionInfo()
```