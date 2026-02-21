cwlVersion: v1.2
class: CommandLineTool
baseCommand: owl
label: owl
doc: "A tool for sequence analysis (Oligo-Word-Lattice), typically used in bioinformatics
  for processing sequencing data.\n\nTool homepage: https://github.com/PacificBiosciences/owl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
stdout: owl.out
