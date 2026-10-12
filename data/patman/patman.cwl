cwlVersion: v1.2
class: CommandLineTool
baseCommand: patman
label: patman
doc: "PatMaN: pattern matching in nucleotide databases. Rapid alignment of short
  sequences (patterns) to large databases, allowing for a specific number of edits
  and gaps.\n\nTool homepage: https://bioinf.eva.mpg.de/patman/"
inputs:
  - id: databases
    type:
      type: array
      items: File
    doc: Database files (FASTA); passed after -D
    inputBinding:
      position: 102
      prefix: -D
  - id: patterns
    type:
      type: array
      items: File
    doc: Files that contain the patterns (FASTA); passed after -P
    inputBinding:
      position: 103
      prefix: -P
  - id: ambicodes
    type:
      - 'null'
      - boolean
    doc: Interpret ambiguity codes in patterns
    inputBinding:
      position: 101
      prefix: --ambicodes
  - id: edits
    type:
      - 'null'
      - int
    doc: 'Set maximum edit distance to N (default: 2)'
    inputBinding:
      position: 101
      prefix: --edits
      separate: false
      valueFrom: =$(self)
  - id: gaps
    type:
      - 'null'
      - int
    doc: 'Set maximum number of gaps to N (default: 0)'
    inputBinding:
      position: 101
      prefix: --gaps
      separate: false
      valueFrom: =$(self)
  - id: prefetch
    type:
      - 'null'
      - int
    doc: 'Prefetch N nodes (default: 3)'
    inputBinding:
      position: 101
      prefix: --prefetch
      separate: false
      valueFrom: =$(self)
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: singlestrand
    type:
      - 'null'
      - boolean
    doc: Do not match reverse-complements
    inputBinding:
      position: 101
      prefix: --singlestrand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional progress reports
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: Write output to FILE
    inputBinding:
      position: 100
      prefix: --output
      separate: false
      valueFrom: =$(self)
outputs:
  - id: output
    type: File
    doc: Alignments of the patterns to the databases
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/patman:v1.2.2dfsg-5-deb_cv1
