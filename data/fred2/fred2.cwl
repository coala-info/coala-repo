cwlVersion: v1.2
class: CommandLineTool
baseCommand: fred2
label: fred2
doc: "A Framework for Epitope Detection and Immunoinformatics\n\nTool homepage: http://nf-co.re/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fred2:2.0.7--py_0
stdout: fred2.out
