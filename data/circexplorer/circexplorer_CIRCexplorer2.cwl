cwlVersion: v1.2
class: CommandLineTool
baseCommand: CIRCexplorer2
label: circexplorer_CIRCexplorer2
doc: "CIRCexplorer2 is a tool for circular RNA identification and characterization.
  (Note: The provided help text contains only container build error logs and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/YangLab/CIRCexplorer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circexplorer:1.1.10--py35_0
stdout: circexplorer_CIRCexplorer2.out
