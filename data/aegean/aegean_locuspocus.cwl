cwlVersion: v1.2
class: CommandLineTool
baseCommand: locuspocus
label: aegean_locuspocus
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://github.com/BrendelGroup/AEGeAn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
stdout: aegean_locuspocus.out
