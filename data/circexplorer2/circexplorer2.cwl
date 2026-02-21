cwlVersion: v1.2
class: CommandLineTool
baseCommand: CIRCexplorer2
label: circexplorer2
doc: "CIRCexplorer2 is a comprehensive and professional software for circular RNA
  (circRNA) identification and characterization.\n\nTool homepage: https://github.com/YangLab/CIRCexplorer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circexplorer2:2.3.8--py_0
stdout: circexplorer2.out
