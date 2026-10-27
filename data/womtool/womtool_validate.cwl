cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - womtool
  - validate
label: womtool_validate
doc: "Validate a workflow source file. If inputs are provided then 'validate' also checks that the inputs file is a valid set of inputs for the workflow.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs:
  - id: workflow_source
    type: File
    doc: Path to workflow file.
    inputBinding:
      position: 1
  - id: inputs_file
    type:
      - 'null'
      - File
    doc: Workflow inputs file.
    inputBinding:
      position: 0
      prefix: --inputs
  - id: list_dependencies
    type:
      - 'null'
      - boolean
    doc: An optional flag to list files referenced in import statements.
    inputBinding:
      position: 0
      prefix: --list-dependencies
outputs:
  - id: stdout
    type: stdout
    doc: Validation result printed by womtool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_validate.out
