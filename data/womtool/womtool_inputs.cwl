cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - womtool
  - inputs
label: womtool_inputs
doc: "Generate and output a new inputs JSON for this workflow.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs:
  - id: workflow_source
    type: File
    doc: Path to workflow file.
    inputBinding:
      position: 1
  - id: optional_inputs
    type:
      - 'null'
      - string
    doc: "If set, optional inputs are also included in the inputs set. Default is 'true'."
    inputBinding:
      position: 0
      prefix: --optional-inputs
outputs:
  - id: stdout
    type: stdout
    doc: Result printed by womtool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_inputs.out
