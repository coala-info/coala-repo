cwlVersion: v1.2
class: CommandLineTool
baseCommand: show
label: bart_show
doc: "Outputs values or meta data.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: string
    doc: Input
    inputBinding:
      position: 1
  - id: dimension
    type:
      - 'null'
      - string
    doc: show size of dimension
    inputBinding:
      position: 102
      prefix: -d
  - id: format
    type:
      - 'null'
      - string
    doc: use <format> as the format.
    default: '%+e%+ei'
    inputBinding:
      position: 102
      prefix: -f
  - id: separator
    type:
      - 'null'
      - string
    doc: use <sep> as the separator
    inputBinding:
      position: 102
      prefix: -s
  - id: show_meta_data
    type:
      - 'null'
      - boolean
    doc: show meta data
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_show.out
