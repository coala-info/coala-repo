cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgmlst-dists
label: cgmlst-dists
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/tseemann/cgmlst-dists"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgmlst-dists:0.4.0--h7b50bb2_5
stdout: cgmlst-dists.out
