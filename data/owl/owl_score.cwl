cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - owl
  - score
label: owl_score
doc: "Score profiles\n\nTool homepage: https://github.com/PacificBiosciences/owl"
inputs:
  - id: cov
    type:
      - 'null'
      - float
    doc: Coefficient of variance cutoff
    default: 5
    inputBinding:
      position: 101
      prefix: --cov
  - id: input_file
    type: File
    doc: Input file to score
    inputBinding:
      position: 101
      prefix: --file
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Min depth
    default: 5
    inputBinding:
      position: 101
      prefix: -m
  - id: min_pass
    type:
      - 'null'
      - int
    doc: Min percentage sites for QC
    default: 50
    inputBinding:
      position: 101
      prefix: --min-pass
  - id: minimize
    type:
      - 'null'
      - boolean
    doc: Canonicalize motifs (reverse complement, and rotate, keeping lowest)
    inputBinding:
      position: 101
      prefix: --minimize
  - id: prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Only score these samples
    inputBinding:
      position: 101
      prefix: --samples
  - id: unphased
    type:
      - 'null'
      - boolean
    doc: Exclude unphased reads
    inputBinding:
      position: 101
      prefix: --unphased
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
stdout: owl_score.out
