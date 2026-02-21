cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapidnj
label: rapidnj
doc: "Rapid Neighbor-Joining (NJ) tree construction\n\nTool homepage: http://birc.au.dk/software/rapidnj/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapidnj:v2.3.2--h2d50403_0
stdout: rapidnj.out
