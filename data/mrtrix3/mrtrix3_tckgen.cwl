cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckgen
label: mrtrix3_tckgen
doc: "The provided text does not contain help information for the tool. It contains
  error logs indicating a failure to pull or build a container image due to insufficient
  disk space.\n\nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3_tckgen.out
