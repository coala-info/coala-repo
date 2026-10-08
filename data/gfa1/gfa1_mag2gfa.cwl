cwlVersion: v1.2
class: CommandLineTool
baseCommand: mag2gfa
label: gfa1_mag2gfa
doc: "Convert a MAG assembly graph to GFA.\n\nTool homepage: https://github.com/lh3/gfa1"
inputs:
  - id: fermi_native_mag
    type:
      - 'null'
      - boolean
    doc: "Fermi's native MAG format"
    inputBinding:
      position: 1
      prefix: -m
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: "don't output sequence in GFA (effective w/o -m)"
    inputBinding:
      position: 1
      prefix: -S
  - id: input_mag
    type: File
    doc: "Input MAG file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "GFA written to standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1_mag2gfa.gfa
