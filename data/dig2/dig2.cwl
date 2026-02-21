cwlVersion: v1.2
class: CommandLineTool
baseCommand: dig2
label: dig2
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: http://www.ms-utils.org/dig2/dig2.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dig2:1.0--h7b50bb2_7
stdout: dig2.out
