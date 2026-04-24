cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tritimap
  - run
label: tritimap_run
doc: "Triti-Map main command. The pipeline supports three execute modules: all, only_mapping
  and only_assembly. First, you need to fill in the configuration file correctly.\n\
  \nTool homepage: https://github.com/fei0810/Triti-Map"
inputs:
  - id: execute_module
    type:
      - 'null'
      - string
    doc: 'Execute module: all, only_mapping, or only_assembly'
    inputBinding:
      position: 1
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 2
  - id: config_file
    type:
      - 'null'
      - File
    doc: Triti-Map config file, generated with tritimap init.
    inputBinding:
      position: 103
      prefix: --config-file
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not execute anything, and display what would be done.
    inputBinding:
      position: 103
      prefix: --dryrun
  - id: jobs
    type:
      - 'null'
      - int
    doc: Use at most N CPU cores/jobs in parallel.
    inputBinding:
      position: 103
      prefix: --jobs
  - id: profile
    type:
      - 'null'
      - string
    doc: Name of profile to use for configuring Snakemake.
    inputBinding:
      position: 103
      prefix: --profile
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Triti-Map running directory.
    inputBinding:
      position: 103
      prefix: --working-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tritimap:0.9.7--pyh5e36f6f_0
stdout: tritimap_run.out
