cwlVersion: v1.2
class: CommandLineTool
baseCommand: quatradis_tradis
label: quatradis_tradis
doc: "This script contains a number of tools for running or supporting TraDIS experiments.\n\
  \nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: tool
    type: string
    doc: 'Available Tradis Tools: plot, compare, pipeline, utils'
    inputBinding:
      position: 1
  - id: tool_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected Tradis Tool
    inputBinding:
      position: 2
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Turn on profiling. Prints out cumulative time in each function to 
      stdout and to an output file (tradis.profile). The profile file can be 
      read by tools such as snakeviz.
    inputBinding:
      position: 103
      prefix: --profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis.out
