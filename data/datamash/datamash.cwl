cwlVersion: v1.2
class: CommandLineTool
baseCommand: datamash
label: datamash
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/agordon/datamash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datamash:1.9
stdout: datamash.out
