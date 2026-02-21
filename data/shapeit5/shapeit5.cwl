cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit5
label: shapeit5
doc: "The provided text is a system error log and does not contain a description of
  the tool.\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
stdout: shapeit5.out
