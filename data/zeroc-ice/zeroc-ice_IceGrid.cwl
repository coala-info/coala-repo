cwlVersion: v1.2
class: CommandLineTool
baseCommand: icegrid
label: zeroc-ice_IceGrid
doc: "The provided text is an error log from a container build process and does not
  contain help information or command-line arguments for the tool.\n\nTool homepage:
  https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_IceGrid.out
