cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc
label: fmlrc
doc: "FMLRC (FM-index Long Read Corrector) is a tool for correcting long read sequencing
  data using a BWT/FM-index of short read data.\n\nTool homepage: https://github.com/holtjma/fmlrc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc:1.0.0--h9948957_6
stdout: fmlrc.out
