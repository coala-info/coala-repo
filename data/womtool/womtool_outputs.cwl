cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - womtool
  - outputs
label: womtool_outputs
doc: "Generate and output a list of output types in JSON for this workflow.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs:
  - id: workflow_source
    type: File
    doc: Path to workflow file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Result printed by womtool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_outputs.out
