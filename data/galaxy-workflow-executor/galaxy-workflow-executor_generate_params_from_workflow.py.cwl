cwlVersion: v1.2
class: CommandLineTool
baseCommand: generate_params_from_workflow.py
label: galaxy-workflow-executor_generate_params_from_workflow.py
doc: "Generate parameters from a Galaxy workflow.\n\nTool homepage: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor"
inputs:
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
  - id: include_internals
    type:
      - 'null'
      - boolean
    doc: Include internal parameters
    inputBinding:
      position: 101
      prefix: --include-internals
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Path to output directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: workflow
    type: File
    doc: Galaxy workflow file (JSON) to run
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ if (inputs.output_dir) { return [{class: "Directory", basename: inputs.output_dir, listing: []}]; } else { return []; } }'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
stdout: galaxy-workflow-executor_generate_params_from_workflow.py.out
