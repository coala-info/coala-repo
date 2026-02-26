cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_galaxy_workflow.py
label: galaxy-workflow-executor_run_galaxy_workflow.py
doc: "Runs a Galaxy workflow based on provided configuration and inputs.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/galaxy-workflow-executor"
inputs:
  - id: accessible
    type:
      - 'null'
      - boolean
    doc: Keep result history and make it accessible via link only.
    inputBinding:
      position: 101
      prefix: --accessible
  - id: allowed_errors
    type:
      - 'null'
      - File
    doc: Yaml file with allowed steps that can have errors.
    inputBinding:
      position: 101
      prefix: --allowed-errors
  - id: conf
    type: File
    doc: A yaml file describing the galaxy credentials
    inputBinding:
      position: 101
      prefix: --conf
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: galaxy_instance
    type:
      - 'null'
      - string
    doc: Galaxy server instance name
    inputBinding:
      position: 101
      prefix: --galaxy-instance
  - id: history
    type: string
    doc: Name of the history to create
    inputBinding:
      position: 101
      prefix: --history
  - id: keep_histories
    type:
      - 'null'
      - boolean
    doc: Keeps histories created, they will be purged if not.
    inputBinding:
      position: 101
      prefix: --keep-histories
  - id: keep_workflow
    type:
      - 'null'
      - boolean
    doc: Keeps workflow created, it will be purged if not.
    inputBinding:
      position: 101
      prefix: --keep-workflow
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: parameters
    type:
      - 'null'
      - string
    doc: parameters file, by default json
    default: json
    inputBinding:
      position: 101
      prefix: --parameters
  - id: parameters_yaml
    type:
      - 'null'
      - boolean
    doc: read parameters file as yaml instead of json
    inputBinding:
      position: 101
      prefix: --parameters-yaml
  - id: publish
    type:
      - 'null'
      - boolean
    doc: Keep result history and make it public/accesible.
    inputBinding:
      position: 101
      prefix: --publish
  - id: state_file
    type:
      - 'null'
      - File
    doc: Path to read and save the execution state file.
    inputBinding:
      position: 101
      prefix: --state-file
  - id: workflow
    type: string
    doc: Workflow to run
    inputBinding:
      position: 101
      prefix: --workflow
  - id: yaml_inputs_path
    type: File
    doc: Path to Yaml detailing inputs
    inputBinding:
      position: 101
      prefix: --yaml-inputs-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
stdout: galaxy-workflow-executor_run_galaxy_workflow.py.out
