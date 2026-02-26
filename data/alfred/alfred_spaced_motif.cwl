cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - spaced_motif
label: alfred_spaced_motif
doc: "Identify and join spaced motifs from motif hits\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: motif_hits
    type: File
    doc: Input motif hits file (gzipped)
    inputBinding:
      position: 1
  - id: motif1
    type:
      - 'null'
      - string
    doc: motif1 name
    default: Heptamer
    inputBinding:
      position: 102
      prefix: --motif1
  - id: motif2
    type:
      - 'null'
      - string
    doc: motif2 name
    default: Nonamer
    inputBinding:
      position: 102
      prefix: --motif2
  - id: spacer_high
    type:
      - 'null'
      - int
    doc: max. spacer length
    default: 13
    inputBinding:
      position: 102
      prefix: --spacer-high
  - id: spacer_low
    type:
      - 'null'
      - int
    doc: min. spacer length
    default: 11
    inputBinding:
      position: 102
      prefix: --spacer-low
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: joined motif hits
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
