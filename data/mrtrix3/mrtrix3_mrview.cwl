cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrview
label: mrtrix3_mrview
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3_mrview.out
