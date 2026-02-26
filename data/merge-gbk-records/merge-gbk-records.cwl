cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge-gbk-records
label: merge-gbk-records
doc: "Merge GenBank records with a defined spacer sequence\n\nTool homepage: http://github.com/kblin/merge-gbk-records"
inputs:
  - id: records
    type:
      type: array
      items: File
    doc: A GenBank file to merge
    inputBinding:
      position: 1
  - id: spacer_length
    type:
      - 'null'
      - int
    doc: Length of the spacer in kbp
    default: '20'
    inputBinding:
      position: 102
      prefix: --length
  - id: spacer_sequence
    type:
      - 'null'
      - string
    doc: Spacer sequence to use, can be Ns or all-frame stop codons
    default: n
    inputBinding:
      position: 102
      prefix: --spacer
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file to write to, or 'stdout' to write to terminal
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merge-gbk-records:0.2.0--pyhdfd78af_0
