cwlVersion: v1.2
class: CommandLineTool
baseCommand: Profex
label: fastk_Profex
doc: "Profex\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source_root
    type: string
    doc: Source root file (optionally with .prof extension)
    inputBinding:
      position: 1
  - id: read_ranges
    type:
      - 'null'
      - type: array
        items: string
    doc: Read ranges to process
    inputBinding:
      position: 2
  - id: compress_runs_ignore_zeros
    type:
      - 'null'
      - boolean
    doc: Compress runs and ignore zeros.
    inputBinding:
      position: 103
      prefix: -z
  - id: produce_1_code
    type:
      - 'null'
      - boolean
    doc: Produce 1-code as output.
    inputBinding:
      position: 103
      prefix: '-1'
  - id: tab_delimited_ascii
    type:
      - 'null'
      - boolean
    doc: tab-delimited ASCII as output.
    inputBinding:
      position: 103
      prefix: -A
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Profex.out
