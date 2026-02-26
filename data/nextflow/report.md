# nextflow CWL Generation Report

## nextflow_auth

### Tool Description
Manage Seqera Platform authentication

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Total Downloads**: 534.0K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/nextflow-io/nextflow
- **Stars**: N/A
### Original Help Text
```text
Manage Seqera Platform authentication
Usage: nextflow auth <sub-command> [options]

Commands:
  login    Authenticate with Seqera Platform
  logout   Remove authentication and revoke access token
  status   Show current authentication status and configuration
  config   Configure Seqera Platform settings
```


## nextflow_clean

### Tool Description
Clean up project cache and work directories

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Clean up project cache and work directories
Usage: clean [options] 
  Options:
    -after
       Clean up runs executed after the specified one
    -before
       Clean up runs executed before the specified one
    -but
       Clean up all runs except the specified one
    -n, -dry-run
       Print names of file to be removed without deleting them
       Default: false
    -f, -force
       Force clean command
       Default: false
    -h, -help
       Print the command usage
       Default: false
    -k, -keep-logs
       Removes only temporary files but retains execution log entries and
       metadata
       Default: false
    -q, -quiet
       Do not print names of files removed
       Default: false
```


## nextflow_clone

### Tool Description
Clone a project into a folder

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Clone a project into a folder
Usage: clone [options] name of the project to clone
  Options:
    -d, -deep
       Create a shallow clone of the specified depth
    -h, -help
       Print the command usage
       Default: false
    -hub
       Service hub where the project is hosted
    -r
       Revision to clone - It can be a git branch, tag or revision number
    -user
       Private repository user name
```


## nextflow_config

### Tool Description
Print a project configuration

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Print a project configuration
Usage: config [options] project name
  Options:
    -flat
       Print config using flat notation (deprecated: use `-o flat` instead)
       Default: false
    -h, -help
       Print the command usage
       Default: false
    -o, -output
       Print the config using the specified format:
       canonical,properties,flat,json,yaml
    -profile
       Choose a configuration profile
    -properties
       Prints config using Java properties notation (deprecated: use `-o
       properties` instead)
       Default: false
    -a, -show-profiles
       Show all configuration profiles
       Default: false
    -sort
       Sort config attributes
       Default: false
    -value
       Print the value of a config option, or fail if the option is not defined
```


## nextflow_drop

### Tool Description
Delete the local copy of a project

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Delete the local copy of a project
Usage: drop [options] name of the project to drop
  Options:
    -f
       Delete the repository without taking care of local changes
       Default: false
    -h, -help
       Print the command usage
       Default: false
```


## nextflow_fs

### Tool Description
File system operations

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nextflow fs <command> [arg]

Commands:
  cp	Copy a file
  mv	Move a file
  ls	List the content of a folder
  cat	Print a file to the stdout
  rm	Remove a file
  stat	Print file to meta info
```


## nextflow_info

### Tool Description
Print project and system runtime information

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Print project and system runtime information
Usage: info [options] project name
  Options:
    -u, -check-updates
       Check for remote updates
       Default: false
    -d
       Show detailed information
       Default: false
    -h, -help
       Print the command usage
       Default: false
    -o
       Output format, either: text (default), json, yaml
```


## nextflow_inspect

### Tool Description
Inspect process settings in a pipeline project

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Inspect process settings in a pipeline project
Usage: inspect [options] Project name or repository url
  Options:
    -concretize
       Build the container images resolved by the inspect command
       Default: false
    -format
       Inspect output format. Can be 'json' or 'config'
       Default: json
    -h, -help
       Print the command usage
       Default: false
    -i, -ignore-errors
       Ignore errors while inspecting the pipeline
       Default: false
    -params-file
       Load script parameters from a JSON/YAML file
    -profile
       Use the given configuration profile(s)
    -r, -revision
       Revision of the project to inspect (either a git branch, tag or commit
       SHA number)
```


## nextflow_kuberun

### Tool Description
Execute a workflow in a Kubernetes cluster (experimental)

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Execute a workflow in a Kubernetes cluster (experimental)
Usage: kuberun [options] Project name or repository url
  Options:
    -E
       Exports all current system environment
       Default: false
    -ansi-log
       Enable/disable ANSI console logging
    -bucket-dir
       Remote bucket where intermediate result files are stored
    -cache
       Enable/disable processes caching
    -d, -deep
       Create a shallow clone of the specified depth
    -disable-jobs-cancellation
       Prevent the cancellation of child jobs on execution termination
    -dump-channels
       Dump channels for debugging purpose
    -dump-hashes
       Dump task hash keys for debugging purpose
    -e.
       Add the specified variable to execution environment
       Syntax: -e.key=value
       Default: {}
    -entry
       Entry workflow name to be executed
    -head-cpus
       Specify number of CPUs requested for the Nextflow driver pod
       Default: 0
    -head-image
       Specify the container image for the Nextflow driver pod
    -head-memory
       Specify amount of memory requested for the Nextflow driver pod
    -head-prescript
       Specify script to be run before nextflow run starts
    -h, -help
       Print the command usage
       Default: false
    -hub
       Service hub where the project is hosted
    -latest
       Pull latest changes before run
       Default: false
    -lib
       Library extension path
    -main-script
       The script file to be executed when launching a project directory or
       repository
    -name
       Assign a mnemonic name to the a pipeline run
    -n, -namespace
       Specify the K8s namespace to use
    -offline
       Do not check for remote project updates
       Default: false
    -o, -output-dir
       Directory where workflow outputs are stored
    -params-file
       Load script parameters from a JSON/YAML file
    -plugins
       Specify the plugins to be applied for this run e.g. nf-amazon,nf-tower
    -pod-image
       Alias for -head-image (deprecated)
    -preview
       Run the workflow script skipping the execution of all processes
       Default: false
    -process.
       Set process options
       Syntax: -process.key=value
       Default: {}
    -profile
       Choose a configuration profile
    -qs, -queue-size
       Max number of processes that can be executed in parallel by each executor
    -remoteProfile
       Choose a configuration profile in the remoteConfig
    -resume
       Execute the script using the cached results, useful to continue
       executions that was stopped by an error
    -r, -revision
       Revision of the project to run (either a git branch, tag or commit SHA
       number)
    -stub-run, -stub
       Execute the workflow replacing process scripts with command stubs
       Default: false
    -test
       Test a script function with the name specified
    -user
       Private repository user name
    -v, -volume-mount
       Volume claim mounts eg. my-pvc:/mnt/path
    -with-apptainer
       Enable process execution in a Apptainer container
    -with-charliecloud
       Enable process execution in a Charliecloud container runtime
    -with-cloudcache
       Enable the use of object storage bucket as storage for cache meta-data
    -with-conda
       Use the specified Conda environment package or file (must end with
       .yml|.yaml suffix)
    -with-dag
       Create pipeline DAG file
    -with-docker
       Enable process execution in a Docker container
    -N, -with-notification
       Send a notification email on workflow completion to the specified
       recipients
    -with-podman
       Enable process execution in a Podman container
    -with-report
       Create processes execution html report
    -with-singularity
       Enable process execution in a Singularity container
    -with-spack
       Use the specified Spack environment package or file (must end with .yaml
       suffix)
    -with-timeline
       Create processes execution timeline file
    -with-tower
       Monitor workflow execution with Seqera Platform (formerly Tower Cloud)
    -with-trace
       Create processes execution tracing file
    -with-weblog
       Send workflow status messages via HTTP to target URL
    -without-conda
       Disable the use of Conda environments
    -without-docker
       Disable process execution with Docker
       Default: false
    -without-podman
       Disable process execution in a Podman container
    -without-spack
       Disable the use of Spack environments
    -w, -work-dir
       Directory where intermediate result files are stored
```


## nextflow_launch

### Tool Description
Launch a workflow in Seqera Platform

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Launch a workflow in Seqera Platform
Usage: nextflow launch <pipeline> [options]

Options:
  -workspace <name>         Workspace name
  -compute-env <name>       Compute environment name (default: primary)
  -name <name>              Assign a mnemonic name to the pipeline run
  -w, -work-dir <path>      Directory where intermediate result files are stored
  -r, -revision <revision>  Revision of the project to run (git branch, tag or commit SHA)
  -profile <profile>        Choose a configuration profile
  -c, -config <file>        Add the specified file to configuration set
  -params-file <file>       Load script parameters from a JSON/YAML file
  -entry <name>             Entry workflow name to be executed
  -resume [session]         Execute the script using the cached results
  -latest                   Pull latest changes before run
  -stub-run, -stub          Execute the workflow replacing process scripts with command stubs
  -main-script <file>       The script file to be executed when launching a project
  --<param>=<value>         Set a parameter used by the pipeline
```


## nextflow_lineage

### Tool Description
Explore workflows lineage metadata

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Explore workflows lineage metadata
Usage: nextflow lineage <sub-command> [options]

Commands:
  check 	Checks the integrity of an lineage file path
  diff  	Show differences between two lineage descriptions
  find  	Find lineage metadata descriptions matching with a query
  list  	List the executions with lineage enabled
  render	Render the lineage graph for a workflow output
  view  	Print the description of a Lineage ID (lid)
```


## nextflow_lint

### Tool Description
Lint Nextflow scripts and config files

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Lint Nextflow scripts and config files
Usage: lint [options] List of paths to lint
  Options:
    -exclude
       File pattern to exclude from error checking (can be specified multiple
       times)
       Default: [.git, .lineage, .nf-test, .nextflow, work]
    -format
       Format scripts and config files that have no errors
       Default: false
    -harshil-alignment
       Use Harshil alignment
       Default: false
    -h, -help
       Print the command usage
       Default: false
    -o, -output
       Output mode for reporting errors: full, extended, concise, json
       Default: full
    -sort-declarations
       Sort script declarations in Nextflow scripts
       Default: false
    -spaces
       Number of spaces to indent
       Default: 0
    -tabs
       Indent with tabs
       Default: false
```


## nextflow_list

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
List all downloaded projects
Usage: list [options]
  Options:
    -h, -help
       Print the command usage
       Default: false
```


## nextflow_log

### Tool Description
Print executions log and runtime info

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Print executions log and runtime info
Usage: log [options] Run name or session id
  Options:
    -after
       Show log entries for runs executed after the specified one
    -before
       Show log entries for runs executed before the specified one
    -but
       Show log entries of all runs except the specified one
    -f, -fields
       Comma separated list of fields to include in the printed log -- Use the
       `-l` option to show the list of available fields
    -F, -filter
       Filter log entries by a custom expression e.g. process =~ /foo.*/ &&
       status == 'COMPLETED'
    -h, -help
       Print the command usage
       Default: false
    -l, -list-fields
       Show all available fields
       Default: false
    -q, -quiet
       Show only run names
       Default: false
    -s
       Character used to separate column values
       Default: \t
    -t, -template
       Text template used to each record in the log
```


## nextflow_plugin

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Execute plugin-specific commands
Usage: plugin [options] 
  Options:
    -h, -help
       Print the command usage
       Default: false
```


## nextflow_pull

### Tool Description
Download or update a project

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Download or update a project
Usage: pull [options] project name or repository url to pull
  Options:
    -all
       Update all downloaded projects
       Default: false
    -d, -deep
       Create a shallow clone of the specified depth
    -h, -help
       Print the command usage
       Default: false
    -hub
       Service hub where the project is hosted
    -r, -revision
       Revision of the project to run (either a git branch, tag or commit SHA
       number)
    -user
       Private repository user name
```


## nextflow_run

### Tool Description
Execute a pipeline project

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Execute a pipeline project
Usage: run [options] Project name or repository url
  Options:
    -E
       Exports all current system environment
       Default: false
    -ansi-log
       Enable/disable ANSI console logging
    -bucket-dir
       Remote bucket where intermediate result files are stored
    -cache
       Enable/disable processes caching
    -d, -deep
       Create a shallow clone of the specified depth
    -disable-jobs-cancellation
       Prevent the cancellation of child jobs on execution termination
    -dump-channels
       Dump channels for debugging purpose
    -dump-hashes
       Dump task hash keys for debugging purpose
    -e.
       Add the specified variable to execution environment
       Syntax: -e.key=value
       Default: {}
    -entry
       Entry workflow name to be executed
    -h, -help
       Print the command usage
       Default: false
    -hub
       Service hub where the project is hosted
    -latest
       Pull latest changes before run
       Default: false
    -lib
       Library extension path
    -main-script
       The script file to be executed when launching a project directory or
       repository
    -name
       Assign a mnemonic name to the a pipeline run
    -offline
       Do not check for remote project updates
       Default: false
    -o, -output-dir
       Directory where workflow outputs are stored
    -params-file
       Load script parameters from a JSON/YAML file
    -plugins
       Specify the plugins to be applied for this run e.g. nf-amazon,nf-tower
    -preview
       Run the workflow script skipping the execution of all processes
       Default: false
    -process.
       Set process options
       Syntax: -process.key=value
       Default: {}
    -profile
       Choose a configuration profile
    -qs, -queue-size
       Max number of processes that can be executed in parallel by each executor
    -resume
       Execute the script using the cached results, useful to continue
       executions that was stopped by an error
    -r, -revision
       Revision of the project to run (either a git branch, tag or commit SHA
       number)
    -stub-run, -stub
       Execute the workflow replacing process scripts with command stubs
       Default: false
    -test
       Test a script function with the name specified
    -user
       Private repository user name
    -with-apptainer
       Enable process execution in a Apptainer container
    -with-charliecloud
       Enable process execution in a Charliecloud container runtime
    -with-cloudcache
       Enable the use of object storage bucket as storage for cache meta-data
    -with-conda
       Use the specified Conda environment package or file (must end with
       .yml|.yaml suffix)
    -with-dag
       Create pipeline DAG file
    -with-docker
       Enable process execution in a Docker container
    -N, -with-notification
       Send a notification email on workflow completion to the specified
       recipients
    -with-podman
       Enable process execution in a Podman container
    -with-report
       Create processes execution html report
    -with-singularity
       Enable process execution in a Singularity container
    -with-spack
       Use the specified Spack environment package or file (must end with .yaml
       suffix)
    -with-timeline
       Create processes execution timeline file
    -with-tower
       Monitor workflow execution with Seqera Platform (formerly Tower Cloud)
    -with-trace
       Create processes execution tracing file
    -with-weblog
       Send workflow status messages via HTTP to target URL
    -without-conda
       Disable the use of Conda environments
    -without-docker
       Disable process execution with Docker
       Default: false
    -without-podman
       Disable process execution in a Podman container
    -without-spack
       Disable the use of Spack environments
    -w, -work-dir
       Directory where intermediate result files are stored
```


## nextflow_secrets

### Tool Description
Manage pipeline secrets

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
Manage pipeline secrets
Usage: nextflow secrets <sub-command> [options]

Commands:
  delete
  get
  list
  set
```


## nextflow_self-update

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Downloading nextflow dependencies. It may require a few seconds, please wait .. 
[KDownloading nextflow dependencies. It may require a few seconds, please wait .. 
[K
      N E X T F L O W
      version 25.10.4 build 11173
      created 10-02-2026 15:17 UTC (15:17 GMT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /usr/local/bin
```


## nextflow_view

### Tool Description
View project script file(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
- **Homepage**: https://github.com/nextflow-io/nextflow
- **Package**: https://anaconda.org/channels/bioconda/packages/nextflow/overview
- **Validation**: PASS

### Original Help Text
```text
View project script file(s)
Usage: view [options] project name
  Options:
    -h, -help
       Print the command usage
       Default: false
    -l
       List repository content
       Default: false
    -q
       Hide header line
       Default: false
```

