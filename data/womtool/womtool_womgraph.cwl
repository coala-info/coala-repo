cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - womtool
  - womgraph
label: womtool_womgraph
doc: "(Advanced) Generate and output a graph visualization of Cromwell's internal Workflow Object Model structure for this workflow in .dot format.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
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
stdout: womtool_womgraph.out
