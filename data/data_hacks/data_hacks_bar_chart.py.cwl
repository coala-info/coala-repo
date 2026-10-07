cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bar_chart.py
label: data_hacks_bar_chart.py
doc: "Draw an ASCII bar chart of how often each value (one per line) occurs in the
  input, read from stdin.\n\nTool homepage: https://github.com/bitly/data_hacks"
inputs:
  - id: input_file
    type: File
    doc: Input data, one value per line (or two columns with --agg / 
      --agg-key-value); passed to the tool on stdin
  - id: agg
    type:
      - 'null'
      - boolean
    doc: Two column input format, space seperated with value<space>key
    inputBinding:
      position: 102
      prefix: --agg
  - id: agg_key_value
    type:
      - 'null'
      - boolean
    doc: Two column input format, space seperated with key<space>value
    inputBinding:
      position: 102
      prefix: --agg-key-value
  - id: sort_keys
    type:
      - 'null'
      - boolean
    doc: sort by the key [default]
    inputBinding:
      position: 102
      prefix: --sort-keys
  - id: sort_values
    type:
      - 'null'
      - boolean
    doc: sort by the frequence
    inputBinding:
      position: 102
      prefix: --sort-values
  - id: reverse_sort
    type:
      - 'null'
      - boolean
    doc: reverse the sort
    inputBinding:
      position: 102
      prefix: --reverse-sort
  - id: numeric_sort
    type:
      - 'null'
      - boolean
    doc: sort keys by numeric sequencing
    inputBinding:
      position: 102
      prefix: --numeric-sort
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: List percentage for each bar
    inputBinding:
      position: 102
      prefix: --percentage
outputs:
  - id: stdout
    type: stdout
    doc: ASCII bar chart
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdin: $(inputs.input_file.path)
stdout: data_hacks_bar_chart.py.out
