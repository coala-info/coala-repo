cwlVersion: v1.2
class: CommandLineTool
baseCommand: maskOutFa
label: ucsc-maskoutfa
doc: "Produce a masked .fa file given an unmasked .fa and a RepeatMasker .out file,\
  \ or a .bed file to mask on.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: mask_file
    type:
      - File
      - string
    doc: Mask file; it can end in .out (RepeatMasker) or .bed. It can also be the
      word 'hard', in which case lower case letters are converted to N's.
    inputBinding:
      position: 2
  - id: out_fa_masked
    type: string
    doc: Output masked FASTA file name
    inputBinding:
      position: 3
  - id: soft
    type:
      - 'null'
      - boolean
    doc: Puts masked parts in lower case, other in upper.
    inputBinding:
      position: 101
      prefix: -soft
  - id: soft_add
    type:
      - 'null'
      - boolean
    doc: Lower cases masked bits, leaves others unchanged.
    inputBinding:
      position: 101
      prefix: -softAdd
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Clip out of bounds mask records rather than dying.
    inputBinding:
      position: 101
      prefix: -clip
  - id: mask_format
    type:
      - 'null'
      - string
    doc: '"out" or "bed" for when input does not have required extension.'
    inputBinding:
      position: 101
      prefix: -maskFormat=
      separate: false
outputs:
  - id: out_out_fa_masked
    type: File
    doc: Output masked FASTA file
    outputBinding:
      glob: $(inputs.out_fa_masked)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maskoutfa:482--h0b57e2e_0
