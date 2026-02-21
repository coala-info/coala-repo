cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualrepair
label: qualrepair
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/clintval/qualrepair"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualrepair:1.0.0--pyhdfd78af_0
stdout: qualrepair.out
