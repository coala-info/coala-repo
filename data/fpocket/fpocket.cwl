cwlVersion: v1.2
class: CommandLineTool
baseCommand: fpocket
label: fpocket
doc: "The provided text does not contain help information for fpocket; it is an error
  log indicating a failure to build or pull a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/Discngine/fpocket"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocket:4.0.0
stdout: fpocket.out
