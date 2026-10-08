cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastg2gfa
label: gfa1_fastg2gfa
doc: "Convert a FASTG assembly graph to GFA.\n\nTool homepage: https://github.com/lh3/gfa1"
inputs:
  - id: input_fastg
    type: File
    doc: "Input FASTG file"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: "GFA written to standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1_fastg2gfa.gfa
