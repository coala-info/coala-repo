cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsa
label: fsa
doc: "Fast Statistical Alignment\n\nTool homepage: http://fsa.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fsa:1.15.9--h5ca1c30_5
stdout: fsa.out
