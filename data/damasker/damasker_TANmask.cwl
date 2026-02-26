cwlVersion: v1.2
class: CommandLineTool
baseCommand: TANmask
label: damasker_TANmask
doc: "Report tandem repeats\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs:
  - id: source_db
    type: string
    doc: source:db
    inputBinding:
      position: 1
  - id: overlaps_las
    type:
      type: array
      items: string
    doc: overlaps:las
    inputBinding:
      position: 2
  - id: shortest_tandem_interval
    type:
      - 'null'
      - int
    doc: shortest tandem interval to report.
    default: 500
    inputBinding:
      position: 103
      prefix: -l
  - id: tandem_mask_track_name
    type:
      - 'null'
      - string
    doc: use this name as for the tandem mask track
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
stdout: damasker_TANmask.out
