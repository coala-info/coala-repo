cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - index
label: bwa_index
doc: "Index database sequences in the FASTA format\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: input_fasta
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'BWT construction algorithm: bwtsw, is or rb2'
    default: auto
    inputBinding:
      position: 102
      prefix: -a
  - id: block_size
    type:
      - 'null'
      - int
    doc: block size for the bwtsw algorithm (effective with -a bwtsw)
    default: 10000000
    inputBinding:
      position: 102
      prefix: -b
  - id: index_64
    type:
      - 'null'
      - boolean
    doc: index files named as <in.fasta>.64.* instead of <in.fasta>.*
    inputBinding:
      position: 102
      prefix: '-6'
outputs:
  - id: prefix
    type:
      - 'null'
      - File
    doc: prefix of the index [same as fasta name]
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
