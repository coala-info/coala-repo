cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, coverage]
label: mumemto_coverage
doc: "Aggregates MUM coverage from mumemto output.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums
    type: File
    doc: "Path to the *.mums file from mumemto"
    inputBinding:
      position: 100
      prefix: --mums
  - id: lengths
    type:
      - 'null'
      - File
    doc: "Lengths file, first column is the sequence length in the order of the filelist"
    inputBinding:
      position: 100
      prefix: --lengths
  - id: len_filter
    type:
      - 'null'
      - int
    doc: Only consider MUMs longer than this threshold
    inputBinding:
      position: 100
      prefix: --len-filter
  - id: seq_idx
    type:
      - 'null'
      - int
    doc: Sequence index to compute coverage for
    inputBinding:
      position: 100
      prefix: --seq-idx
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 100
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: coverage
    type: stderr
    doc: Coverage report (the tool prints it to standard error)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_coverage.out
stderr: mumemto_coverage.err
