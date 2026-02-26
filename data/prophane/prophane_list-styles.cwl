cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophane_list-styles
label: prophane_list-styles
doc: "Styles available in \"/usr/local/opt/prophane/styles\"\n\nTool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs:
  - id: source
    type:
      - 'null'
      - string
    doc: Source of the style
    inputBinding:
      position: 1
  - id: report_style
    type:
      - 'null'
      - string
    doc: Name of the report style file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane_list-styles.out
