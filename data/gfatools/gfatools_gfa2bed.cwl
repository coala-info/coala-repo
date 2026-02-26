cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfatools
  - gfa2bed
label: gfatools_gfa2bed
doc: "Convert GFA to BED format\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
  - id: merge_adjacent
    type:
      - 'null'
      - boolean
    doc: merge adjacent intervals on stable sequences
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_gfa2bed.out
