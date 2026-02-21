cwlVersion: v1.2
class: CommandLineTool
baseCommand: damasker
label: damasker
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker.out
