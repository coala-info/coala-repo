cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifihla align-imgt
label: hifihla_align-imgt
doc: "Align queries to IMGT/HLA genomic accession sequences\n\nTool homepage: https://github.com/PacificBiosciences/hifihla"
inputs:
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Exact target name matches only (default starts-with)
    inputBinding:
      position: 101
      prefix: --exact
  - id: fasta
    type: File
    doc: Fasta with query sequence(s)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Alternative to repeated -v/--verbose: set log level via key. Equivalence
      to -v/--verbose: => "Warn" => "Info" -vv => "Debug" -vvv => "Trace"'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: qids
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-sep query IDs
    inputBinding:
      position: 101
      prefix: --qids
  - id: targets
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-sep target IDs (map refs)
    inputBinding:
      position: 101
      prefix: --targets
  - id: threads
    type:
      - 'null'
      - int
    doc: Analysis threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tnames
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-sep target Names (map refs)
    inputBinding:
      position: 101
      prefix: --tnames
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
stdout: hifihla_align-imgt.out
