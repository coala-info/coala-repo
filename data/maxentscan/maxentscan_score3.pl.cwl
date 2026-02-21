cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxentscan_score3.pl
label: maxentscan_score3.pl
doc: "A tool for scoring 3' splice sites using the Maximum Entropy Model. Note: The
  provided help text contains system error messages and does not list specific arguments.\n
  \nTool homepage: https://github.com/esebesty/maxentscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxentscan:0_2004.04.21--pl526_1
stdout: maxentscan_score3.pl.out
