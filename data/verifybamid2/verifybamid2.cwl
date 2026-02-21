cwlVersion: v1.2
class: CommandLineTool
baseCommand: verifybamid2
label: verifybamid2
doc: "VerifyBamID2 is a tool for detecting and estimating DNA contamination in sequencing
  data.\n\nTool homepage: https://github.com/Griffan/VerifyBamID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifybamid2:2.0.1--h32f71e1_2
stdout: verifybamid2.out
