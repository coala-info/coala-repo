cwlVersion: v1.2
class: CommandLineTool
baseCommand: run
label: nextflow_run
doc: "Execute a pipeline project\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name_or_url
    type: string
    doc: Project name or repository url
    inputBinding:
      position: 1
  - id: ansi_log
    type:
      - 'null'
      - boolean
    doc: Enable/disable ANSI console logging
    inputBinding:
      position: 102
  - id: bucket_dir
    type:
      - 'null'
      - Directory
    doc: Remote bucket where intermediate result files are stored
    inputBinding:
      position: 102
  - id: cache
    type:
      - 'null'
      - boolean
    doc: Enable/disable processes caching
    inputBinding:
      position: 102
  - id: disable_jobs_cancellation
    type:
      - 'null'
      - boolean
    doc: Prevent the cancellation of child jobs on execution termination
    inputBinding:
      position: 102
  - id: dump_channels
    type:
      - 'null'
      - boolean
    doc: Dump channels for debugging purpose
    inputBinding:
      position: 102
  - id: dump_hashes
    type:
      - 'null'
      - boolean
    doc: Dump task hash keys for debugging purpose
    inputBinding:
      position: 102
  - id: entry
    type:
      - 'null'
      - string
    doc: Entry workflow name to be executed
    inputBinding:
      position: 102
  - id: env_var
    type:
      - 'null'
      - string
    doc: Add the specified variable to execution environment
    inputBinding:
      position: 102
      prefix: -e.
  - id: export_env
    type:
      - 'null'
      - boolean
    doc: Exports all current system environment
    inputBinding:
      position: 102
      prefix: -E
  - id: hub
    type:
      - 'null'
      - string
    doc: Service hub where the project is hosted
    inputBinding:
      position: 102
  - id: lib
    type:
      - 'null'
      - Directory
    doc: Library extension path
    inputBinding:
      position: 102
  - id: main_script
    type:
      - 'null'
      - File
    doc: The script file to be executed when launching a project directory or 
      repository
    inputBinding:
      position: 102
  - id: offline
    type:
      - 'null'
      - boolean
    doc: Do not check for remote project updates
    inputBinding:
      position: 102
  - id: params_file
    type:
      - 'null'
      - File
    doc: Load script parameters from a JSON/YAML file
    inputBinding:
      position: 102
  - id: plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the plugins to be applied for this run e.g. nf-amazon,nf-tower
    inputBinding:
      position: 102
  - id: preview
    type:
      - 'null'
      - boolean
    doc: Run the workflow script skipping the execution of all processes
    inputBinding:
      position: 102
  - id: process_option
    type:
      - 'null'
      - string
    doc: Set process options
    inputBinding:
      position: 102
      prefix: -process.
  - id: profile
    type:
      - 'null'
      - string
    doc: Choose a configuration profile
    inputBinding:
      position: 102
  - id: pull_latest
    type:
      - 'null'
      - boolean
    doc: Pull latest changes before run
    inputBinding:
      position: 102
      prefix: -latest
  - id: queue_size
    type:
      - 'null'
      - int
    doc: Max number of processes that can be executed in parallel by each 
      executor
    inputBinding:
      position: 102
      prefix: -queue-size
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Execute the script using the cached results, useful to continue 
      executions that was stopped by an error
    inputBinding:
      position: 102
  - id: revision
    type:
      - 'null'
      - string
    doc: Revision of the project to run (either a git branch, tag or commit SHA 
      number)
    inputBinding:
      position: 102
      prefix: -revision
  - id: run_name
    type:
      - 'null'
      - string
    doc: Assign a mnemonic name to the a pipeline run
    inputBinding:
      position: 102
      prefix: -name
  - id: shallow_clone
    type:
      - 'null'
      - boolean
    doc: Create a shallow clone of the specified depth
    inputBinding:
      position: 102
      prefix: -deep
  - id: stub_run
    type:
      - 'null'
      - boolean
    doc: Execute the workflow replacing process scripts with command stubs
    inputBinding:
      position: 102
      prefix: -stub
  - id: test
    type:
      - 'null'
      - string
    doc: Test a script function with the name specified
    inputBinding:
      position: 102
  - id: user
    type:
      - 'null'
      - string
    doc: Private repository user name
    inputBinding:
      position: 102
  - id: with_apptainer
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Apptainer container
    inputBinding:
      position: 102
  - id: with_charliecloud
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Charliecloud container runtime
    inputBinding:
      position: 102
  - id: with_cloudcache
    type:
      - 'null'
      - boolean
    doc: Enable the use of object storage bucket as storage for cache meta-data
    inputBinding:
      position: 102
  - id: with_conda
    type:
      - 'null'
      - string
    doc: Use the specified Conda environment package or file (must end with 
      .yml|.yaml suffix)
    inputBinding:
      position: 102
  - id: with_dag
    type:
      - 'null'
      - boolean
    doc: Create pipeline DAG file
    inputBinding:
      position: 102
  - id: with_docker
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Docker container
    inputBinding:
      position: 102
  - id: with_notification
    type:
      - 'null'
      - type: array
        items: string
    doc: Send a notification email on workflow completion to the specified 
      recipients
    inputBinding:
      position: 102
      prefix: -with-notification
  - id: with_podman
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Podman container
    inputBinding:
      position: 102
  - id: with_report
    type:
      - 'null'
      - boolean
    doc: Create processes execution html report
    inputBinding:
      position: 102
  - id: with_singularity
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Singularity container
    inputBinding:
      position: 102
  - id: with_spack
    type:
      - 'null'
      - string
    doc: Use the specified Spack environment package or file (must end with 
      .yaml suffix)
    inputBinding:
      position: 102
  - id: with_timeline
    type:
      - 'null'
      - boolean
    doc: Create processes execution timeline file
    inputBinding:
      position: 102
  - id: with_tower
    type:
      - 'null'
      - boolean
    doc: Monitor workflow execution with Seqera Platform (formerly Tower Cloud)
    inputBinding:
      position: 102
  - id: with_trace
    type:
      - 'null'
      - boolean
    doc: Create processes execution tracing file
    inputBinding:
      position: 102
  - id: with_weblog
    type:
      - 'null'
      - string
    doc: Send workflow status messages via HTTP to target URL
    inputBinding:
      position: 102
  - id: without_conda
    type:
      - 'null'
      - boolean
    doc: Disable the use of Conda environments
    inputBinding:
      position: 102
  - id: without_docker
    type:
      - 'null'
      - boolean
    doc: Disable process execution with Docker
    inputBinding:
      position: 102
  - id: without_podman
    type:
      - 'null'
      - boolean
    doc: Disable process execution in a Podman container
    inputBinding:
      position: 102
  - id: without_spack
    type:
      - 'null'
      - boolean
    doc: Disable the use of Spack environments
    inputBinding:
      position: 102
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory where intermediate result files are stored
    inputBinding:
      position: 102
      prefix: -work-dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where workflow outputs are stored
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
