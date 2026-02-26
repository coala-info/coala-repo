cwlVersion: v1.2
class: CommandLineTool
baseCommand: qgrs-cpp_qgrs
label: qgrs-cpp_qgrs
doc: "Finds and analyzes G-quadruplexes (QGRS) in a DNA sequence.\n\nTool homepage:
  https://github.com/freezer333/qgrs-cpp"
inputs:
  - id: csv_mode
    type:
      - 'null'
      - boolean
    doc: output in csv mode
    inputBinding:
      position: 101
      prefix: -csv
  - id: include_overlapping
    type:
      - 'null'
      - boolean
    doc: include overlapping QGRS in output (very large outputs may be 
      generated)
    inputBinding:
      position: 101
      prefix: -v
  - id: input_filename
    type:
      - 'null'
      - File
    doc: read input from a file as specified (defaults to stdin)
    inputBinding:
      position: 101
      prefix: -i
  - id: json_mode
    type:
      - 'null'
      - boolean
    doc: output in JSON mode
    inputBinding:
      position: 101
      prefix: -json
  - id: min_g_score
    type:
      - 'null'
      - int
    doc: filter output to QGRS with g-score equal to or greater than n
    default: 17
    inputBinding:
      position: 101
      prefix: -s
  - id: min_tetrads
    type:
      - 'null'
      - int
    doc: filter output to QGRS with number tetrads equal to or greater than n
    default: 2
    inputBinding:
      position: 101
      prefix: -t
  - id: omit_column_titles
    type:
      - 'null'
      - boolean
    doc: omit column titles in output (does not apply to JSON)
    inputBinding:
      position: 101
      prefix: -notitle
  - id: replace_g_char
    type:
      - 'null'
      - string
    doc: replace all G characters within tetrads with given character.
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: write output to file as specified (defaults to stdout)
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qgrs-cpp:1.0--h503566f_5
