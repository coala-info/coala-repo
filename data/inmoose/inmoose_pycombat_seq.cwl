cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq
label: inmoose_pycombat_seq
doc: "Print numbers from FIRST to LAST, in steps of INCREMENT.\n\nTool homepage: https://github.com/epigenelabs/inmoose"
inputs:
  - id: first
    type:
      - 'null'
      - float
    doc: The starting number of the sequence. Defaults to 1 if omitted.
    inputBinding:
      position: 1
  - id: last
    type: float
    doc: The ending number of the sequence.
    inputBinding:
      position: 2
  - id: increment
    type:
      - 'null'
      - float
    doc: The step between numbers. Defaults to 1 if omitted.
    inputBinding:
      position: 3
  - id: equal_width
    type:
      - 'null'
      - boolean
    doc: Equalize width by padding with leading zeroes
    inputBinding:
      position: 104
      prefix: --equal-width
  - id: format
    type:
      - 'null'
      - string
    doc: Use printf style floating-point FORMAT
    inputBinding:
      position: 104
      prefix: --format
  - id: separator
    type:
      - 'null'
      - string
    doc: Use STRING to separate numbers
    inputBinding:
      position: 104
      prefix: --separator
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inmoose:0.9.1--py311hc1104ee_0
stdout: inmoose_pycombat_seq.out
