cwlVersion: v1.2
class: CommandLineTool
baseCommand: mupbwt
label: mupbwt
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/dlcgold/muPBWT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mupbwt:0.1.2--h5ca1c30_5
stdout: mupbwt.out
