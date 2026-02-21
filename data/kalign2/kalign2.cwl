cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign2
label: kalign2
doc: "Kalign is a fast and accurate multiple sequence alignment algorithm. (Note:
  The provided text contains system error messages and does not include help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: http://msa.sbc.su.se/cgi-bin/msa.cgi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalign2:2.04--h7b50bb2_8
stdout: kalign2.out
