cwlVersion: v1.2
class: CommandLineTool
baseCommand: REPmask
label: damasker_REPmask
doc: "Repeat masking tool\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs:
  - id: source_db
    type: string
    doc: Source database
    inputBinding:
      position: 1
  - id: overlaps_las
    type:
      type: array
      items: File
    doc: Overlapping LAS files
    inputBinding:
      position: 2
  - id: cutoff_depth
    type: int
    doc: cutoff depth for declaring an interval repetitive.
    inputBinding:
      position: 103
      prefix: -c
  - id: repeat_track_name
    type:
      - 'null'
      - string
    doc: use this name as for the repeat mask track
    inputBinding:
      position: 103
      prefix: -n
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_REPmask.out
