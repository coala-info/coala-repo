cwlVersion: v1.2
class: CommandLineTool
baseCommand: patman
label: patman
doc: "A tool for rapid alignment of short sequences (patterns) to large databases,
  allowing for a specific number of edits and gaps.\n\nTool homepage: https://github.com/Patman86/x265-Mod-by-Patman"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files (databases or patterns)
    inputBinding:
      position: 1
  - id: ambicodes
    type:
      - 'null'
      - boolean
    doc: Interpret ambiguity codes in patterns
    inputBinding:
      position: 102
      prefix: --ambicodes
  - id: databases
    type:
      - 'null'
      - boolean
    doc: Following files are databases
    inputBinding:
      position: 102
      prefix: --databases
  - id: edits
    type:
      - 'null'
      - int
    doc: Set maximum edit distance to N
    inputBinding:
      position: 102
      prefix: --edits
  - id: gaps
    type:
      - 'null'
      - int
    doc: Set maximum number of gaps to N
    inputBinding:
      position: 102
      prefix: --gaps
  - id: patterns
    type:
      - 'null'
      - boolean
    doc: Following files contain patterns
    inputBinding:
      position: 102
      prefix: --patterns
  - id: prefetch
    type:
      - 'null'
      - int
    doc: Prefetch N nodes
    inputBinding:
      position: 102
      prefix: --prefetch
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: singlestrand
    type:
      - 'null'
      - boolean
    doc: Do not match reverse-complements
    inputBinding:
      position: 102
      prefix: --singlestrand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional progress reports
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/patman:v1.2.2dfsg-5-deb_cv1
