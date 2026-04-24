cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ac-diamond
  - makedb
label: ac-diamond_makedb
doc: "Build AC-DIAMOND database from a FASTA file\n\nTool homepage: https://github.com/Maihj/AC-DIAMOND"
inputs:
  - id: block_size
    type:
      - 'null'
      - float
    doc: reference sequence block size in billions of letters
    inputBinding:
      position: 101
      prefix: --block-size
  - id: input_reference
    type: File
    doc: input reference file in FASTA format
    inputBinding:
      position: 101
      prefix: --in
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: enable building index for sensitive mode (default:fast)
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: threads
    type:
      - 'null'
      - int
    doc: number of cpu threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose out
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
