cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeat-match
label: mummer4_repeat-match
doc: "Find all maximal exact matches in a genome file.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: Use exhaustive (slow) search to find matches
    inputBinding:
      position: 10
      prefix: -E
  - id: forward_only
    type:
      - 'null'
      - boolean
    doc: "Forward strand only, do not use the reverse complement"
    inputBinding:
      position: 10
      prefix: -f
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum exact match length
    inputBinding:
      position: 10
      prefix: -n
  - id: tandem_only
    type:
      - 'null'
      - boolean
    doc: Only output tandem repeats
    inputBinding:
      position: 10
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: Level of verbose (debugging) printing
    inputBinding:
      position: 10
      prefix: -V
  - id: genome_file
    type: File
    doc: Genome file (FASTA)
    inputBinding:
      position: 201
outputs:
  - id: repeats
    type: stdout
    doc: Repeat matches (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_repeat-match.out
