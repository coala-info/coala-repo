cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta-utils
  - split
label: mgkit_fasta-utils_split
doc: "Splits a FASTA file in a number of fragments\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for the file name in output (default: split)'
    inputBinding:
      position: 101
      prefix: -p
  - id: number
    type:
      - 'null'
      - int
    doc: 'Number of chunks into which split the FASTA file (default: 10)'
    inputBinding:
      position: 101
      prefix: -n
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: gzip output files
    inputBinding:
      position: 101
      prefix: -z
  - id: fasta_file
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 102
outputs:
  - id: chunks
    type:
      type: array
      items: File
    doc: FASTA chunks.
    outputBinding:
      glob: '$(inputs.prefix === null || inputs.prefix === undefined ? ''split'' : inputs.prefix)*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
