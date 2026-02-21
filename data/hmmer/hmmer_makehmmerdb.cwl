cwlVersion: v1.2
class: CommandLineTool
baseCommand: makehmmerdb
label: hmmer_makehmmerdb
doc: "build a HMMER binary-formatted database from an input sequence file\n\nTool
  homepage: http://hmmer.org/"
inputs:
  - id: seqfile
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: bin_length
    type:
      - 'null'
      - int
    doc: bin length (power of 2; 32<=b<=4096)
    default: 256
    inputBinding:
      position: 102
      prefix: --bin_length
  - id: block_size
    type:
      - 'null'
      - int
    doc: input sequence broken into blocks this size (Mbases)
    default: 50
    inputBinding:
      position: 102
      prefix: --block_size
  - id: informat
    type:
      - 'null'
      - string
    doc: specify that input file is in format <s>
    inputBinding:
      position: 102
      prefix: --informat
  - id: sa_freq
    type:
      - 'null'
      - int
    doc: suffix array sample rate (power of 2)
    default: 8
    inputBinding:
      position: 102
      prefix: --sa_freq
outputs:
  - id: binaryfile
    type: File
    doc: Output HMMER binary-formatted database file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
