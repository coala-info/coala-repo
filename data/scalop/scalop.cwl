cwlVersion: v1.2
class: CommandLineTool
baseCommand: scalop
label: scalop
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/oxpig/SCALOP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scalop:2021.01.27--py_0
stdout: scalop.out
