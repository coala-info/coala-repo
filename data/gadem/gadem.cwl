cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadem
label: gadem
doc: "Genetic Algorithm Guided De novo Motif Discovery\n\nTool homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/gadem/index.cfm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadem:1.3.1--h7b50bb2_8
stdout: gadem.out
