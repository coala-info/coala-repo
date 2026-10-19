cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rebar
  - dataset
  - list
label: rebar_dataset_list
doc: "List the datasets that rebar can download.

Tool homepage: https://github.com/phac-nml/rebar"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "Dataset name"
    inputBinding:
      position: 1
      prefix: --name
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Control output verbosity level (info, warn, debug, error). Default is info"
    inputBinding:
      position: 90
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
stdout: rebar_dataset_list.out
