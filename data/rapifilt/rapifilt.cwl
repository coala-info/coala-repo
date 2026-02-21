cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapifilt
label: rapifilt
doc: "The provided text does not contain help information for rapifilt; it is a log
  of a container build failure.\n\nTool homepage: https://github.com/andvides/RAPIFILT.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapifilt:1.0--h5ca1c30_7
stdout: rapifilt.out
