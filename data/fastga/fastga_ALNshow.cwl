cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNshow
label: fastga_ALNshow
doc: "Show alignments\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: alignments
    type: File
    doc: Input alignments file
    inputBinding:
      position: 1
  - id: selection_file
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional selection or file(s) to process
    inputBinding:
      position: 2
  - id: bordering_bp
    type:
      - 'null'
      - int
    doc: '# of bordering bp.s to show on each side of LA.'
    default: 10
    inputBinding:
      position: 103
      prefix: -b
  - id: indent_spaces
    type:
      - 'null'
      - int
    doc: Indent alignments by -i spaces.
    default: 4
    inputBinding:
      position: 103
      prefix: -i
  - id: row_width
    type:
      - 'null'
      - int
    doc: Width of each row of alignment in symbols (-a) or bps (-r).
    default: 100
    inputBinding:
      position: 103
      prefix: -w
  - id: show_la_with_a_bp
    type:
      - 'null'
      - boolean
    doc: Show the alignment of each LA with -w bp's of A in each row.
    inputBinding:
      position: 103
      prefix: -r
  - id: show_la_with_width
    type:
      - 'null'
      - boolean
    doc: Show the alignment of each LA with -w columns in each row.
    inputBinding:
      position: 103
      prefix: -a
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: Show alignments in upper case.
    inputBinding:
      position: 103
      prefix: -U
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNshow.out
