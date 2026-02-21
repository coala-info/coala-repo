cwlVersion: v1.2
class: CommandLineTool
baseCommand: data_hacks_bar_chart.py
label: data_hacks_bar_chart.py
doc: "A command line tool for creating bar charts from input data.\n\nTool homepage:
  https://github.com/bitly/data_hacks"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing data points (defaults to stdin if not provided)
    inputBinding:
      position: 1
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Aggregate data
    inputBinding:
      position: 102
      prefix: --agg
  - id: format
    type:
      - 'null'
      - string
    doc: Format of the output
    inputBinding:
      position: 102
      prefix: --format
  - id: keys
    type:
      - 'null'
      - boolean
    doc: Data contains keys
    inputBinding:
      position: 102
      prefix: --keys
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: Sort numerically
    inputBinding:
      position: 102
      prefix: --numeric
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse the sort order
    inputBinding:
      position: 102
      prefix: --reverse
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort the output
    inputBinding:
      position: 102
      prefix: --sort
  - id: width
    type:
      - 'null'
      - int
    doc: Width of the bar chart
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdout: data_hacks_bar_chart.py.out
