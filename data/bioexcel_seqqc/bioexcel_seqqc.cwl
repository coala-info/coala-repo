cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioexcel_seqqc
label: bioexcel_seqqc
doc: "BioExcel Sequence Quality Control tool (Note: The provided help text contains
  only system logs and an execution error; no specific usage information or arguments
  were found in the input).\n\nTool homepage: https://github.com/bioexcel/bioexcel_seqqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioexcel_seqqc:0.6--py_0
stdout: bioexcel_seqqc.out
