cwlVersion: v1.2
class: CommandLineTool
baseCommand: minisplice
label: minisplice
doc: "The provided text does not contain help information or usage instructions for
  minisplice; it is an error log indicating a failure to pull or build the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/lh3/minisplice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
stdout: minisplice.out
