cwlVersion: v1.2
class: CommandLineTool
baseCommand: fixelconnectivity
label: mrtrix3_fixelconnectivity
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3_fixelconnectivity.out
