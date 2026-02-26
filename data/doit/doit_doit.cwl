cwlVersion: v1.2
class: CommandLineTool
baseCommand: doit_doit
label: doit_doit
doc: "Run tasks defined in a dodo.py file.\n\nTool homepage: https://github.com/sloria/doitlive"
inputs:
  - id: dodo_file
    type:
      - 'null'
      - File
    doc: Specify the dodo file name. Defaults to 'dodo.py'.
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doit:0.29.0--py27_0
stdout: doit_doit.out
