cwlVersion: v1.2
class: CommandLineTool
baseCommand: matlock
label: matlock
doc: "A tool for processing and manipulating proximity ligation data (e.g., Hi-C,
  Capture-C).\n\nTool homepage: https://github.com/phasegenomics/matlock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matlock:20181227--h665f8ca_8
stdout: matlock.out
