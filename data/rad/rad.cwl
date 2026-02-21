cwlVersion: v1.2
class: CommandLineTool
baseCommand: rad
label: rad
doc: "The provided text does not contain help information or usage instructions for
  the tool 'rad'. It appears to be a log of a failed container build or image fetch
  process.\n\nTool homepage: https://github.com/indianewok/rad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rad:0.6.0--h077b44d_0
stdout: rad.out
