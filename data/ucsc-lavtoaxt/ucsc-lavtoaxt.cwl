cwlVersion: v1.2
class: CommandLineTool
baseCommand: lavToAxt
label: ucsc-lavtoaxt
doc: "Convert blastz lav file to an axt file (which includes sequence). tNibDir and
  qNibDir are either directories full of nib files, or a single twoBit file.\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_lav
    type: File
    doc: Input lav file
    inputBinding:
      position: 1
  - id: t_nib
    type: File
    doc: Target sequence, a single twoBit file (or a fasta file of multiple dna
      sequences with the tfa option)
    inputBinding:
      position: 2
  - id: q_nib
    type: File
    doc: Query sequence, a single twoBit file (or a fasta file of multiple dna
      sequences with the fa option)
    inputBinding:
      position: 3
  - id: out_axt
    type: string
    doc: Output axt file name
    inputBinding:
      position: 4
  - id: fa
    type:
      - 'null'
      - boolean
    doc: qNibDir is interpreted as a fasta file of multiple dna seq instead of
      directory of nibs
    inputBinding:
      position: 101
      prefix: -fa
  - id: tfa
    type:
      - 'null'
      - boolean
    doc: tNibDir is interpreted as a fasta file of multiple dna seq instead of
      directory of nibs
    inputBinding:
      position: 101
      prefix: -tfa
  - id: drop_self
    type:
      - 'null'
      - boolean
    doc: drops alignment blocks on the diagonal for self alignments
    inputBinding:
      position: 101
      prefix: -dropSelf
  - id: score_scheme
    type:
      - 'null'
      - File
    doc: Read the scoring matrix from a blastz-format file (only used in
      conjunction with dropSelf, to rescore alignments when blocks are dropped)
    inputBinding:
      position: 101
      prefix: -scoreScheme=
      separate: false
outputs:
  - id: out_out_axt
    type: File
    doc: Output axt file
    outputBinding:
      glob: $(inputs.out_axt)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-lavtoaxt:482--h0b57e2e_0
