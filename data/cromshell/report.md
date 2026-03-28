# cromshell CWL Generation Report

## cromshell_abort

### Tool Description
Abort a running workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Total Downloads**: 52.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/cromshell
- **Stars**: N/A
### Original Help Text
```text
Usage: cromshell abort [OPTIONS] WORKFLOW_IDS...

  Abort a running workflow.

  WORKFLOW_ID can be one or more workflow ids belonging to a running workflow
  separated by a space (e.g. abort [workflow_id1] [[workflow_id2]...]).

Options:
  --help  Show this message and exit.
```


## cromshell_alias

### Tool Description
Label the given workflow ID or relative id with the given alias. Aliases can be used in place of workflow IDs to reference jobs.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell alias [OPTIONS] WORKFLOW_ID ALIAS

  Label the given workflow ID or relative id with the given alias. Aliases can
  be used in place of workflow IDs to reference jobs.

  Alias must NOT start with '-', have a whitespace char, or be a digit.

  Remove alias by passing empty double quotes as an alias. (e.g. cromshell
  alias [workflow_id] "")

Options:
  --help  Show this message and exit.
```


## cromshell_cost

### Tool Description
Get the cost for a workflow. Only works for workflows that completed more than 24 hours ago on GCS. Requires the 'bq_cost_table' key in the cromshell configuration file to be set to the big query cost table for your organization.

Costs here DO NOT include any call cached tasks. Costs rounded to the nearest cent (approximately).

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell cost [OPTIONS] WORKFLOW_IDS...

  Get the cost for a workflow. Only works for workflows that completed more
  than 24 hours ago on GCS. Requires the 'bq_cost_table' key in the cromshell
  configuration file to be set to the big query cost table for your
  organization.

  Costs here DO NOT include any call cached tasks. Costs rounded to the
  nearest cent (approximately).

Options:
  -c, --color     Color outliers in task level cost results.
  -d, --detailed  Get the cost for a workflow at the task level
  --help          Show this message and exit.
```


## cromshell_counts

### Tool Description
Get the summarized statuses of all tasks in the workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell counts [OPTIONS] WORKFLOW_IDS...

  Get the summarized statuses of all tasks in the workflow.

  WORKFLOW_ID can be one or more workflow ids belonging to a running workflow
  separated by a space. (e.g. counts [workflow_id1] [[workflow_id2]...])

Options:
  -j, --json-summary           Print a json summary of the task status counts
  -x, --compress-subworkflows  Compress sub-workflow metadata information
  --help                       Show this message and exit.
```


## cromshell_list

### Tool Description
List the status of workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell list [OPTIONS]

  List the status of workflows.

Options:
  -c, --color   Color the output by completion status.
  -u, --update  Check completion status of all unfinished jobs.
  --help        Show this message and exit.
```


## cromshell_list-outputs

### Tool Description
List all output files produced by a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell list-outputs [OPTIONS] WORKFLOW_IDS...

  List all output files produced by a workflow.

Options:
  -d, --detailed      Get the output for a workflow at the task level
  -j, --json-summary  Print a json summary of outputs, including non-file
                      types.
  --help              Show this message and exit.
```


## cromshell_logs

### Tool Description
Get a subset of the workflow metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell logs [OPTIONS] WORKFLOW_ID

  Get a subset of the workflow metadata.

Options:
  -s, --status TEXT               Return a list with links to the logs with
                                  the indicated status. Separate multiple keys
                                  by comma or use 'ALL' to print all logs.
                                  Some standard Cromwell status options are
                                  'ALL', 'Done', 'RetryableFailure',
                                  'Running', and 'Failed'.
  -p, --print-logs                Print the contents of the logs to stdout if
                                  true. Note: This assumes GCS bucket logs
                                  with default permissions otherwise this may
                                  not work
  -des, --dont-expand-subworkflows
                                  Do not expand subworkflow info in metadata
  --help                          Show this message and exit.
```


## cromshell_metadata

### Tool Description
Get the full metadata of a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell metadata [OPTIONS] WORKFLOW_ID

  Get the full metadata of a workflow.

Options:
  -des, --dont-expand-subworkflows
                                  Do not expand subworkflow info in metadata
  --help                          Show this message and exit.
```


## cromshell_slim-metadata

### Tool Description
Get a subset of the workflow metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell slim-metadata [OPTIONS] WORKFLOW_ID

  Get a subset of the workflow metadata.

Options:
  -k, --keys TEXT                 Use keys to get a subset of the metadata for
                                  a workflow. Separate multiple keys by comma
                                  (e.g. '-k id[,status,...]').
  -des, --dont-expand-subworkflows
                                  Do not expand subworkflow info in metadata
  -x, --exclude_keys              Toggle to either include or exclude keys
                                  that are specified by the --keys option or
                                  in the cromshell config JSON.
  --help                          Show this message and exit.
```


## cromshell_status

### Tool Description
Check the status of a Cromwell workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Please update the cromwell server in the following config file /root/.cromshell/cromshell_config.json
Usage: cromshell status [OPTIONS] WORKFLOW_ID
Try 'cromshell status --help' for help.

Error: No such option: -h
```


## cromshell_submit

### Tool Description
Submit a workflow and arguments to the Cromwell Server

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell submit [OPTIONS] WDL WDL_JSON

  Submit a workflow and arguments to the Cromwell Server

Options:
  -op, --options-json PATH     JSON file containing configuration options for
                               the execution of the workflow.
  -d, --dependencies-zip PATH  ZIP file or directory containing workflow
                               source files that are used to resolve local
                               imports. This zip bundle will be unpacked in a
                               sandbox accessible to this workflow.
  -n, --no-validation          Do not check womtool for validation before
                               submitting.
  --do-not-flatten-wdls        .
  --help                       Show this message and exit.
```


## cromshell_timing

### Tool Description
Analyze and display timing information for a Cromwell workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Please update the cromwell server in the following config file /root/.cromshell/cromshell_config.json
Usage: cromshell timing [OPTIONS] WORKFLOW_ID
Try 'cromshell timing --help' for help.

Error: No such option: --h Did you mean --help?
```


## cromshell_update-server

### Tool Description
Update the cromwell server in the following config file /root/.cromshell/cromshell_config.json

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Please update the cromwell server in the following config file /root/.cromshell/cromshell_config.json
Usage: cromshell update-server [OPTIONS] CROMWELL_SERVER_URL
Try 'cromshell update-server --help' for help.

Error: No such option: --h Did you mean --help?
```


## cromshell_validate

### Tool Description
Validate a WDL workflow and its input JSON using the Cromwell server's womtool API and miniwdl.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/cromshell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromshell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cromshell validate [OPTIONS] WDL [WDL_JSON]

  Validate a WDL workflow and its input JSON using the Cromwell server's
  womtool API and miniwdl.

  Note: Womtool validation via Cromwell server API does not support validation
  of imported files, however miniwdl does.

Options:
  -d, --dependencies-zip PATH  MiniWDL option: ZIP file or directory
                               containing workflow source files that are used
                               to resolve local imports. This zip bundle will
                               be unpacked in a sandbox accessible to this
                               workflow.
  -s, --strict                 MiniWDL option: Exit with nonzero status code
                               if any lint warnings are shown (in addition to
                               syntax and type errors)
  -sup, --suppress TEXT        MiniWDL option: Warnings to disable e.g.
                               StringCoercion,NonemptyCoercion. (can supply
                               multiple times)
  --no-miniwdl                 Disable miniwdl to validation.
  --no-womtool                 Disable womtool to validation.
  --help                       Show this message and exit.
```


## Metadata
- **Skill**: generated
