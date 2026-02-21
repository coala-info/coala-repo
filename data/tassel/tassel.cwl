cwlVersion: v1.2
class: CommandLineTool
baseCommand: tassel
label: tassel
doc: "TASSEL (Trait Analysis by aSSociation, Evolution and Linkage) is a software
  package used to evaluate genotype and phenotype data.\n\nTool homepage: http://www.maizegenetics.net/tassel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tassel:5.2.89--hdfd78af_0
stdout: tassel.out
