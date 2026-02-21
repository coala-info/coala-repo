cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign2_kalign
doc: "Kalign is a fast multiple sequence alignment tool. (Note: The provided help
  text contains a system error message and does not list command-line arguments.)\n
  \nTool homepage: http://msa.sbc.su.se/cgi-bin/msa.cgi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalign2:2.04--h7b50bb2_8
stdout: kalign2_kalign.out
