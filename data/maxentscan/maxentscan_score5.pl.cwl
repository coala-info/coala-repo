cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxentscan_score5.pl
label: maxentscan_score5.pl
doc: "A tool for scoring 5' splice sites using Maximum Entropy Modeling. Note: The
  provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/esebesty/maxentscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxentscan:0_2004.04.21--pl526_1
stdout: maxentscan_score5.pl.out
