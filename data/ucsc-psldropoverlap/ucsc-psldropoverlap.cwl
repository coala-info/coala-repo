cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslDropOverlap
label: ucsc-psldropoverlap
doc: "Remove overlapping psl records, keeping the best ones.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_psl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: near_top
    type:
      - 'null'
      - int
    doc: Only keep records within N of the best score
    inputBinding:
      position: 102
      prefix: -nearTop
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: Don't include PSL header in the output
    inputBinding:
      position: 102
      prefix: -noHead
outputs:
  - id: output_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psldropoverlap:482--h0b57e2e_0
