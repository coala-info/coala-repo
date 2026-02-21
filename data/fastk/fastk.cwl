cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastk
label: fastk
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/thegenemyers/FASTK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_0
stdout: fastk.out
