cwlVersion: v1.2
class: CommandLineTool
baseCommand: export2graphlan
label: export2graphlan
doc: "The provided text does not contain help information for the tool; it is a system
  error message indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/segatalab/export2graphlan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/export2graphlan:0.22--py_0
stdout: export2graphlan.out
