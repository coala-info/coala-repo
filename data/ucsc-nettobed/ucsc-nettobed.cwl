cwlVersion: v1.2
class: CommandLineTool
baseCommand: netToBed
label: ucsc-nettobed
doc: "Convert target coverage of net to a bed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
  - id: out_bed
    type: string
    doc: Output bed file
    inputBinding:
      position: 2
  - id: max_gap
    type:
      - 'null'
      - int
    doc: break up at gaps of given size or more
    inputBinding:
      position: 0
      prefix: -maxGap=
      separate: false
  - id: min_fill
    type:
      - 'null'
      - int
    doc: only include fill of given size of above.
    inputBinding:
      position: 0
      prefix: -minFill=
      separate: false
outputs:
  - id: output_bed
    type: File
    doc: Output bed file
    outputBinding:
      glob: $(inputs.out_bed)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nettobed:482--h0b57e2e_0
