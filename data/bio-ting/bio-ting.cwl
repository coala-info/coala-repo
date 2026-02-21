cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-ting
label: bio-ting
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/FelixMoelder/ting"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-ting:1.1.0--py_0
stdout: bio-ting.out
