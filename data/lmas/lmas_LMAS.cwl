cwlVersion: v1.2
class: CommandLineTool
baseCommand: run
label: lmas_LMAS
doc: "Execute a pipeline project\n\nTool homepage: https://github.com/B-UMMI/LMAS"
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
      prefix: --ansi-log
  - id: bucket_dir
    type:
      - 'null'
      - string
    doc: Remote bucket where intermediate result files are stored
    inputBinding:
      position: 102
      prefix: --bucket-dir
  - id: cache
    type:
      - 'null'
      - boolean
    doc: Enable/disable processes caching
    inputBinding:
      position: 102
      prefix: --cache
  - id: disable_jobs_cancellation
    type:
      - 'null'
      - boolean
    doc: Prevent the cancellation of child jobs on execution termination
    inputBinding:
      position: 102
      prefix: --disable-jobs-cancellation
  - id: dsl1
    type:
      - 'null'
      - boolean
    doc: Execute the workflow using DSL1 syntax
    inputBinding:
      position: 102
      prefix: --dsl1
  - id: dsl2
    type:
      - 'null'
      - boolean
    doc: Execute the workflow using DSL2 syntax
    inputBinding:
      position: 102
      prefix: --dsl2
  - id: dump_channels
    type:
      - 'null'
      - boolean
    doc: Dump channels for debugging purpose
    inputBinding:
      position: 102
      prefix: --dump-channels
  - id: dump_hashes
    type:
      - 'null'
      - boolean
    doc: Dump task hash keys for debugging purpose
    inputBinding:
      position: 102
      prefix: --dump-hashes
  - id: entry
    type:
      - 'null'
      - string
    doc: Entry workflow name to be executed
    inputBinding:
      position: 102
      prefix: --entry
  - id: env_var
    type:
      - 'null'
      - string
    doc: Add the specified variable to execution environment
    inputBinding:
      position: 102
      prefix: --e.
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
      prefix: --hub
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Pull latest changes before run
    inputBinding:
      position: 102
      prefix: --latest
  - id: lib
    type:
      - 'null'
      - string
    doc: Library extension path
    inputBinding:
      position: 102
      prefix: --lib
  - id: main_script
    type:
      - 'null'
      - string
    doc: The script file to be executed when launching a project directory or 
      repository
    inputBinding:
      position: 102
      prefix: --main-script
  - id: name
    type:
      - 'null'
      - string
    doc: Assign a mnemonic name to the a pipeline run
    inputBinding:
      position: 102
      prefix: --name
  - id: offline
    type:
      - 'null'
      - boolean
    doc: Do not check for remote project updates
    inputBinding:
      position: 102
      prefix: --offline
  - id: params_file
    type:
      - 'null'
      - File
    doc: Load script parameters from a JSON/YAML file
    inputBinding:
      position: 102
      prefix: --params-file
  - id: plugins
    type:
      - 'null'
      - string
    doc: Specify the plugins to be applied for this run e.g. nf-amazon,nf-tower
    inputBinding:
      position: 102
      prefix: --plugins
  - id: process_options
    type:
      - 'null'
      - string
    doc: Set process options
    inputBinding:
      position: 102
      prefix: --process.
  - id: profile
    type:
      - 'null'
      - string
    doc: Choose a configuration profile
    inputBinding:
      position: 102
      prefix: --profile
  - id: queue_size
    type:
      - 'null'
      - int
    doc: Max number of processes that can be executed in parallel by each 
      executor
    inputBinding:
      position: 102
      prefix: --queue-size
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Execute the script using the cached results, useful to continue 
      executions that was stopped by an error
    inputBinding:
      position: 102
      prefix: --resume
  - id: revision
    type:
      - 'null'
      - string
    doc: Revision of the project to run (either a git branch, tag or commit SHA 
      number)
    inputBinding:
      position: 102
      prefix: -revision
  - id: stub_run
    type:
      - 'null'
      - boolean
    doc: Execute the workflow replacing process scripts with command stubs
    inputBinding:
      position: 102
      prefix: --stub
  - id: test
    type:
      - 'null'
      - string
    doc: Test a script function with the name specified
    inputBinding:
      position: 102
      prefix: --test
  - id: user
    type:
      - 'null'
      - string
    doc: Private repository user name
    inputBinding:
      position: 102
      prefix: --user
  - id: with_charliecloud
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Charliecloud container runtime
    inputBinding:
      position: 102
      prefix: --with-charliecloud
  - id: with_conda
    type:
      - 'null'
      - File
    doc: Use the specified Conda environment package or file (must end with 
      .yml|.yaml suffix)
    inputBinding:
      position: 102
      prefix: --with-conda
  - id: with_dag
    type:
      - 'null'
      - boolean
    doc: Create pipeline DAG file
    inputBinding:
      position: 102
      prefix: --with-dag
  - id: with_docker
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Docker container
    inputBinding:
      position: 102
      prefix: --with-docker
  - id: with_notification
    type:
      - 'null'
      - string
    doc: Send a notification email on workflow completion to the specified 
      recipients
    inputBinding:
      position: 102
      prefix: --with-notification
  - id: with_podman
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Podman container
    inputBinding:
      position: 102
      prefix: --with-podman
  - id: with_report
    type:
      - 'null'
      - boolean
    doc: Create processes execution html report
    inputBinding:
      position: 102
      prefix: --with-report
  - id: with_singularity
    type:
      - 'null'
      - boolean
    doc: Enable process execution in a Singularity container
    inputBinding:
      position: 102
      prefix: --with-singularity
  - id: with_timeline
    type:
      - 'null'
      - boolean
    doc: Create processes execution timeline file
    inputBinding:
      position: 102
      prefix: --with-timeline
  - id: with_tower
    type:
      - 'null'
      - boolean
    doc: Monitor workflow execution with Seqera Tower service
    inputBinding:
      position: 102
      prefix: --with-tower
  - id: with_trace
    type:
      - 'null'
      - boolean
    doc: Create processes execution tracing file
    inputBinding:
      position: 102
      prefix: --with-trace
  - id: with_weblog
    type:
      - 'null'
      - boolean
    doc: Send workflow status messages via HTTP to target URL
    inputBinding:
      position: 102
      prefix: --with-weblog
  - id: without_docker
    type:
      - 'null'
      - boolean
    doc: Disable process execution with Docker
    inputBinding:
      position: 102
      prefix: --without-docker
  - id: without_podman
    type:
      - 'null'
      - boolean
    doc: Disable process execution in a Podman container
    inputBinding:
      position: 102
      prefix: --without-podman
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory where intermediate result files are stored
    inputBinding:
      position: 102
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lmas:2.0.8--hdfd78af_0
stdout: lmas_LMAS.out
