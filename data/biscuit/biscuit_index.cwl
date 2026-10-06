cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - index
label: biscuit_index
doc: "Index a reference genome for BISCUIT alignment\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'BWT construction algorithm: bwtsw, div, or is'
    inputBinding:
      position: 102
      prefix: -a
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of the index [same as fasta name]
    inputBinding:
      position: 102
      prefix: -p
  - id: use_64bit_index
    type:
      - 'null'
      - boolean
    doc: Index files named as <in.fasta>.64.* instead of <in.fasta>*
    inputBinding:
      position: 102
      prefix: '-6'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: indexed_fasta
    type: File
    doc: The input FASTA with the index files as secondary files (default 
      prefix)
    outputBinding:
      glob: $(inputs.input_fasta.basename)
    secondaryFiles:
      - pattern: .bis.amb
        required: false
      - pattern: .bis.ann
        required: false
      - pattern: .bis.pac
        required: false
      - pattern: .dau.bwt
        required: false
      - pattern: .dau.sa
        required: false
      - pattern: .par.bwt
        required: false
      - pattern: .par.sa
        required: false
  - id: index_files
    type:
      type: array
      items: File
    doc: All index files written (<prefix>.bis.*, .dau.*, .par.*)
    outputBinding:
      glob: "$((inputs.prefix ? inputs.prefix : inputs.input_fasta.basename) + '.*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_index.out
