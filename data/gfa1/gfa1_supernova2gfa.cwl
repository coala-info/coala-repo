cwlVersion: v1.2
class: CommandLineTool
baseCommand: supernova2gfa
label: gfa1_supernova2gfa
doc: "Convert a Supernova assembly graph (.snfa) to GFA.\n\nTool homepage: https://github.com/lh3/gfa1"
inputs:
  - id: input_snfa
    type: File
    doc: "Input snfa file"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: "GFA written to standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1_supernova2gfa.gfa
