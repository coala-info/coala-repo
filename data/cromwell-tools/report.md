# cromwell-tools CWL Generation Report

## cromwell-tools_submit

### Tool Description
Submit a WDL workflow on Cromwell.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Total Downloads**: 22.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/cromwell-tools
- **Stars**: N/A
### Original Help Text
```text
usage: cromwell-tools submit [-h] [--url URL] [--username USERNAME]
                             [--password PASSWORD]
                             [--secrets-file SECRETS_FILE]
                             [--service-account-key SERVICE_ACCOUNT_KEY] -w
                             WDL_FILE -i INPUTS_FILES [INPUTS_FILES ...]
                             [-d DEPENDENCIES [DEPENDENCIES ...]]
                             [-o OPTIONS_FILE] [-l LABEL_FILE]
                             [-c COLLECTION_NAME] [--on-hold ON_HOLD]
                             [--validate-labels VALIDATE_LABELS]

Submit a WDL workflow on Cromwell.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  -w WDL_FILE, --wdl-file WDL_FILE
                        Path to the workflow source file to submit for
                        execution.
  -i INPUTS_FILES [INPUTS_FILES ...], --inputs-files INPUTS_FILES [INPUTS_FILES ...]
                        Path(s) to the input file(s) containing input data in
                        JSON format, separated by space.
  -d DEPENDENCIES [DEPENDENCIES ...], --deps-file DEPENDENCIES [DEPENDENCIES ...]
                        Path to the Zip file containing dependencies, or a
                        list of raw dependency files to be zipped together
                        separated by space.
  -o OPTIONS_FILE, --options-file OPTIONS_FILE
                        Path to the Cromwell configs JSON file.
  -l LABEL_FILE, --label-file LABEL_FILE
                        Path to the JSON file containing a collection of
                        key/value pairs for workflow labels.
  -c COLLECTION_NAME, --collection-name COLLECTION_NAME
                        Collection in SAM that the workflow should belong to,
                        if use CaaS.
  --on-hold ON_HOLD     Whether to submit the workflow in "On Hold" status.
  --validate-labels VALIDATE_LABELS
                        Whether to validate cromwell labels.
```


## cromwell-tools_wait

### Tool Description
Wait for one or more running workflow to finish.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools wait [-h] [--url URL] [--username USERNAME]
                           [--password PASSWORD] [--secrets-file SECRETS_FILE]
                           [--service-account-key SERVICE_ACCOUNT_KEY]
                           [--timeout-minutes TIMEOUT_MINUTES]
                           [--poll-interval-seconds POLL_INTERVAL_SECONDS]
                           [--silent]
                           workflow_ids [workflow_ids ...]

Wait for one or more running workflow to finish.

positional arguments:
  workflow_ids

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  --timeout-minutes TIMEOUT_MINUTES
                        number of minutes to wait before timeout.
  --poll-interval-seconds POLL_INTERVAL_SECONDS
                        seconds between polling cromwell for workflow status.
  --silent              whether to silently print verbose workflow information
                        while polling cromwell.
```


## cromwell-tools_status

### Tool Description
Get the status of one or more workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools status [-h] [--url URL] [--username USERNAME]
                             [--password PASSWORD]
                             [--secrets-file SECRETS_FILE]
                             [--service-account-key SERVICE_ACCOUNT_KEY]
                             --uuid UUID

Get the status of one or more workflows.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  --uuid UUID           A Cromwell workflow UUID, which is the workflow
                        identifier.
```


## cromwell-tools_abort

### Tool Description
Request Cromwell to abort a running workflow by UUID.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools abort [-h] [--url URL] [--username USERNAME]
                            [--password PASSWORD]
                            [--secrets-file SECRETS_FILE]
                            [--service-account-key SERVICE_ACCOUNT_KEY] --uuid
                            UUID

Request Cromwell to abort a running workflow by UUID.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  --uuid UUID           A Cromwell workflow UUID, which is the workflow
                        identifier.
```


## cromwell-tools_release_hold

### Tool Description
Request Cromwell to release the hold on a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools release_hold [-h] [--url URL] [--username USERNAME]
                                   [--password PASSWORD]
                                   [--secrets-file SECRETS_FILE]
                                   [--service-account-key SERVICE_ACCOUNT_KEY]
                                   --uuid UUID

Request Cromwell to release the hold on a workflow.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  --uuid UUID           A Cromwell workflow UUID, which is the workflow
                        identifier.
```


## cromwell-tools_metadata

### Tool Description
Retrieve the workflow and call-level metadata for a specified workflow by UUID.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools metadata [-h] [--url URL] [--username USERNAME]
                               [--password PASSWORD]
                               [--secrets-file SECRETS_FILE]
                               [--service-account-key SERVICE_ACCOUNT_KEY]
                               --uuid UUID
                               [--includeKey INCLUDEKEY [INCLUDEKEY ...]]
                               [--excludeKey EXCLUDEKEY [EXCLUDEKEY ...]]
                               [--expandSubWorkflows EXPANDSUBWORKFLOWS]

Retrieve the workflow and call-level metadata for a specified workflow by
UUID.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  --uuid UUID           A Cromwell workflow UUID, which is the workflow
                        identifier.
  --includeKey INCLUDEKEY [INCLUDEKEY ...]
                        When specified key(s) to include from the metadata.
                        Matches any key starting with the value. May not be
                        used with excludeKey.
  --excludeKey EXCLUDEKEY [EXCLUDEKEY ...]
                        When specified key(s) to exclude from the metadata.
                        Matches any key starting with the value. May not be
                        used with includeKey.
  --expandSubWorkflows EXPANDSUBWORKFLOWS
                        When true, metadata for sub workflows will be fetched
                        and inserted automatically in the metadata response.
```


## cromwell-tools_query

### Tool Description
Query for workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools query [-h] [--url URL] [--username USERNAME]
                            [--password PASSWORD]
                            [--secrets-file SECRETS_FILE]
                            [--service-account-key SERVICE_ACCOUNT_KEY]

[NOT IMPLEMENTED IN CLI] Query for workflows.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
```


## cromwell-tools_health

### Tool Description
Check that cromwell is running and that provided authentication is valid.

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools health [-h] [--url URL] [--username USERNAME]
                             [--password PASSWORD]
                             [--secrets-file SECRETS_FILE]
                             [--service-account-key SERVICE_ACCOUNT_KEY]

Check that cromwell is running and that provided authentication is valid.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
```


## cromwell-tools_task_runtime

### Tool Description
Output tsv breakdown of task runtimes by execution event categories

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
- **Homepage**: http://github.com/broadinstitute/cromwell-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell-tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cromwell-tools task_runtime [-h] [--url URL] [--username USERNAME]
                                   [--password PASSWORD]
                                   [--secrets-file SECRETS_FILE]
                                   [--service-account-key SERVICE_ACCOUNT_KEY]
                                   (--metadata METADATA | --uuid UUID)

Output tsv breakdown of task runtimes by execution event categories

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  --metadata METADATA   Metadata json file to calculate cost on
  --uuid UUID           A Cromwell workflow UUID, which is the workflow
                        identifier.
```


## Metadata
- **Skill**: generated
