cwlVersion: v1.2
class: CommandLineTool
baseCommand: epic2
label: epic2
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs indicating a failure to build the image due to insufficient
  disk space.\n\nTool homepage: http://github.com/endrebak/epic2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epic2:0.0.54--py310h5140242_0
stdout: epic2.out
