cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligomap
label: oligomap
doc: "A tool for mapping oligonucleotides to a genome. Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/zavolanlab/oligomap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligomap:1.0.1--h077b44d_2
stdout: oligomap.out
