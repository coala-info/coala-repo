cwlVersion: v1.2
class: CommandLineTool
baseCommand: LAshow
label: daligner_LAshow
doc: "Display local alignments produced by daligner in a human-readable format.\n\n
  Tool homepage: https://github.com/thegenemyers/DALIGNER"
inputs:
  - id: src
    type: File
    doc: The source database or dam file (.db or .dam)
    inputBinding:
      position: 1
  - id: align
    type:
      - 'null'
      - File
    doc: The alignment file (.las)
    inputBinding:
      position: 2
  - id: reads
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional range of reads to display
    inputBinding:
      position: 3
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: Show all alignments
    inputBinding:
      position: 104
      prefix: -a
  - id: border
    type:
      - 'null'
      - int
    doc: Border size for the alignment display
    default: 10
    inputBinding:
      position: 104
      prefix: -b
  - id: coordinates
    type:
      - 'null'
      - boolean
    doc: Show coordinates
    inputBinding:
      position: 104
      prefix: -c
  - id: indent
    type:
      - 'null'
      - boolean
    doc: Indent the alignment
    inputBinding:
      position: 104
      prefix: -i
  - id: list_format
    type:
      - 'null'
      - boolean
    doc: Display in list format
    inputBinding:
      position: 104
      prefix: -l
  - id: only_overlaps
    type:
      - 'null'
      - boolean
    doc: Show only overlaps
    inputBinding:
      position: 104
      prefix: -o
  - id: show_alignment
    type:
      - 'null'
      - boolean
    doc: Show the alignment
    inputBinding:
      position: 104
      prefix: -s
  - id: trace_points
    type:
      - 'null'
      - boolean
    doc: Show trace points
    inputBinding:
      position: 104
      prefix: -t
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: Show sequences in upper case
    inputBinding:
      position: 104
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
  - id: width
    type:
      - 'null'
      - int
    doc: Width of the alignment display
    default: 100
    inputBinding:
      position: 104
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_LAshow.out
