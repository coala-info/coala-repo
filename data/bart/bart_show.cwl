cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, show]
requirements:
  - class: InlineJavascriptRequirement
label: bart_show
doc: "Outputs values or meta data.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: Input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: dimension
    type:
      - 'null'
      - int
    doc: show size of dimension
    inputBinding:
      position: 1
      prefix: -d
  - id: format
    type:
      - 'null'
      - string
    doc: use <format> as the format.
    inputBinding:
      position: 1
      prefix: -f
  - id: separator
    type:
      - 'null'
      - string
    doc: use <sep> as the separator
    inputBinding:
      position: 1
      prefix: -s
  - id: show_meta_data
    type:
      - 'null'
      - boolean
    doc: show meta data
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_show.out
