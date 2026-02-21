cwlVersion: v1.2
class: CommandLineTool
baseCommand: hansel
label: bio_hansel_hansel
doc: "Subtyping of Salmonella Enteritidis and Salmonella Heidelberg from whole-genome
  sequencing data\n\nTool homepage: https://github.com/phac-nml/bio_hansel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio_hansel:2.6.1--py_0
stdout: bio_hansel_hansel.out
