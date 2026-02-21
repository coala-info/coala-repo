cwlVersion: v1.2
class: CommandLineTool
baseCommand: lovis4u
label: lovis4u
doc: "Loci Visualisation for you (lovis4u) - A tool for the visualization of genomic
  loci.\n\nTool homepage: https://art-egorov.github.io/lovis4u/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lovis4u:0.1.7--pyh7e72e81_0
stdout: lovis4u.out
