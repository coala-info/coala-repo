cwlVersion: v1.2
class: CommandLineTool
baseCommand: flapjack
label: flapjack
doc: "Flapjack is a tool for graphical genotype visualization and analysis.\n\nTool
  homepage: https://ics.hutton.ac.uk/flapjack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flapjack:1.20.10.07--hdfd78af_1
stdout: flapjack.out
