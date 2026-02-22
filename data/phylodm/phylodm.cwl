cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylodm
label: phylodm
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to pull or run a container due to lack of disk
  space.\n\nTool homepage: https://github.com/aaronmussig/PhyloDM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodm:3.2.0--py310hec43fc7_1
stdout: phylodm.out
