cwlVersion: v1.2
class: CommandLineTool
baseCommand: ixIxx
label: ucsc-ixixx
doc: "Create indices for a simple line-oriented file of format <symbol> <free text>.
  The output is a word index (out.ix) and an index into the index (out.ixx).\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_text
    type: File
    doc: Input text file, each line is a symbol followed by free text
    inputBinding:
      position: 1
  - id: out_ix
    type: string
    doc: Output word index file name (.ix)
    inputBinding:
      position: 2
  - id: out_ixx
    type: string
    doc: Output index into the word index, file name (.ixx)
    inputBinding:
      position: 3
  - id: prefix_size
    type:
      - 'null'
      - int
    doc: Size of prefix to index on in ixx. Default is 5.
    inputBinding:
      position: 101
      prefix: -prefixSize=
      separate: false
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Size of bins in ixx. Default is 64k.
    inputBinding:
      position: 101
      prefix: -binSize=
      separate: false
  - id: max_word_length
    type:
      - 'null'
      - int
    doc: Maximum allowed word length. Words with more characters than this limit
      are ignored and will not appear in the index or be searchable. Default is
      31.
    inputBinding:
      position: 101
      prefix: -maxWordLength=
      separate: false
outputs:
  - id: out_out_ix
    type: File
    doc: Word index file
    outputBinding:
      glob: $(inputs.out_ix)
  - id: out_out_ixx
    type: File
    doc: Index into the word index
    outputBinding:
      glob: $(inputs.out_ixx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ixixx:482--h0b57e2e_0
