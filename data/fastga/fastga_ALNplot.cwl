cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNplot
label: fastga_ALNplot
doc: "Plots alignments from various formats.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: alignment_file
    type: File
    doc: Path to the alignment file (.1aln, .paf, .paf.gz)
    inputBinding:
      position: 1
  - id: selection_or_file
    type:
      - 'null'
      - type: array
        items: string
    doc: Selection string or file path for additional alignments
    inputBinding:
      position: 2
  - id: image_height
    type:
      - 'null'
      - int
    doc: image height
    inputBinding:
      position: 103
      prefix: -H
  - id: image_width
    type:
      - 'null'
      - int
    doc: image width
    inputBinding:
      position: 103
      prefix: -W
  - id: label_font_size
    type:
      - 'null'
      - int
    doc: label font size
    inputBinding:
      position: 103
      prefix: -f
  - id: line_thickness
    type:
      - 'null'
      - float
    doc: line thickness
    inputBinding:
      position: 103
      prefix: -t
  - id: max_lines
    type:
      - 'null'
      - int
    doc: maximum number of lines to display (set '0' to force all)
    inputBinding:
      position: 103
      prefix: -n
  - id: min_alignment_identity
    type:
      - 'null'
      - float
    doc: minimum alignment identity
    inputBinding:
      position: 103
      prefix: -i
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: minimum alignment length
    inputBinding:
      position: 103
      prefix: -l
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: do not print labels
    inputBinding:
      position: 103
      prefix: -L
  - id: print_sequence_ids
    type:
      - 'null'
      - boolean
    doc: print sequence IDs as labels instead of names
    inputBinding:
      position: 103
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: use -T threads
    inputBinding:
      position: 103
      prefix: -T
outputs:
  - id: pdf_output
    type:
      - 'null'
      - File
    doc: make PDF output (requires '[e]ps[to|2]pdf')
    outputBinding:
      glob: $(inputs.pdf_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
